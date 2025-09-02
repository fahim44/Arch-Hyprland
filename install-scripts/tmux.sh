#!/bin/bash
# tmux #

tmux_pkg=(
	tmux
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
LOG="Install-Logs/install-$(date +%d-%H%M%S)_tmux.log"

# Installing core tmux packages
printf "\n%s - Installing ${SKY_BLUE}tmux packages${RESET} .... \n" "${NOTE}"
for TMUX in "${tmux_pkg[@]}"; do
	install_package "$TMUX" "$LOG"
done

# Check if ~/.tmux.conf exists, create a backup, and copy the new configuration
if [ -f "$HOME/.tmux.conf" ]; then
	cp -b "$HOME/.tmux.conf" "$HOME/.tmux.conf-backup" || true
fi

# Copying the preconfigured tmux configuration
cp -r 'assets/.tmux.conf' "$HOME/"

printf "\n%.0s" {1..2}
