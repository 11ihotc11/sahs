#!/bin/bash
set -e
BASE_DIR="$(cd "$(dirname "$0")/../.." && pwd)"
source "$BASE_DIR/install/lib/color.sh"
source "$BASE_DIR/install/lib/core.sh"
source "$BASE_DIR/install/lib/errors.sh"

setup_error_trap
parse_args "$@"

info "Enabling system services"
services=(sddm NetworkManager)
for s in "${services[@]}"; do
    run_task "Enabling $s service" sudo systemctl enable "$s"
done
success "services configured"
