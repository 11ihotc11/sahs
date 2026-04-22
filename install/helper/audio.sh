#!/bin/bash
set -e
BASE_DIR="$(cd "$(dirname "$0")/../.." && pwd)"
source "$BASE_DIR/install/lib/color.sh"
source "$BASE_DIR/install/lib/core.sh"
source "$BASE_DIR/install/lib/errors.sh"

setup_error_trap
parse_args "$@"

info "Installing PipeWire audio stack"
audio_pkgs=(pipewire pipewire-alsa pipewire-pulse pipewire-jack wireplumber)
run_task "Installing PipeWire packages" sudo pacman -S --needed --noconfirm "${audio_pkgs[@]}"
success "audio setup completed"
