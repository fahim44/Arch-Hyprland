#!/bin/bash
# SDDM themes #

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
LOG="Install-Logs/install-$(date +%d-%H%M%S)_sddm_theme_astronaut.log"

# SDDM-themes
printf "${INFO} Installing ${SKY_BLUE}Additional SDDM Astronaut Theme${RESET}\n"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/keyitdev/sddm-astronaut-theme/master/setup.sh)"

echo "${OK} - ${MAGENTA}Additional ${YELLOW}Astronaut SDDM Theme${RESET} successfully installed." | tee -a "$LOG"

printf "\n%.0s" {1..2}

