#!/bin/sh

# Updating the PATH with project's-specific bin folders
export PATH=$PATH:$HOME/bin:$HOME/.local/bin:$ROOTDIR/bin:$VENVPATH/bin

# Aliases
alias activate=". activate"

# Source custom binaries
. ./bin/lib/runsub >/dev/null 2>&1
# And source the app's entrypoint shell script
. ./entrypoint.sh  >/dev/null 2>&1