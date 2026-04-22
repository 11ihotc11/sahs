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

if [ "$DRY_RUN" = false ]; then
    chmod +x "$INSTALL_DIR"/**/*.sh 2>/dev/null || true
else
    echo -e "\033[1;30m[DRY-RUN]\033[0m chmod +x install/**/*.sh"
fi

run_script "$CHECK_DIR/isvm.sh"
run_script "$HELPER_DIR/ufw_setup.sh"
run_script "$HELPER_DIR/aur_helper.sh"
run_script "$HELPER_DIR/pkg.sh"
run_script "$HELPER_DIR/audio.sh"
run_script "$HELPER_DIR/bluetooth.sh"
run_script "$HELPER_DIR/brightnessctl.sh"
run_script "$HELPER_DIR/osd_setup.sh"
run_script "$HELPER_DIR/hypr_config.sh"
run_script "$HELPER_DIR/services.sh"

success "All installation steps completed!"
info "Reboot!"
