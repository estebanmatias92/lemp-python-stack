ARG PYTHON_BASE=3.9

FROM python:${PYTHON_BASE} AS base

# Prevents Python from writing pyc files.
ENV PYTHONDONTWRITEBYTECODE=1

# Keeps Python from buffering stdout and stderr to avoid situations where
# the application crashes without emitting any logs due to buffering.
ENV PYTHONUNBUFFERED=1

ARG USERNAME="python"
ARG PROJECT_DIR="/app"

# Create the group, user and the project directory with permissions
RUN groupadd --system \
                --gid "1000" \
                ${USERNAME} \
    && useradd --system \
                --gid "1000" \
                --shell /bin/bash \
                --uid "1000" \
                --create-home \
                ${USERNAME} \
    && mkdir -p ${PROJECT_DIR} \
    && chown -R ${USERNAME}:${USERNAME} ${PROJECT_DIR} 
    #    # [Optional] Add sudo support. Omit if you don't need to install software after connecting.
    #    && apt-get update \
    #    && apt-get install -y sudo \
    #    && echo ${USERNAME} ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/${USERNAME} \
    #    && chmod 0440 /etc/sudoers.d/${USERNAME}

# Add user binaries to the path
ENV PATH="/home/${USERNAME}/.local/bin:${PATH}"

# ********************************************************
# * Anything else you want to do like clean up goes here *
# ********************************************************

# Set working dir for the next stages
ONBUILD WORKDIR ${PROJECT_DIR}

# Install better package manager
RUN --mount=type=cache,target=/root/.cache/pip \
    pip install -U pdm
               

#
# Development dependencies
#
FROM base AS development

# Install dev tools [as root]
RUN --mount=type=cache,target=/var/cache/apt apt-get update \
    && apt-get install -y --no-install-recommends python3-dev default-libmysqlclient-dev default-mysql-client \
    && apt-get clean

# Python bundlers and tooling
RUN --mount=type=cache,target=/root/.cache/pip \
    pip install cookiecutter copier

# [Optional] Set the default user. Omit if you want to keep the default as root.
USER ${USERNAME}

COPY . .


#
# Build stage
#     
FROM base AS builder

# disable update check
ENV PDM_CHECK_UPDATE=false

# Download dependencies as a separate step to take advantage of Docker's caching.
# Leverage a cache mount to /root/.npm to speed up subsequent builds.
# Leverage a bind mounts to pyproject.toml and pdm.lock to avoid having to copy them into
# into this layer.
RUN --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    --mount=type=bind,source=pdm.lock,target=pdm.lock \
    --mount=type=cache,target=/home/docs/.cache/pdm \
    pdm install --check --prod --no-editable


#
# Production Target Stage 
# Normally called without specifying "target" in compose
#
FROM python:${PYTHON_BASE}-slim AS production

WORKDIR /usr/src/app

ENV PATH="${PWD}/.venv/bin:${PATH}"

# Retrieve packages from build stage
COPY --from=builder ${PROJECT_DIR}/.venv/ ./.venv

COPY src ./src

CMD ["python", "src/__main__.py"]