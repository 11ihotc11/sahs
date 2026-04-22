#!/bin/bash
set -e

BASE_DIR="$(cd "$(dirname "$0")/../.." && pwd)"
source "$BASE_DIR/install/lib/color.sh"
source "$BASE_DIR/install/lib/core.sh"
source "$BASE_DIR/install/lib/errors.sh"

setup_error_trap
parse_args "$@"

info "Running hypr_config.sh (append-safe mode)"

HYPR_DIR="$HOME/.config/hypr"
HYPR_CONF="$HYPR_DIR/hyprland.conf"

run_task "Creating Hyprland config directory" make_dir "$HYPR_DIR"

# Ensure file exists (DO NOT overwrite)
if [ ! -f "$HYPR_CONF" ]; then
    info "hyprland.conf not found, creating empty file"
    run_task "Creating hyprland.conf" touch "$HYPR_CONF"
fi

# Lines we want to ensure exist
LINES=(
    "source = $HOME/.config/hypr/bindings.conf"
    "source = $HOME/.config/hypr/looknfeel.conf"
    "exec-once = dunst"
)

for line in "${LINES[@]}"; do
    if grep -Fxq "$line" "$HYPR_CONF" 2>/dev/null; then
        warn "Already exists: $line"
    else
        run_task "Adding: $line" write_line "$line" "$HYPR_CONF"
    fi
done

run_task "Copying configuration files" cp "$BASE_DIR/install/config/hypr/bindings.conf" "$BASE_DIR/install/config/hypr/looknfeel.conf" "$HYPR_DIR"

info "Reloading Hyprland using hyprctl reload"
run_task "Reloading Hyprland" hyprctl reload

success "hypr_config.sh completed (safe append mode)"
