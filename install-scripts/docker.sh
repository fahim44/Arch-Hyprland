#!/bin/bash
# DOcker #
# more details: https://gist.github.com/tatumroaquin/c6464e1ccaef40fd098a4f31db61ab22 #

docker=(
  docker
  docker-compose
  lazydocker
)

kvm=(
  qemu-full
  qemu-img
  libvirt
  virt-install
  virt-manager
  virt-viewer
  edk2-ovmf
  dnsmasq
  swtpm
  guestfs-tools
  libosinfo
  tuned
)

## WARNING: DO NOT EDIT BEYOND THIS LINE IF YOU DON'T KNOW WHAT YOU ARE DOING! ##
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Change the working directory to the parent directory of the script
PARENT_DIR="$SCRIPT_DIR/.."
cd "$PARENT_DIR" || { echo "${ERROR} Failed to change directory to $PARENT_DIR"; exit 1; }

# Source the global functions script
if ! source "$(dirname "$(readlink -f "$0")")/Global_functions.sh"; then
  echo "Failed to source Global_functions.sh"
  exit 1
fi


# Set the name of the log file to include the current date and time
LOG="Install-Logs/install-$(date +%d-%H%M%S)_docker.log"

# Docker
printf "${INFO} Installing ${SKY_BLUE}Docker${RESET} Packages...\n"  
  for DOCKER in "${docker[@]}"; do
    install_package "$DOCKER" "$LOG"
  done

printf "\n%.0s" {1..1}

# kvm
printf "${INFO} Installing ${SKY_BLUE}Kvm${RESET} Packages...\n"  
  for KVM in "${kvm[@]}"; do
    install_package "$KVM" "$LOG"
  done

printf "\n%.0s" {1..1}

printf "${INFO} Enabling ${SKY_BLUE}Kvm Moduler Demon${RESET} ...\n"  
  for drv in qemu interface network nodedev nwfilter secret storage; do
    sudo systemctl enable virt${drv}d.service;
    sudo systemctl enable virt${drv}d{,-ro,-admin}.socket;
  done

printf "\n%.0s" {1..1}

printf "${INFO} After reboot run ${SKY_BLUE}modprobe kvm_intel${RESET} for intel cpu or, ${SKY_BLUE}modprobe kvm_amd${RESET} for amd cpu to modules on karnel ...\n"  

printf "\n%.0s" {1..2}
