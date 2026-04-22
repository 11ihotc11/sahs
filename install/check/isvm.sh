#!/bin/bash
set -e

source "$(dirname "$0")/../lib/color.sh"
source "$(dirname "$0")/../lib/core.sh"
source "$(dirname "$0")/../lib/errors.sh"

setup_error_trap
parse_args "$@"

info "Running isvm.sh"

check_dependency "systemd-detect-virt"

virt_type=$(systemd-detect-virt 2>/dev/null || echo "none")

if [ "$virt_type" = "none" ]; then
    success "No VM detected (bare metal)"
else
    warn "Virtual machine detected: $virt_type"
fi

success "isvm.sh completed"
