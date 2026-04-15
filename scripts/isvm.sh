#!/bin/bash
set -e

source "$(dirname "$0")/color.sh"
source "$(dirname "$0")/core.sh"

parse_args "$@"

info "Running isvm.sh"

if ! command -v systemd-detect-virt &>/dev/null; then
    error "systemd-detect-virt not found"
    exit 1
fi

virt_type=$(systemd-detect-virt 2>/dev/null || echo "none")

if [ "$virt_type" = "none" ]; then
    success "No VM detected (bare metal)"
else
    warn "Virtual machine detected: $virt_type"
fi

success "isvm.sh completed"
