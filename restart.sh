#!/usr/bin/env bash

# ============================================================================
# restart.sh
# ============================================================================
# Usage:
#   ./restart.sh [-h|--help]
#
# Description:
#   Restart the local Quarto preview server (docker compose down then up -d).
#
# Options:
#   -h, --help   Show this help message
# ============================================================================

set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

show_help() {
  awk '/^# =====/{delim++; if(delim==3) exit; next} delim==2 && /^# /{sub(/^# /, ""); print}' "$0"
}

main() {
  case "${1:-}" in
  -h | --help)
    show_help
    exit 0
    ;;
  esac

  command -v docker >/dev/null || {
    echo "ERROR: docker not found" >&2
    exit 1
  }

  cd "$SCRIPT_DIR"
  docker compose down
  docker compose up -d
}

if [ "${BASH_SOURCE[0]}" = "$0" ]; then
  main "$@"
fi
