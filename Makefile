# https://earthly.dev/blog/python-makefile/
# https://gist.github.com/Flushot/5784719

.PHONY: run create_env install update freeze clean uninstall

# Global Variables
VENV := venv
PYTHON := $(VENV)/bin/python3
#PYTHON := python3
PIP := $(VENV)/bin/pip --require-virtualenv
#PIP := pip
VENVACTIVATE := $(VENV)/bin/activate
REQSFILE := requirements.txt

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
	make -s freeze
	. $(VENVACTIVATE) && $(PIP) install -U -r $(REQSFILE)

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
    if [ -d $(VENV) ]; then make uninstall && make clean; fi