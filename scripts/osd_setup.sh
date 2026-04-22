#!/bin/bash
set -e

source "$(dirname "$0")/color.sh"
source "$(dirname "$0")/core.sh"

parse_args "$@"

info "Setting up notify-send + dunst OSD"

run_cmd sudo pacman -S --needed dunst libnotify

HYPR_CONF="$HOME/.config/hypr/hyprland.conf"
make_dir "$(dirname "$HYPR_CONF")"

if ! grep -q "exec-once = dunst" "$HYPR_CONF" 2>/dev/null; then
    write_line "exec-once = dunst" "$HYPR_CONF"
fi

make_dir "$HOME/.config/dunst"

DUNST_CONF="[global]
geometry = \"300x80-10+50\"
frame_width = 2
padding = 8
font = Monospace 10

[urgency_normal]
background = \"#1e1e2e\"
foreground = \"#ffffff\""

write_file "$DUNST_CONF" "$HOME/.config/dunst/dunstrc"

success "OSD setup completed"
