#!/bin/bash
set -e

source "$(dirname "$0")/color.sh"
source "$(dirname "$0")/core.sh"

parse_args "$@"

info "Setting up notify-send + dunst OSD"

run_cmd sudo pacman -S --needed dunst libnotify

HYPR_CONF="$HOME/.config/hypr/hyprland.conf"
mkdir -p "$(dirname "$HYPR_CONF")"

if ! grep -q "exec-once = dunst" "$HYPR_CONF" 2>/dev/null; then
    echo "exec-once = dunst" >> "$HYPR_CONF"
fi

mkdir -p "$HOME/.config/dunst"

cat > "$HOME/.config/dunst/dunstrc" << EOF
[global]
geometry = "300x80-10+50"
frame_width = 2
padding = 8
font = Monospace 10

[urgency_normal]
background = "#1e1e2e"
foreground = "#ffffff"
EOF

success "OSD setup completed"
