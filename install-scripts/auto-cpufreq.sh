#!/bin/bash
# auto-cpufreq #

cpu=(
	auto-cpufreq
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
LOG="Install-Logs/install-$(date +%d-%H%M%S)_auto-cpufreq.log"

# tlp
printf "${INFO} Installing ${SKY_BLUE}auto-cpufreq${RESET} Packages...\n"
for CPU in "${cpu[@]}"; do
	install_package "$CPU" "$LOG"
done

printf "\n%.0s" {1..1}

printf "${INFO} Enabling ${SKY_BLUE}auto-cpufreq Demon${RESET} ...\n"
sudo systemctl mask power-profiles-daemon.service
sudo systemctl enable --now auto-cpufreq

printf "\n%.0s" {1..2}
