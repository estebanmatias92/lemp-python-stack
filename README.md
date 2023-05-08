## Python Docker Dev Environment

An isolated Docker Development Environment for building Python Apps.

## Use

### 1 - Create Docker Dev Environment

Use this github url to create the Docker Dev Environment in Docker Desktop.

### 2 - Open with VS Code

Once created the Environment, open it with VS Code

### 3 - Create a new Python project

Now from the terminal you can run the Python CLI commands and create with a new environment

*`python -m venv src/venv && . src/venv/bin/activate`*

Proceed to install the first dependencies

*`pip install -r requirements.txt`*

#### (The way to go)

You can save time and effort and use Make to create the project and install the dependencies, and activate the environment immediately afterwards

*`pipe build && . src/venv/bin/activate`*

To run the app, use Make Run

*`pipe run`*

Auto-install imported packages and upgrade all packages

*`pipe update`*

Use help for more commands

*`pipe help`*



## Clarifications

### Git

To use git like you normally do in your host machine, you have to have:
- Docker Desktop ***"WSL 2 based engine"*** option enabled
- Your ***github credentials*** configured in your default WSL2 distro