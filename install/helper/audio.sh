#!/bin/bash
set -e

source "$(dirname "$0")/../lib/color.sh"
source "$(dirname "$0")/../lib/core.sh"
source "$(dirname "$0")/../lib/errors.sh"

setup_error_trap
parse_args "$@"

info "Installing PipeWire audio stack"

audio_pkgs=(
    pipewire
    pipewire-alsa
    pipewire-pulse
    pipewire-jack
    wireplumber
)

run_task "Installing PipeWire packages" sudo pacman -S --needed --noconfirm "${audio_pkgs[@]}"

success "audio setup completed"
