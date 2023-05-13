#The base image for the container 
FROM python:3.9 AS base
# Keeps Python from generating .pyc files in the container 
ENV PYTHONDONTWRITEBYTECODE=1  
# Turns off buffering for easier container logging 
ENV PYTHONUNBUFFERED=1 


#
# Development dependencies
#
FROM base AS devdeps
# Install dev tools
RUN apt-get update && apt-get install -y --no-install-recommends \
        git \
        python3-dev \
    && apt-get clean


#
# Builder stage for Runtime
#     
FROM base as builder
COPY requirements.txt .
# Install dependencies to the local user directory (eg. /root/.local)
RUN pip install --user --no-cache-dir -r requirements.txt


#
# VS Code Stage 
# (This is preferred to run as a Docker Dev Environment)
#
FROM devdeps AS development
# Modifyble through cli args
ARG WORKDIR=/com.docker.devenvironments.code
ARG USER="vscode"
# Create and change user
RUN useradd -s /bin/bash -m $USER \
    && groupadd docker \
    && usermod -aG docker $USER
USER $USER
# Get the build script commands added to the shell session
COPY --chown=$USER *.sh $WORKDIR/
# Replace the host SSH exe with the WSL distro SSH exe
RUN git config --global --replace-all core.sshCommand "/usr/bin/ssh"
# Add scripts to .bashrc
RUN echo "\n# Add scripts for dev workflow\n. ${WORKDIR}/script.sh" >> $HOME/.bashrc 
# Keep the container alive
CMD ["sleep", "infinity"]


#
# Production Target Stage 
# Normally called without specifying "target" in compose
#
FROM python:3.9-slim as production
WORKDIR /code
# Copy only the dependencies installation from the 1st stage image
COPY --from=builder /root/.local /root/.local
COPY ./src .
# Update PATH environment variable
ENV PATH=/root/.local:$PATH
ENTRYPOINT [ "python3" ]
CMD [ "./app.py" ]
