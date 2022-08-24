#The base image for the container 
FROM python:3 AS base

# Install base libraries
RUN apt-get update && apt-get install -y --no-install-recommends \
        python3-pip \
        python3-venv \
    && apt-get clean

# Keeps Python from generating .pyc files in the container 
ENV PYTHONDONTWRITEBYTECODE=1 
 
# Turns off buffering for easier container logging 
ENV PYTHONUNBUFFERED=1 

#
# DEV STAGE
#

FROM base AS dev

# Install dev tools
RUN apt-get update && apt-get install -y --no-install-recommends \
        git \
        python3-dev \
    && apt-get clean 

#
# VSCODE STAGE
#

FROM dev AS vscode

# Get the default Docker Dev Environment HOME directory name
ENV DOCKERDEVENVDIRECTORY="/com.docker.devenvironments.code"

# Change user
ENV MYUSERNAME="vscode"

RUN useradd -s /bin/bash -m $MYUSERNAME
RUN groupadd docker && usermod -aG docker $MYUSERNAME

USER $MYUSERNAME

# Add bin directories to PATH
RUN echo 'export PATH="$HOME/.local/bin:$HOME/bin:$DOCKERDEVENVDIRECTORY/env/bin:$PATH"' >> /home/$MYUSERNAME/.bashrc

# Keep the container alive
CMD ["sleep", "infinity"]
