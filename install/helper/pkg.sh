#!/bin/bash
set -e

BASE_DIR="$(cd "$(dirname "$0")/../.." && pwd)"
source "$BASE_DIR/install/lib/color.sh"
source "$BASE_DIR/install/lib/core.sh"

parse_args "$@"

info "Installing packages"

# Use absolute paths to package files
OFFICIAL_LIST="$BASE_DIR/install/official.packages"
AUR_LIST="$BASE_DIR/install/aur.packages"

mapfile -t official_pkg < <(grep -v '^#' "$OFFICIAL_LIST" | grep -v '^[[:space:]]*$')
mapfile -t aur_pkg < <(grep -v '^#' "$AUR_LIST" | grep -v '^[[:space:]]*$')

run_cmd sudo pacman -S --needed "${official_pkg[@]}"

if command -v yay &>/dev/null; then
    run_cmd yay -S --needed "${aur_pkg[@]}"
else
    if [ "$DRY_RUN" = true ]; then
        info "yay not found, skipping AUR packages (dry-run)"
    else
        error "yay not found"
        exit 1
    fi
fi

success "pkg.sh completed"
