## Python Docker Compose Stack

An isolated Docker Compose Environment for building Python Apps.
Just one service from Python:3.9 image with PDM installed, ready to work.
Spin up the stack, attach your terminal to the service TTY and work with your IDE from your host machine.

## Use

### 1 - Start up the stack

_`docker compose --env-file .env.dev -f compose-dev.yaml up --watch`_

This will start the services, keep the files in sync, watch for rebuilds, and show you the services's logs.

### 2 - Enter the service terminal

Open another terminal and run:

_`docker compose --env-file .env.dev -f compose-dev.yaml exec app bash`_

This will give you access to the **app** service terminal inside the workdir (project root directory).

### 3 - Create a Python project

Once inside the container you can run PDM commands and create a new project.

_`pdm init [template]`_

You can now dd package(s) to pyproject.toml and install them

_`pdm add <package> [packages...]`_

And/Or install dependencies from lock file and resolve paths

_`pdm install [packages...]`_

### 4 - Tipical pip commands

To list packages installed in the current working set

_`pdm list`_

Resolve and lock dependencies and update the pdm.lock file

_`pdm lock`_

You can also update package(s) in pyproject.toml

_`pdm update [packages...]`_

And also remove packages from pyproject.toml

_`pdm remove <package> [packages...]`_

## Clarifications

### Git

To use git like you normally do in your host machine, you have to have:

- Docker Desktop **_"WSL 2 based engine"_** option enabled
- Your **_github credentials_** configured in your default WSL2 distro

## Temporary help


To test the database from "app" service, just enter the bash in the app service

_`docker compose exec app bash`_

And run the following command yo show all the databases in the db service

_`mysql --user=$DB_USER --password=$(cat $DB_PASS) --host=$DB_HOST --execute="SHOW DATABASES;"`_


To test it from the "db" service enter the bash

_`docker compose exec db bash`_

And run the following command too

_`mysql --user=$MYSQL_USER --password=$(cat $MYSQL_PASSWORD_FILE) --execute "SHOW DATABASES;"`_