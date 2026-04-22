#!/bin/bash
# Error handling utilities for sahs

# Trap for critical script failures
setup_error_trap() {
    trap 'error_exit "An unexpected error occurred in $(basename "$0") at line $LINENO."' ERR
}

# Function to handle error exits
error_exit() {
    local message="$1"
    local exit_code="${2:-1}"
    
    # Check if 'error' function exists (from color.sh)
    if command -v error &>/dev/null; then
        error "$message"
    else
        echo -e "[ERROR] $message" >&2
    fi
    
    exit "$exit_code"
}

# Check if a command is available
check_dependency() {
    if ! command -v "$1" &>/dev/null; then
        error_exit "Dependency '$1' is required but not found. Please install it before proceeding."
    fi
}
