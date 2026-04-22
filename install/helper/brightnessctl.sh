#!/bin/bash
set -e

source "$(dirname "$0")/../lib/color.sh"
source "$(dirname "$0")/../lib/core.sh"
source "$(dirname "$0")/../lib/errors.sh"

setup_error_trap
parse_args "$@"

info "Installing brightnessctl"

run_task "Installing brightnessctl" sudo pacman -S --needed --noconfirm brightnessctl

if ! groups "$USER" | grep -q video; then
    run_task "Adding user to video group" sudo usermod -aG video "$USER"
fi

success "brightness setup completed"
warn "Reboot required for group changes"
