#!/bin/bash
set -e

source "$(dirname "$0")/color.sh"
source "$(dirname "$0")/core.sh"

parse_args "$@"

info "Running hypr_config.sh (append-safe mode)"

HYPR_DIR="$HOME/.config/hypr"
HYPR_CONF="$HYPR_DIR/hyprland.conf"

mkdir -p "$HYPR_DIR"

# Ensure file exists (DO NOT overwrite)
if [ ! -f "$HYPR_CONF" ]; then
    info "hyprland.conf not found, creating empty file"
    touch "$HYPR_CONF"
fi

# Lines we want to ensure exist
LINES=(
    "source = /home/m7/.config/hypr/bindings.conf"
    "source = /home/m7/.config/hypr/looknfeel.conf"
    "exec-once = dunst"
)

for line in "${LINES[@]}"; do
    if grep -Fxq "$line" "$HYPR_CONF"; then
        warn "Already exists: $line"
    else
        info "Adding: $line"
        echo "$line" >> "$HYPR_CONF"
    fi
done

cp "$HOME/sahs/config/hypr/bindings.conf" "$HOME/sahs/config/hypr/looknfeel.conf" "$HYPR_DIR"

info "Reloading Hyprland using hyprctl reload"
hyprctl reload

success "hypr_config.sh completed (safe append mode)"
