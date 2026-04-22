#!/bin/bash
set -e

source "$(dirname "$0")/../lib/color.sh"
source "$(dirname "$0")/../lib/core.sh"

parse_args "$@"

info "Installing Bluetooth stack"

bt_pkgs=(
    bluez
    bluez-utils
)

run_cmd sudo pacman -S  --needed "${bt_pkgs[@]}"

run_cmd sudo systemctl enable bluetooth
run_cmd sudo systemctl start bluetooth

success "bluetooth setup completed"
