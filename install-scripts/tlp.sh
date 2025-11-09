#!/bin/bash
# tlp #

tlp=(
	tlp
	tlp-rdw
	smartmontools
	tlpui
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
LOG="Install-Logs/install-$(date +%d-%H%M%S)_tlp.log"

# tlp
printf "${INFO} Installing ${SKY_BLUE}TLP${RESET} Packages...\n"
for TLP in "${tlp[@]}"; do
	install_package "$TLP" "$LOG"
done

printf "\n%.0s" {1..1}

printf "${INFO} Enabling ${SKY_BLUE}TLP Demon${RESET} ...\n"
for drv in NetworkManager NetworkManager-dispatcher tlp; do
	sudo systemctl enable ${drv}
done

printf "\n%.0s" {1..1}

printf "${INFO} Starting ${SKY_BLUE}TLP${RESET} ...\n"
sudo tlp start

printf "\n%.0s" {1..2}
