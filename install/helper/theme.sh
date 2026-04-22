#!/bin/bash
set -e
BASE_DIR="$(cd "$(dirname "$0")/../.." && pwd)"
source "$BASE_DIR/install/lib/color.sh"
source "$BASE_DIR/install/lib/core.sh"
source "$BASE_DIR/install/lib/errors.sh"

setup_error_trap
parse_args "$@"

info "Setting default dark theme preference..."

# GTK Theme Preference
if command -v gsettings &>/dev/null; then
    run_task "Setting GTK color-scheme to prefer-dark" gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    run_task "Setting GTK theme to Adwaita-dark" gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
fi

# Hyprland Look & Feel
looknfeel_conf="$BASE_DIR/install/config/hypr/looknfeel.conf"
if [ ! -f "$looknfeel_conf" ]; then
    info "Creating looknfeel.conf..."
    cat > "$looknfeel_conf" <<EOF
general {
    gaps_in = 0
    gaps_out = 0
    border_size = 1
    col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
    col.inactive_border = rgba(595959aa)
}

decoration {
    rounding = 0
    active_opacity = 1.0
    inactive_opacity = 0.9

    blur {
        enabled = false
    }

    shadow {
        enabled = false
    }
}
EOF
fi

success "Theme settings applied"
