#!/bin/bash
set -e

BASE_DIR="$(cd "$(dirname "$0")/../.." && pwd)"
source "$BASE_DIR/install/lib/color.sh"
source "$BASE_DIR/install/lib/core.sh"
source "$BASE_DIR/install/lib/errors.sh"

setup_error_trap
parse_args "$@"

info "Checking internet connectivity..."

# Standard hosts to ping
HOSTS=("google.com" "archlinux.org" "github.com")

is_online() {
    for host in "${HOSTS[@]}"; do
        if ping -c 1 -W 2 "$host" &>/dev/null; then
            return 0
        fi
    done
    return 1
}

if [ "$DRY_RUN" = true ]; then
    info "Skipping connectivity check (dry-run)"
    exit 0
fi

if ! is_online; then
    error_exit "No internet connection detected. Please connect to the internet before running the installer."
fi

success "System is online"
