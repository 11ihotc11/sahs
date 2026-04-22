# Gemini Project Tracking: sahs (Forked)

This repository is an improved fork of `sicbite/sahs`, optimized for reliability, modularity, and transparency during the installation process.

## Project Context
- **Base Repo**: `sicbite/sahs`
- **Forked Repo**: `11ihotc11/sahs`
- **Workflow**: Managed using GitHub CLI (`gh`) and SSH for secure repository operations.
- **System**: Arch Linux (Installation target).

## Engineering Standards
- **Naming Convention**: Strict hyphen-case for all files and directories (e.g., `aur-helper.sh`).
- **File Modes**: All shell scripts must be executable (`chmod +x` and `git update-index --chmod=+x`).
- **Modularity**: Logic is separated into a clean `install/` structure.
- **Branching Strategy**: 
  - `main`: Stable code for end-users.
  - `dev`: Active development (current default).
  - Merging `dev` into `main` requires an explicit user directive.
- **Commit Philosophy**: Small, atomic commits with frequent pushes.

## Current Progress
- [x] **Repository Setup**: Forked and cloned `sicbite/sahs` into the local `Projects` directory.
- [x] **Modular Restructuring**:
  - `install/lib/`: Core utilities and logging.
  - `install/check/`: Pre-installation system validations.
  - `install/helper/`: Component-specific installation logic.
  - `install/config/`: Configuration templates.
- [x] **Package Management**:
  - Externalized package lists to `official.packages` and `aur.packages`.
  - Refactored `pkg.sh` to read from these external files.
- [x] **Robust Error Handling**:
  - Implemented `install/lib/errors.sh` with a global error trap (`setup_error_trap`).
  - Added `run_task` helper in `core.sh` to provide real-time feedback and log tailing on failure.
  - Added `run_task_with_retry` for resilient package installation and cloning.
  - Added `SIGINT` trap for graceful user interruption.
- [x] **Environment Intelligence**:
  - **Chroot Support**: Explicitly allows installation within `chroot` environments.
  - **Root/Chroot Protection**: Skips `makepkg` (AUR) operations when running as root in chroot to prevent inevitable failures.
- [x] **Network & Optimization**:
  - Added `isonline.sh` for connectivity validation.
  - Added `mirror.sh` using `reflector` to find the fastest HTTPS mirrors.
- [x] **Desktop Environment & Theme**:
  - Implemented `theme.sh` for GTK dark theme preference.
  - Added `wl-clipboard` and `cliphist` for clipboard management.
  - Integrated `waybar` and `wofi` with custom configurations.
- [x] **Dry-Run Reliability**:
  - Improved `--dry-run` (`-d_r`) to ensure zero file-system modifications while still reporting intended changes.
- [x] **Consistency**:
  - Renamed all underscore files to hyphen-case.
  - Fixed hardcoded home directory paths (`/home/m7/` -> `$HOME/`).
- [x] **Installation Logic**:
  - Removed explicit `isvm.sh` check to allow virtualization use while issuing a performance warning.
  - Implemented custom `sahs-brightness` script installed to `/usr/local/bin`.
  - Added new keybindings for brightness control (10% and 5% steps).
  - Documented keybindings in `bindings.md`.

## Roadmap
1. **Validation**
   - [ ] Implement a post-install configuration check.
2. **User Experience**
   - [ ] Add a visual TUI banner/logo in `install/branding/`.
   - [ ] Implement a summary report at the end of the installation.

## Project Structure
```text
sahs/
├── GEMINI.md
├── install.sh
├── README.md
└── install/
    ├── official.packages
    ├── aur.packages
    ├── check/
    │   └── isonline.sh
    ├── helper/
    │   ├── audio.sh
    │   ├── aur-helper.sh
    │   ├── bluetooth.sh
    │   ├── brightnessctl.sh
    │   ├── hypr-config.sh
    │   ├── mirror.sh
    │   ├── pkg.sh
    │   ├── sahs-brightness.sh
    │   ├── services.sh
    │   ├── theme.sh
    │   ├── ufw-setup.sh
    │   └── waybar-config.sh
    ├── lib/
    │   ├── color.sh
    │   ├── core.sh
    │   └── errors.sh
    └── config/
        ├── hypr/
        │   ├── bindings.conf
        │   ├── hyprland.conf
        │   └── looknfeel.conf
        └── waybar/
            ├── config
            └── style.css
```
