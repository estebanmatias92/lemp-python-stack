# https://earthly.dev/blog/python-makefile/

.PHONY: run clean

# Global Variables
VENV := /$(notdir $(shell pwd))
#PYTHON := $(VENV)/bin/python3
PYTHON := python3
#PIP := $(VENV)/bin/pip
PIP := pip

# Recipes
run: $(VENV)/bin/activate
	$(PYTHON) app.py


$(VENV)/bin/activate: requirements.txt
	python3 -m venv $(VENV)
	. $(VENV)/bin/activate
	$(PIP) install -r requirements.txt


clean:
	rm -rf __pycache__
	rm -rf $(VENV)