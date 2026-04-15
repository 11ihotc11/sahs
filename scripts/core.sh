#!/bin/bash

DRY_RUN=false

parse_args() {
    for arg in "$@"; do
        case "$arg" in
            --dry-run|-d_r) DRY_RUN=true ;;
        esac
    done
}

run_cmd() {
    if [ "$DRY_RUN" = true ]; then
        printf '[DRY-RUN] %q ' "$@"; echo
    else
        "$@"
    fi
}
