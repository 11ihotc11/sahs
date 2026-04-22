#!/bin/bash
set -e
BASE_DIR="$(cd "$(dirname "$0")/../.." && pwd)"
source "$BASE_DIR/install/lib/color.sh"
source "$BASE_DIR/install/lib/core.sh"
source "$BASE_DIR/install/lib/errors.sh"

setup_error_trap
parse_args "$@"

info "Installing AUR helper (yay)"
if [ "$(id -u)" -eq 0 ] && [ "$(systemd-detect-virt 2>/dev/null)" = "chroot" ]; then
    warn "Detected root user in chroot environment. Skipping yay installation."
    exit 0
fi

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
(
    cd "$tmp_dir"
    run_task "Cloning yay repository" git clone https://aur.archlinux.org/yay.git
    cd yay
    run_task "Building and installing yay" makepkg -si --noconfirm
)
rm -rf "$tmp_dir"
success "yay installed"
