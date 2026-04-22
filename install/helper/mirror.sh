#!/bin/bash
set -e
BASE_DIR="$(cd "$(dirname "$0")/../.." && pwd)"
source "$BASE_DIR/install/lib/color.sh"
source "$BASE_DIR/install/lib/core.sh"
source "$BASE_DIR/install/lib/errors.sh"

setup_error_trap
parse_args "$@"

info "Optimizing Arch Linux mirrors using reflector..."
if [ "$DRY_RUN" = true ]; then
    info "Skipping mirror optimization (dry-run)"
    exit 0
fi
check_dependency "reflector"
run_task "Finding the fastest HTTPS mirrors" sudo reflector --latest 20 --protocol https --sort rate --threads 5 --save /etc/pacman.d/mirrorlist
success "Mirror optimization completed"
