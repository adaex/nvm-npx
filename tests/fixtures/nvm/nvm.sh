#!/usr/bin/env bash
set -euo pipefail

if [ -z "${NVM_EXEC_LOG:-}" ]; then
  echo "tests fixture: NVM_EXEC_LOG not set" >&2
  exit 1
fi

nvm() {
  local action="${1:-}"
  shift || true

  case "$action" in
    exec)
      local version="${1:-}"
      shift || true
      local cmd="${1:-}"
      shift || true

      {
        printf 'exec:%s:%s' "$version" "$cmd"
        if (($# > 0)); then
          printf ':%s' "$*"
        fi
        printf '\n'
      } >>"$NVM_EXEC_LOG"

      # Pretend the command ran successfully; no-op for test purposes.
      return 0
      ;;
    *)
      printf 'unexpected:%s' "$action" >>"$NVM_EXEC_LOG"
      return 1
      ;;
  esac
}
