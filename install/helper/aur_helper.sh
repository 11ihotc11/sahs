#!/bin/bash
set -e

source "$(dirname "$0")/../lib/color.sh"
source "$(dirname "$0")/../lib/core.sh"
source "$(dirname "$0")/../lib/errors.sh"

setup_error_trap
parse_args "$@"

info "Installing AUR helper (yay)"

run_task "Installing dependencies" sudo pacman -S --noconfirm --needed git base-devel go

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

run_task "Cloning yay repository" git clone https://aur.archlinux.org/yay.git
cd yay

run_task "Building and installing yay" makepkg -si --noconfirm

cd "$BASE_DIR" # Good practice to go back
rm -rf "$tmp_dir"

success "yay installed"
