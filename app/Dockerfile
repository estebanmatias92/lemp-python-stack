ARG PYTHON_BASE=3.9

#The base image for the container 
FROM python:$PYTHON_BASE AS base

# Will ONLY be available in the inherited stages
ONBUILD ARG PROJECT_ROOT=/project

# Keeps Python from generating .pyc files in the container 
ENV PYTHONDONTWRITEBYTECODE=1  
# Turns off buffering for easier container logging 
ENV PYTHONUNBUFFERED=1 

# install PDM
RUN pip install -U pdm


#
# Development dependencies
#
FROM base AS development

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
&& useradd --uid $USER_UID --gid $USER_GID -m $USERNAME 
#    #
#    # [Optional] Add sudo support. Omit if you don't need to install software after connecting.
#    && apt-get update \
#    && apt-get install -y sudo \
#    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
#    && chmod 0440 /etc/sudoers.d/$USERNAME

# ********************************************************
# * Anything else you want to do like clean up goes here *
# ********************************************************

# Install dev tools [as root]
RUN --mount=type=cache,target=/var/cache/apt apt-get update \
    && apt-get install -y \
    python3-dev \
    default-libmysqlclient-dev \
    default-mysql-client \
    && apt-get clean

# [Optional] Set the default user. Omit if you want to keep the default as root.
USER $USERNAME

# If you want to use watch, first copy the files
COPY --chown=$USERNAME:$USER_GID ./ $PROJECT_ROOT

# Keep the container alive
CMD ["sleep", "infinity"]


#
# Build stage
#     
FROM base AS builder

# disable update check
ENV PDM_CHECK_UPDATE=false
# copy files
COPY pyproject.toml pdm.lock README.md $PROJECT_ROOT/
COPY src/ $PROJECT_ROOT/src

# install dependencies and project into the local packages directory
WORKDIR $PROJECT_ROOT
RUN pdm install --check --prod --no-editable


#
# Production Target Stage 
# Normally called without specifying "target" in compose
#
FROM python:${PYTHON_BASE}-slim AS production

# retrieve packages from build stage
COPY --from=builder $PROJECT_ROOT/.venv/ $PROJECT_ROOT/.venv
ENV PATH="$PROJECT_ROOT/.venv/bin:$PATH"
# set command/entrypoint, adapt to fit your needs
COPY src $PROJECT_ROOT/src
CMD ["python", "src/__main__.py"]