#!/bin/bash
set -e

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
INSTALL_DIR="$BASE_DIR/install"
LIB_DIR="$INSTALL_DIR/lib"
CHECK_DIR="$INSTALL_DIR/check"
HELPER_DIR="$INSTALL_DIR/helper"

source "$LIB_DIR/color.sh"
source "$LIB_DIR/core.sh"
source "$LIB_DIR/errors.sh"

setup_error_trap
parse_args "$@"

for arg in "$@"; do
    case "$arg" in
        --help|-h)
            show_help
            exit 0
            ;;
    esac
done

info "Starting full installation (Modular)..."
warn "NOTE: Hyprland may have performance issues in virtualized environments."

# Initial checks
check_dependency "sudo"
check_dependency "pacman"
check_dependency "git"

run_script "$CHECK_DIR/isonline.sh"
run_script "$HELPER_DIR/mirror.sh"
run_script "$HELPER_DIR/ufw-setup.sh"
run_script "$HELPER_DIR/aur-helper.sh"
run_script "$HELPER_DIR/pkg.sh"
run_script "$HELPER_DIR/audio.sh"
run_script "$HELPER_DIR/bluetooth.sh"
run_script "$HELPER_DIR/brightnessctl.sh"
run_script "$HELPER_DIR/sahs-brightness.sh"
run_script "$HELPER_DIR/hypr-config.sh"
run_script "$HELPER_DIR/services.sh"

success "All installation steps completed!"
info "Reboot!"
