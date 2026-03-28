#!/usr/bin/env bash
set -euo pipefail

# Rebuild script for SubnauticaNitrox/Documentation
# Runs on existing source tree (no clone). Installs deps, runs pre-build steps, builds.

# --- Node version ---
export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
if [ -s "$NVM_DIR/nvm.sh" ]; then
    . "$NVM_DIR/nvm.sh"
    nvm install 22
    nvm use 22
fi

# --- Package manager: pnpm v9 (lockfileVersion 9.0 requires pnpm v9+) ---
if ! command -v pnpm &>/dev/null; then
    npm install -g pnpm@9
fi

PNPM_VERSION=$(pnpm --version 2>/dev/null | cut -d. -f1 || echo "0")
if [ "$PNPM_VERSION" != "9" ]; then
    npm install -g pnpm@9
fi

# --- Dependencies ---
pnpm install --frozen-lockfile

# --- Build ---
pnpm build

echo "[DONE] Build complete."
