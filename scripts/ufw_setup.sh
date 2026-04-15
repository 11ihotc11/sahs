#!/bin/bash
set -e

source "$(dirname "$0")/color.sh"
source "$(dirname "$0")/core.sh"

parse_args "$@"

info "Installing and configuring UFW for ProtonVPN"

# Install ufw using your run_cmd wrapper
run_cmd sudo pacman -S --needed ufw

# Reset and set default policies
info "Applying default 'Deny Incoming' security posture"
run_cmd sudo ufw --force reset
run_cmd sudo ufw default deny incoming
run_cmd sudo ufw default allow outgoing

# ProtonVPN specific rules
info "Opening ports for WireGuard and OpenVPN"
run_cmd sudo ufw allow 51820/udp
run_cmd sudo ufw allow 1194/udp
run_cmd sudo ufw allow 1194/tcp

# Enable service and firewall
run_cmd sudo systemctl enable ufw
run_cmd sudo ufw --force enable

success "UFW setup completed"
