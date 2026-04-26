#!/bin/bash
set -e
BASE_DIR="$(cd "$(dirname "$0")/../.." && pwd)"
source "$BASE_DIR/install/lib/color.sh"
source "$BASE_DIR/install/lib/core.sh"
source "$BASE_DIR/install/lib/errors.sh"

setup_error_trap
parse_args "$@"

info "Configuring Waybar..."
confg_dir="$HOME/.config/"

run_task "Creating Waybar config directory" make_dir "$waybar_dir"

# Copy configuration files
run_task "Copying Waybar config" cp -r "$BASE_DIR/install/config/waybar" "$conf_dir"

success "Waybar configuration completed"
