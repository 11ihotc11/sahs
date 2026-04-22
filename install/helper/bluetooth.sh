#!/bin/bash
set -e

source "$(dirname "$0")/../lib/color.sh"
source "$(dirname "$0")/../lib/core.sh"
source "$(dirname "$0")/../lib/errors.sh"

setup_error_trap
parse_args "$@"

info "Installing Bluetooth stack"

bt_pkgs=(
    bluez
    bluez-utils
)

run_task "Installing Bluetooth packages" sudo pacman -S --needed --noconfirm "${bt_pkgs[@]}"

run_task "Enabling Bluetooth service" sudo systemctl enable bluetooth
run_task "Starting Bluetooth service" sudo systemctl start bluetooth

success "bluetooth setup completed"
