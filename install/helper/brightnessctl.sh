#!/bin/bash
set -e
BASE_DIR="$(cd "$(dirname "$0")/../.." && pwd)"
source "$BASE_DIR/install/lib/color.sh"
source "$BASE_DIR/install/lib/core.sh"
source "$BASE_DIR/install/lib/errors.sh"

setup_error_trap
parse_args "$@"

info "Installing brightnessctl"
run_task "Installing brightnessctl" sudo pacman -S --needed --noconfirm brightnessctl
if ! groups "$USER" | grep -q video; then
    run_task "Adding user to video group" sudo usermod -aG video "$USER"
fi
success "brightness setup completed"
