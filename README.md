## Python Docker Dev Environment

An isolated Docker Development Environment for building Python Apps.

## Use

### 1 - Create Docker Dev Environment

Use this github url to create the Docker Dev Environment in Docker Desktop.

### 2 - Open with VS Code

Once created the Environment, open it with VS Code

### 3 - Create a new Python project

In the root folder of this project, you can run the Python CLI commands and create with a new environment

*`python -m venv venv && . venv/bin/activate`*

Proceed to install the all dependencies

*`pip install -r requirements.txt`*

### 4 - Tipical pip commands

You can just install one dependency

*`pip install flask`*

To list the packages installed

*`pip list`*

To update the requirements.txt file with the current dependencies installed

*`pip freeze > requirements.txt`*

You can also upgrade the dependencies of this project

*`pip install -U -r requirements.txt`*

And also uninstall a package

*`pip uninstall flask`*

Or all the packages

*`pip uninstall -r requirements.txt`*

#### (Inside Docker Desktop Dev Environment)

You have an alias to use in replacement for . venv/bin/activate

*`activate`*

You have a function to run the app through an entrypoint

*`run`*

## Clarifications

### Git

To use git like you normally do in your host machine, you have to have:
- Docker Desktop ***"WSL 2 based engine"*** option enabled
- Your ***github credentials*** configured in your default WSL2 distro