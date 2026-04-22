#!/bin/bash
set -e

source "$(dirname "$0")/../lib/color.sh"
source "$(dirname "$0")/../lib/core.sh"
source "$(dirname "$0")/../lib/errors.sh"

setup_error_trap
parse_args "$@"

info "Setting up notify-send + dunst OSD"

run_task "Installing OSD packages" sudo pacman -S --needed --noconfirm dunst libnotify

HYPR_CONF="$HOME/.config/hypr/hyprland.conf"
run_task "Creating Hyprland config directory" make_dir "$(dirname "$HYPR_CONF")"

if ! grep -q "exec-once = dunst" "$HYPR_CONF" 2>/dev/null; then
    run_task "Adding dunst to Hyprland config" write_line "exec-once = dunst" "$HYPR_CONF"
fi

run_task "Creating Dunst config directory" make_dir "$HOME/.config/dunst"

DUNST_CONF="[global]
geometry = \"300x80-10+50\"
frame_width = 2
padding = 8
font = Monospace 10

[urgency_normal]
background = \"#1e1e2e\"
foreground = \"#ffffff\""

run_task "Writing Dunst config" write_file "$DUNST_CONF" "$HOME/.config/dunst/dunstrc"

success "OSD setup completed"
