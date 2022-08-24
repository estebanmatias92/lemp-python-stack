# https://earthly.dev/blog/python-makefile/
# https://gist.github.com/Flushot/5784719

.PHONY: run create_env install update freeze clean uninstall remove

# Global Variables
VENV := venv
PYTHON := $(VENV)/bin/python3
#PYTHON := python3
PIP := $(VENV)/bin/pip --require-virtualenv
#PIP := pip
VENVACTIVATE := $(VENV)/bin/activate
REQSFILE := requirements.txt

# COLORS
GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
WHITE  := $(shell tput -Txterm setaf 7)
RESET  := $(shell tput -Txterm sgr0)

# Show help
help:
	@echo ''
	@echo 'Usage:'
	@echo '    ${YELLOW}make${RESET} <target>'
	@echo ''
	@echo 'Targets:'
	@echo '    build           Create the environment, installs the dependencies required and start the program'
	@echo '    run             Run the program from the app.py script with the local python interpreter'
	@echo '    create_env      Create local python environment with pip'
	@echo '    install         Install locally, the lastest version of depdendencies and update the requirements.txt file'
	@echo '    update          Update the requirements.txt with modules imported in the project and updates all dependencies and reqs file'
	@echo '    freeze          Update the requirements.txt file with the dependencies at the moment'
	@echo '    clean           Remove __pycache__ and environment folders and files'
	@echo '    uninstall       Uninstall all the environments and update the requirements.txt'
	@echo '    remove          Runs -make uninstall && make clean- together'
	@echo ''	



# Recipes
# First command to build the project
build: create_env install run


# Run the root script
run:
	$(PYTHON) app.py


# Upgrade pip and create new python environment
create_env:
	python3 -m pip install --upgrade pip
	python3 -m venv $(VENV)


# Upgrade pip, install pipreqs and the install every dependency in the project and update the requirements.txt file
install:
	./$(PYTHON) -m pip install --upgrade pip
	. $(VENVACTIVATE) && $(PIP) install pipreqs
	. $(VENVACTIVATE) && $(PIP) install -U -r $(REQSFILE) && $(PIP) install -U -r ./requirements/*
	make -s freeze
	. $(VENVACTIVATE) && $(PIP) list


# Dinamically update requirements.txt base on imported modules in .py files, update .txt list and upgrade every package to it's latest version
update:
	. $(VENVACTIVATE) && pipreqs --force
	. $(VENVACTIVATE) && $(PIP) install -U -r $(REQSFILE) && $(PIP) install -U -r ./requirements/*
	make -s freeze
	. $(VENVACTIVATE) && $(PIP) list

# Update requirements.txt file with all the dependencies installed in the environment
freeze:
	. $(VENVACTIVATE) && $(PIP) freeze > $(REQSFILE)


# Remove environment and cache
clean:
	rm -rf __pycache__ 
	rm -rf $(VENV)
	

# Uninstall every package in requirements.txt
uninstall: 
	$(PIP) uninstall --no-cache-dir -y -r $(REQSFILE)
	make -s freeze


# Remove (uninstall) every package and environment and remove cache folders
remove:
	if [ -d $(VENV) ]; then make uninstall; make clean; fi