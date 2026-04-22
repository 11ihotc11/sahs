#!/bin/bash
set -e

source "$(dirname "$0")/../lib/color.sh"
source "$(dirname "$0")/../lib/core.sh"

parse_args "$@"

info "Installing PipeWire audio stack"

audio_pkgs=(
    pipewire
    pipewire-alsa
    pipewire-pulse
    pipewire-jack
    wireplumber
)

run_cmd sudo pacman -S --needed "${audio_pkgs[@]}"

success "audio setup completed"
