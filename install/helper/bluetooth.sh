#!/bin/bash
set -e
BASE_DIR="$(cd "$(dirname "$0")/../.." && pwd)"
source "$BASE_DIR/install/lib/color.sh"
source "$BASE_DIR/install/lib/core.sh"
source "$BASE_DIR/install/lib/errors.sh"

setup_error_trap
parse_args "$@"

info "Installing Bluetooth stack"
bt_pkgs=(bluez bluez-utils)
run_task "Installing Bluetooth packages" sudo pacman -S --needed --noconfirm "${bt_pkgs[@]}"
run_task "Enabling Bluetooth service" sudo systemctl enable bluetooth
run_task "Starting Bluetooth service" sudo systemctl start bluetooth
success "bluetooth setup completed"
