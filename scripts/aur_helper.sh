#!/bin/bash
set -e

source "$(dirname "$0")/color.sh"
source "$(dirname "$0")/core.sh"

parse_args "$@"

info "Installing AUR helper (yay)"

run_cmd sudo pacman -S --noconfirm --needed git base-devel go

if command -v yay &>/dev/null; then
    warn "yay already installed"
    exit 0
fi

if [ "$DRY_RUN" = true ]; then
    info "Skipping yay installation steps (dry-run)"
    exit 0
fi

tmp_dir=$(mktemp -d)
cd "$tmp_dir"

run_cmd git clone https://aur.archlinux.org/yay.git
cd yay

run_cmd makepkg -si --noconfirm

cd "$BASE_DIR" # Good practice to go back
rm -rf "$tmp_dir"

success "yay installed"
