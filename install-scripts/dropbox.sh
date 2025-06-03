#!/bin/bash
# dropbox #

dropbox_pkg=(
	dropbox
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
LOG="Install-Logs/install-$(date +%d-%H%M%S)_dropbox.log"

# Importing dropbox public key
printf "${INFO} Importing dropbox public keys...\n"  
gpg --import assets/dropbox-public-key.asc

# Installing core tmux packages
printf "\n%s - Installing ${SKY_BLUE}dropbox packages${RESET} .... \n" "${NOTE}"
for DROPBOX in "${dropbox_pkg[@]}"; do
	install_package "$DROPBOX" "$LOG"
done

printf "\n%.0s" {1..2}
