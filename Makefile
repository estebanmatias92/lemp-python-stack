# https://earthly.dev/blog/python-makefile/
# https://gist.github.com/Flushot/5784719

.PHONY: run create_env deps freeze clean

# Global Variables
VENV := venv
PYTHON := $(VENV)/bin/python3
#PYTHON := python3
PIP := $(VENV)/bin/pip
#PIP := pip
VENVACTIVATE := $(VENV)/bin/activate

# Recipes
run: deps
	$(PYTHON) app.py


create_env:
	python3 -m venv $(VENV) ; . $(VENVACTIVATE)
	
	
deps: create_env
	. $(VENVACTIVATE) && $(PIP) install -U -r requirements.txt && if [ "$(ls requirements)" ] ; then $(PIP) install -U -r requirements/* ; fi

freeze:
	. $(VENVACTIVATE) && $(PIP) freeze > requirements.txt

clean:
	rm -rf __pycache__
	rm -rf $(VENV)