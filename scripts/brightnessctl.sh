#!/bin/bash
set -e

source "$(dirname "$0")/color.sh"
source "$(dirname "$0")/core.sh"

parse_args "$@"

info "Installing brightnessctl"

run_cmd sudo pacman -S --needed brightnessctl

if ! groups "$USER" | grep -q video; then
    run_cmd sudo usermod -aG video "$USER"
fi

success "brightness setup completed"
warn "Reboot required for group changes"
