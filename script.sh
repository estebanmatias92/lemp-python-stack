#!/bin/sh

# And source the app's entrypoint shell script
. ./entrypoint.sh  >/dev/null 2>&1

# Aliases
alias activate=". activate"

# If the VENV has been created but it is not activated, activate it
if  [ -d $VENVPATH ] && [ -z "$VIRTUAL_ENV" ]; then
. activate
fi