#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

LOG_FILE="/tmp/sahs.log"
touch "$LOG_FILE" 2>/dev/null || true

log() {
    echo "$(date '+%F %T') $1" >> "$LOG_FILE"
}

info() {
    echo -e "$(date '+%H:%M:%S') ${BLUE}==> $1${NC}"
    log "[INFO] $1"
}

success() {
    echo -e "$(date '+%H:%M:%S') ${GREEN}==> $1${NC}"
    log "[SUCCESS] $1"
}

warn() {
    echo -e "$(date '+%H:%M:%S') ${YELLOW}==> $1${NC}"
    log "[WARN] $1"
}

error() {
    echo -e "$(date '+%H:%M:%S') ${RED}==> $1${NC}" >&2
    log "[ERROR] $1"
}
