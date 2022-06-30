#The base image for the container 
FROM python:3.8-slim-bullseye AS base

RUN apt update -qqy && \
    apt install -qqy python3-dev \
                python3-venv \
                python-pip && \
    apt upgrade -qqy

RUN python3 -m venv env && \
    source env/bin/activate

# Keeps Python from generating .pyc files in the container 
ENV PYTHONDONTWRITEBYTECODE=1 
 
# Turns off buffering for easier container logging 
ENV PYTHONUNBUFFERED=1 
 
# Copy python requirements to the docker container and install
COPY ../requirements.txt . 

RUN python -m pip install -r requirements.txt 



FROM base as dev

COPY . .

RUN useradd -s /bin/bash -m vscode
RUN groupadd docker && usermod -aG docker vscode

USER vscode

ENTRYPOINT ["sleep", "infinity"]