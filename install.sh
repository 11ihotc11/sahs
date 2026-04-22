#!/bin/bash
set -e

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
SCRIPTS_DIR="$BASE_DIR/scripts"

source "$SCRIPTS_DIR/color.sh"
source "$SCRIPTS_DIR/core.sh"

parse_args "$@"

show_help() {
    echo "Usage: ./install.sh [options]"
    echo "  -d_r, --dry-run    Simulate execution"
    echo "  -h,   --help       Show help"
}

for arg in "$@"; do
    case "$arg" in
        --help|-h)
            show_help
            exit 0
            ;;
    esac
done

run_script() {
    if [ "$DRY_RUN" = true ]; then
        echo "[DRY-RUN] bash $1 --dry-run"
        bash "$1" --dry-run
    else
        bash "$1"
    fi
}

info "Starting full installation..."

chmod +x "$SCRIPTS_DIR"/*.sh 2>/dev/null || true

run_script "$SCRIPTS_DIR/isvm.sh"
run_script "$SCRIPTS_DIR/ufw_setup.sh"
run_script "$SCRIPTS_DIR/aur_helper.sh"
run_script "$SCRIPTS_DIR/pkg.sh"
run_script "$SCRIPTS_DIR/audio.sh"
run_script "$SCRIPTS_DIR/bluetooth.sh"
run_script "$SCRIPTS_DIR/brightnessctl.sh"
run_script "$SCRIPTS_DIR/osd_setup.sh"
run_script "$SCRIPTS_DIR/hypr_config.sh"
run_script "$SCRIPTS_DIR/services.sh"

success "All installation steps completed!"
info "Reboot!"
