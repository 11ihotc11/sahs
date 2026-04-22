#!/bin/bash
set -e
BASE_DIR="$(cd "$(dirname "$0")/../.." && pwd)"
source "$BASE_DIR/install/lib/color.sh"
source "$BASE_DIR/install/lib/core.sh"
source "$BASE_DIR/install/lib/errors.sh"

setup_error_trap
parse_args "$@"

info "Configuring Waybar..."
waybar_dir="$HOME/.config/waybar"

run_task "Creating Waybar config directory" make_dir "$waybar_dir"

# Copy configuration files
run_task "Copying Waybar config" cp "$BASE_DIR/install/config/waybar/config" "$waybar_dir/config"
run_task "Copying Waybar style" cp "$BASE_DIR/install/config/waybar/style.css" "$waybar_dir/style.css"

success "Waybar configuration completed"
