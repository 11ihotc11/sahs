#!/bin/bash
set -e

source "$(dirname "$0")/../lib/color.sh"
source "$(dirname "$0")/../lib/core.sh"
source "$(dirname "$0")/../lib/errors.sh"

setup_error_trap
parse_args "$@"

services=(sddm NetworkManager)

for s in "${services[@]}"; do
    run_task "Enabling $s service" sudo systemctl enable "$s"
done

success "services configured"
