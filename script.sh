#!/bin/sh

# And source the app's entrypoint shell script
. ./entrypoint.sh  >/dev/null 2>&1

# Automate the VENV path folder and environment creation
create_env() {
    echo "Creating virtual environment"
    python3 -m venv $VENVPATH
}

# Create the VENV if it doesn't exists
if [ ! -d $VENVPATH ]; then
    create_env
fi

# Aliases
alias activate=". activate"