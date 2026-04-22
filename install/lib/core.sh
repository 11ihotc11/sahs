#!/bin/bash
# Core utility script for sahs
# Sourced by all other scripts to provide basic functionalities.

DRY_RUN=false

parse_args() {
    for arg in "$@"; do
        case "$arg" in
            --dry-run|-d_r) DRY_RUN=true ;;
        esac
    done
}

# Function to run commands safely and respect dry-run
run_cmd() {
    if [ "$DRY_RUN" = true ]; then
        echo -e "\033[1;30m[DRY-RUN]\033[0m $*"
    else
        "$@"
    fi
}

# Task runner for structured output and error handling
run_task() {
    local msg="$1"
    shift
    
    if [ "$DRY_RUN" = true ]; then
        echo -e "\033[1;30m[DRY-RUN]\033[0m Task: $msg"
        return 0
    fi

    echo -ne "$(date '+%H:%M:%S') ${BLUE}==>${NC} $msg... "
    
    # Execute command, redirecting output to log
    if "$@" >> "$LOG_FILE" 2>&1; then
        echo -e "${GREEN}DONE${NC}"
        return 0
    else
        echo -e "${RED}FAILED${NC}"
        echo -e "\n${YELLOW}Relevant log output:${NC}"
        tail -n 5 "$LOG_FILE" | sed 's/^/  /'
        echo -e "${DIM}Full log available at: $LOG_FILE${NC}\n"
        return 1
    fi
}

# --- Shared Utility Functions ---

# Function to check internet connectivity
is_online() {
    curl -sfI https://www.google.com >/dev/null 2>&1 || curl -sfI https://archlinux.org >/dev/null 2>&1
}

show_help() {
    echo "Usage: ./install.sh [options]"
    echo "  -d_r, --dry-run    Simulate execution"
    echo "  -h,   --help       Show help"
}

run_script() {
    local script_path="$1"
    local script_name=$(basename "$script_path")
    
    if [ "$DRY_RUN" = true ]; then
        echo -e "\033[1;30m[DRY-RUN]\033[0m bash $script_path --dry-run"
        bash "$script_path" --dry-run
    else
        run_task "Running $script_name" bash "$script_path"
    fi
}

# Helper for file operations
write_line() {
    local line="$1"
    local file="$2"
    if [ "$DRY_RUN" = true ]; then
        echo -e "\033[1;30m[DRY-RUN]\033[0m echo \"$line\" >> \"$file\""
    else
        echo "$line" >> "$file"
    fi
}

copy_file() {
    local src="$1"
    local dest="$2"
    if [ "$DRY_RUN" = true ]; then
        echo -e "\033[1;30m[DRY-RUN]\033[0m cp \"$src\" \"$dest\""
    else
        cp "$src" "$dest"
    fi
}

make_dir() {
    local dir="$1"
    if [ "$DRY_RUN" = true ]; then
        echo -e "\033[1;30m[DRY-RUN]\033[0m mkdir -p \"$dir\""
    else
        mkdir -p "$dir"
    fi
}

write_file() {
    local content="$1"
    local file="$2"
    if [ "$DRY_RUN" = true ]; then
        echo -e "\033[1;30m[DRY-RUN]\033[0m Writing content to $file"
    else
        echo -e "$content" > "$file"
    fi
}
