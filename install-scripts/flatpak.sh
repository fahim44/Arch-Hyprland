#!/bin/bash
# tmux #

flatpak_pkg=(
	flatpak
)

flathub_pkg=(
	im.riot.Riot
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
LOG="Install-Logs/install-$(date +%d-%H%M%S)_flatpak.log"

# Installing core flatpak packages
printf "\n%s - Installing ${SKY_BLUE}flatpak packages${RESET} .... \n" "${NOTE}"
for FLATPAK in "${flatpak_pkg[@]}"; do
	install_package "$FLATPAK" "$LOG"
done


# Installing  flathub packages
printf "\n%s - Installing ${SKY_BLUE}flatpak packages from flathub${RESET} .... \n" "${NOTE}"
for FLATHUB in "${flathub_pkg[@]}"; do
	flatpak install flathub "$FLATHUB" -y
done

printf "\n%.0s" {1..2}
