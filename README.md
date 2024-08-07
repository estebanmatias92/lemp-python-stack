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

_`docker compose exec app bash`_

This will give you access to the **app** service terminal inside the workdir (project root directory).

### 3 - Create a Python project

Once inside the container you can run PDM commands and create a new project.

_`pdm init`_

Proceed to install the all dependencies

_`pip install -r requirements.txt`_

### 4 - Tipical pip commands

You can just install one dependency

_`pip install flask`_

To list the packages installed

_`pip list`_

To update the requirements.txt file with the current dependencies installed

_`pip freeze > requirements.txt`_

You can also upgrade the dependencies of this project

_`pip install -U -r requirements.txt`_

And also uninstall a package

_`pip uninstall flask`_

Or all the packages

_`pip uninstall -r requirements.txt`_

#### (Inside Docker Desktop Dev Environment)

You have an alias to use in replacement for . venv/bin/activate

_`activate`_

You have a function to run the app through an entrypoint

_`run`_

## Clarifications

### Git

To use git like you normally do in your host machine, you have to have:

- Docker Desktop **_"WSL 2 based engine"_** option enabled
- Your **_github credentials_** configured in your default WSL2 distro



## Temporary help


To test the database from "app" service, just enter the bash in the app service

_`docker exec app bash`_

And run the following command yo show all the databases in the db service

_`mysql --user=$DB_USER --password=$(cat $DB_PASS) --host=$DB_HOST --execute="SHOW DATABASES;"`_


To test it from the "db" service enter the bash

_`docker exec db bash`_

And run the following command too

_`mysql --user=$MYSQL_USER --password=$(cat $MYSQL_PASSWORD_FILE) --execute "SHOW DATABASES;"`_