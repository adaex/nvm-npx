#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BIN="$ROOT_DIR/bin/nvm-npx"

# Test 1: help should work without nvm
"$BIN" --help >/dev/null

# Test 2: ensure nvm exec is called with expected arguments
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT
export NVM_EXEC_LOG="$TMP_DIR/log"
: >"$NVM_EXEC_LOG"

"$BIN" --nvm-dir "$ROOT_DIR/tests/fixtures/nvm" 18 -y chrome-devtools-mcp@latest >/dev/null

if ! grep -q "exec:18:npx:-y chrome-devtools-mcp@latest" "$NVM_EXEC_LOG"; then
  echo "Expected nvm exec invocation not found" >&2
  cat "$NVM_EXEC_LOG" >&2
  exit 1
fi

echo "All tests passed."
