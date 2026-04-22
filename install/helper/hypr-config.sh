#!/bin/bash
set -e
BASE_DIR="$(cd "$(dirname "$0")/../.." && pwd)"
source "$BASE_DIR/install/lib/color.sh"
source "$BASE_DIR/install/lib/core.sh"
source "$BASE_DIR/install/lib/errors.sh"

setup_error_trap
parse_args "$@"

info "Running hypr-config (append-safe mode)"
hypr_dir="$HOME/.config/hypr"
hypr_conf="$hypr_dir/hyprland.conf"

run_task "Creating Hyprland config directory" make_dir "$hypr_dir"

if [ ! -f "$hypr_conf" ]; then
    run_task "Installing default hyprland.conf" cp "$BASE_DIR/install/config/hypr/hyprland.conf" "$hypr_conf"
fi

lines=("source = $HOME/.config/hypr/bindings.conf" "source = $HOME/.config/hypr/looknfeel.conf" "exec-once = dunst" "exec-once = waybar" "exec-once = wl-paste --type text --watch cliphist store" "exec-once = wl-paste --type image --watch cliphist store")
for line in "${lines[@]}"; do
    if ! grep -Fxq "$line" "$hypr_conf" 2>/dev/null; then
        run_task "Adding: $line" write_line "$line" "$hypr_conf"
    fi
done
run_task "Copying configuration files" cp "$BASE_DIR/install/config/hypr/bindings.conf" "$BASE_DIR/install/config/hypr/looknfeel.conf" "$hypr_dir"
run_task "Reloading Hyprland" bash -c 'pgrep -x Hyprland >/dev/null && hyprctl reload || true'
success "hypr-config.sh completed"
