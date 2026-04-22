#!/bin/bash
set -e
BASE_DIR="$(cd "$(dirname "$0")/../.." && pwd)"
source "$BASE_DIR/install/lib/color.sh"
source "$BASE_DIR/install/lib/core.sh"
source "$BASE_DIR/install/lib/errors.sh"

setup_error_trap
parse_args "$@"

info "Installing and configuring UFW for ProtonVPN"
run_task "Installing UFW" sudo pacman -S --needed --noconfirm ufw
info "Applying default 'Deny Incoming' security posture"
run_task "Resetting UFW" sudo ufw --force reset
run_task "Setting default deny incoming" sudo ufw default deny incoming
run_task "Setting default allow outgoing" sudo ufw default allow outgoing
info "Opening ports for WireGuard and OpenVPN"
run_task "Allowing 51820/udp" sudo ufw allow 51820/udp
run_task "Allowing 1194/udp" sudo ufw allow 1194/udp
run_task "Allowing 1194/tcp" sudo ufw allow 1194/tcp
run_task "Enabling UFW service" sudo systemctl enable ufw
run_task "Enabling UFW firewall" sudo ufw --force enable
success "UFW setup completed"
