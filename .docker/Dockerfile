#The base image for the container 
FROM python:3.8-slim-bullseye AS base

RUN apt-get update -qqy && \
    apt-get install -qqy python3-dev \
                python3-venv \
                python3-pip \
                git && \
    apt-get upgrade -qqy

# Get the default Docker Dev Environment HOME directory name
ENV DOCKERDEVENVDIRECTORY="/com.docker.devenvironments.code"

# Keeps Python from generating .pyc files in the container 
ENV PYTHONDONTWRITEBYTECODE=1 
 
# Turns off buffering for easier container logging 
ENV PYTHONUNBUFFERED=1 


FROM base AS dev

# Change user
ENV MYUSERNAME="vscode"

RUN useradd -s /bin/bash -m $MYUSERNAME
RUN groupadd docker && usermod -aG docker $MYUSERNAME

USER $MYUSERNAME

# Add bin directories to PATH
RUN echo 'export PATH="$HOME/.local/bin:$HOME/bin:$DOCKERDEVENVDIRECTORY/env/bin:$PATH"' >> /home/$MYUSERNAME/.bashrc

# Keep the container alive
CMD ["sleep", "infinity"]