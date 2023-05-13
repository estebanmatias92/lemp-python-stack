
# Updating the PATH with project's-specific bin folders
export PATH=$PATH:$HOME/.local/bin:$VENVPATH/bin

# Automate the VENV path folder and environment creation
create_env() {
    echo "Creating virtual environment"
    python3 -m venv $VENVPATH
}

# Create the VENV if it doesn't exists
if [ ! -d $VENVPATH ]; then
    create_env
fi
