#!/bin/bash
# git #

git_pkg=(
	git
	git-lfs
)

## WARNING: DO NOT EDIT BEYOND THIS LINE IF YOU DON'T KNOW WHAT YOU ARE DOING! ##
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Change the working directory to the parent directory of the script
PARENT_DIR="$SCRIPT_DIR/.."
cd "$PARENT_DIR" || {
	echo "${ERROR} Failed to change directory to $PARENT_DIR"
	exit 1
}

# Source the global functions script
if ! source "$(dirname "$(readlink -f "$0")")/Global_functions.sh"; then
	echo "Failed to source Global_functions.sh"
	exit 1
fi

# Set the name of the log file to include the current date and time
LOG="Install-Logs/install-$(date +%d-%H%M%S)_git.log"

# Installing core git packages
printf "\n%s - Installing ${SKY_BLUE}git packages${RESET} .... \n" "${NOTE}"
for GIT in "${git_pkg[@]}"; do
	install_package "$GIT" "$LOG"
done

# Check if ~/.gitconfig exists, create a backup, and copy the new configuration
if [ -f "$HOME/.gitconfig" ]; then
	cp -b "$HOME/.gitconfig" "$HOME/.gitconfig-backup" || true
fi

# Copying the preconfigured git configuration
cp -r 'assets/.gitconfig' "$HOME/"

# setting up git-lfs
printf "\n - Setting up git-lfs ... \n"
git lfs install

printf "\n%.0s" {1..2}
