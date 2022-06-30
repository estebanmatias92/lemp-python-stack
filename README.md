# Python Docker Dev Environment

An isolated Docker Development Environment for building Python Apps.

## Use

### 1 - Create Docker Dev Environment

Use this github url to create the Docker Dev Environment in Docker Desktop.

### 2 - Open with VS Code

Once created the Environment, open it with VS Code

### 3 - Create a new Python project

Now from the terminal you can run the Python CLI commands and create with a new environment

*`python -m venv $(pwd) && . $(pwd)/bin/activate`*

Proceed to install the first dependencies

*`pip install -r requirements.txt`*

And initialize the repository for the Project

*`git init .`*

#### (Running all together)

*`python -m venv $(pwd) && . $(pwd)/bin/activate && pip install -r requirements.txt && git init .`*




## Clarifications

### Git

To use git like you normally do in your host machine, you have to have:
- Docker Desktop ***"WSL 2 based engine"*** option enabled
- Your ***github credentials*** in your WSL2 distro configured