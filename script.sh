#!/bin/sh

# Updating the PATH with project's-specific bin folders
export PATH=$HOME/.local/bin:$VENVPATH/bin:$PATH

# Automate the VENV path folder and environment creation
create_env() {
    echo "Creating virtual environment"
    python3 -m venv $VENVPATH
}

# And source the app's entrypoint shell script
. ./entrypoint.sh  >/dev/null 2>&1

# Aliases
alias activate=". activate"

# Create the VENV if doesn't exists
if [ ! -d $VENVPATH ]; then
    create_env
fi

# If the VENV has been created but it is not activated, activate it
if  [ -d $VENVPATH ] && [ -z "$VIRTUAL_ENV" ]; then
. activate
fi