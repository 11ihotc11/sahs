# sahs

`sahs` is a modular, reliable, and transparent Arch Linux Hyprland installation script. This project is a refined fork of `sicbite/sahs`, optimized for better error handling, modularity, and environment intelligence.

## Overview

This installer automates the setup of a minimal and performant Hyprland environment on Arch Linux. It follows a modular design, ensuring that each component of the system—from networking to audio and desktop configuration—can be managed and audited easily.

### Key Features
- **Modular Design**: Logic is separated into distinct scripts for easy maintenance and customization.
- **Robust Error Handling**: Implements global error traps and provides real-time task feedback with log tailing for failed operations.
- **Environment Awareness**: Designed to handle various installation scenarios, including `chroot` environments.
- **Safe Execution**: Includes a comprehensive `--dry-run` (`-d_r`) mode to simulate changes without modifying your system.
- **Arch-Optimized**: Uses `reflector` for automatic mirror optimization and provides structured package management (official + AUR).

## Installation

### Prerequisites
- An active internet connection.
- `sudo` access.
- `git`, `pacman` installed on the target system.

### Quick Start
1. Clone this repository:
   ```bash
   git clone https://github.com/11ihotc11/sahs.git
   cd sahs
   ```
2. Run the installer:
   ```bash
   # Standard installation
   ./install.sh
   
   # Run in simulation mode (recommended for testing)
   ./install.sh --dry-run
   ```

Check [bindings.md](bindings.md) for a list of default keybindings.

## Project Standards
- **Naming Convention**: Strict hyphen-case for all files and directories.
- **Branching Strategy**: 
  - `main`: Stable release branch.
  - `dev`: Active development (default).
- **Commit Philosophy**: Atomic, focused commits.
- **Versioning**: Follow semantic versioning. Create signed git tags (e.g., `v0.1.0`) for all releases.

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---
*This project was created with the assistance of GEMINI CLI.*
