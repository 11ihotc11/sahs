#!/bin/bash
set -e
BASE_DIR="$(cd "$(dirname "$0")/../.." && pwd)"
source "$BASE_DIR/install/lib/color.sh"
source "$BASE_DIR/install/lib/core.sh"
source "$BASE_DIR/install/lib/errors.sh"

setup_error_trap
parse_args "$@"

info "Setting up notify-send + dunst OSD"
run_task "Installing OSD packages" sudo pacman -S --needed --noconfirm dunst libnotify
hypr_conf="$HOME/.config/hypr/hyprland.conf"
run_task "Creating Hyprland config directory" make_dir "$(dirname "$hypr_conf")"
if ! grep -q "exec-once = dunst" "$hypr_conf" 2>/dev/null; then
    run_task "Adding dunst to Hyprland config" write_line "exec-once = dunst" "$hypr_conf"
fi
run_task "Creating Dunst config directory" make_dir "$HOME/.config/dunst"
dunst_conf="[global]\ngeometry = \"300x80-10+50\"\nframe_width = 2\npadding = 8\nfont = Monospace 10\n\n[urgency_normal]\nbackground = \"#1e1e2e\"\nforeground = \"#ffffff\""
run_task "Writing Dunst config" write_file "$dunst_conf" "$HOME/.config/dunst/dunstrc"
success "OSD setup completed"
