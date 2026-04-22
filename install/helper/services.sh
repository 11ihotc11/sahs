#!/bin/bash
set -e

source "$(dirname "$0")/../lib/color.sh"
source "$(dirname "$0")/../lib/core.sh"

parse_args "$@"

services=(sddm NetworkManager)

for s in "${services[@]}"; do
    run_cmd sudo systemctl enable "$s"
    #run_cmd sudo systemctl start "$s"
done

success "services configured"
