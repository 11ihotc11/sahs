#!/bin/bash
set -e

BASE_DIR="$(cd "$(dirname "$0")/../.." && pwd)"
source "$BASE_DIR/install/lib/color.sh"
source "$BASE_DIR/install/lib/core.sh"
source "$BASE_DIR/install/lib/errors.sh"

setup_error_trap
parse_args "$@"

info "Installing packages"

# Use absolute paths to package files
OFFICIAL_LIST="$BASE_DIR/install/official.packages"
AUR_LIST="$BASE_DIR/install/aur.packages"

mapfile -t official_pkg < <(grep -v '^#' "$OFFICIAL_LIST" | grep -v '^[[:space:]]*$')
mapfile -t aur_pkg < <(grep -v '^#' "$AUR_LIST" | grep -v '^[[:space:]]*$')

run_task "Installing official packages" sudo pacman -S --needed --noconfirm "${official_pkg[@]}"

if command -v yay &>/dev/null; then
    run_task "Installing AUR packages" yay -S --needed --noconfirm "${aur_pkg[@]}"
else
    if [ "$DRY_RUN" = true ]; then
        info "yay not found, skipping AUR packages (dry-run)"
    else
        error_exit "yay not found"
    fi
fi

success "pkg.sh completed"
