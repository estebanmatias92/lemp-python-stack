#The base image for the container 
FROM python:3.8-slim-bullseye AS base

RUN apt-get update -qqy && \
    apt-get install -qqy python3-dev \
                python3-venv \
                python3-pip \
                git && \
    apt-get upgrade -qqy

ENV DOCKERDEVENVDIRECTORY="/com.docker.devenvironments.code"

# Keeps Python from generating .pyc files in the container 
ENV PYTHONDONTWRITEBYTECODE=1 
 
# Turns off buffering for easier container logging 
ENV PYTHONUNBUFFERED=1 


FROM base AS dev

ENV MYUSERNAME="vscode"

RUN useradd -s /bin/bash -m $MYUSERNAME
RUN groupadd docker && usermod -aG docker $MYUSERNAME

USER $MYUSERNAME

RUN echo 'export PATH="$HOME/.local/bin:$HOME/bin:$DOCKERDEVENVDIRECTORY/env/bin:$PATH"' >> /home/$MYUSERNAME/.bashrc

CMD ["sleep", "infinity"]