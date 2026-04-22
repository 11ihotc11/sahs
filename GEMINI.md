# Gemini Project Tracking: sahs

## Current Progress
- [x] Fork and clone `sicbite/sahs`.
- [x] Improve `--dry-run` functionality across all scripts.
- [x] Implement robust error handling and `run_task` reporting.
- [x] Implement strict VM detection (with chroot support).
- [x] Fix hardcoded home paths in `hypr_config.sh`.
- [x] Reorganize project structure to modular `install/` directory.
- [x] Externalize package lists to `official.packages` and `aur.packages`.
- [x] Ensure all scripts are executable (`chmod +x`).

## Roadmap
1. **Refinement**
   - [ ] Add more robust error handling to `install.sh`.
   - [ ] Implement connectivity check before starting installation.
2. **Branding**
   - [ ] Add a custom TUI logo.

## Project Notes
- **Goal**: Improved version of `sahs` with better dry-run support and modular structure.
- **Structure**:
  - `install/lib/`: Utility scripts.
  - `install/check/`: System checks.
  - `install/helper/`: Component setup scripts.
  - `install/config/`: Configuration files.
