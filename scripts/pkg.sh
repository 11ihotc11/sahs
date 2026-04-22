#!/bin/bash
set -e

source "$(dirname "$0")/color.sh"
source "$(dirname "$0")/core.sh"

parse_args "$@"

info "Installing packages"

official_pkg=(
    hyprland nwg-look hyprpolkitagent dolphin kitty vim btop git
    base-devel sddm qt6-wayland qt5-wayland
    xdg-desktop-portal-hyprland hyprlauncher
    blueman pavucontrol
)

aur_pkg=(
    librewolf-bin
    hyprqt6engine
)

run_cmd sudo pacman -S --needed "${official_pkg[@]}"

if command -v yay &>/dev/null; then
    run_cmd yay -S --needed "${aur_pkg[@]}"
else
    if [ "$DRY_RUN" = true ]; then
        info "yay not found, skipping AUR packages (dry-run)"
    else
        error "yay not found"
        exit 1
    fi
fi

success "pkg.sh completed"
