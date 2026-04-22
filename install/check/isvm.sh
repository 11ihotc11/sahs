#!/bin/bash
set -e
BASE_DIR="$(cd "$(dirname "$0")/../.." && pwd)"
source "$BASE_DIR/install/lib/color.sh"
source "$BASE_DIR/install/lib/core.sh"
source "$BASE_DIR/install/lib/errors.sh"

setup_error_trap
parse_args "$@"

info "Checking for virtual environment..."
check_dependency "systemd-detect-virt"

virt_type=$(systemd-detect-virt 2>/dev/null || echo "none")

if [ "$virt_type" = "chroot" ]; then
    success "Chroot environment detected. Proceeding..."
    exit 0
fi

if [ "$virt_type" != "none" ]; then
    echo -e "\n${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    warn "Virtual machine detected: $virt_type"
    echo -e "${RED}ERROR: Hyprland does not perform well in virtualized environments.${NC}"
    echo -e "${RED}3D acceleration is often missing or buggy in VMs.${NC}"
    echo -e "${YELLOW}Installation aborted to prevent a broken setup.${NC}"
    echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
    exit 1
fi

success "No VM detected (bare metal). Proceeding..."
