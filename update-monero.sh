#!/usr/bin/env bash
set -euo pipefail

# 1) Latest “smart” redirect
DOWNLOAD_URL="https://downloads.getmonero.org/cli/linux64"

# 2) Download tarball
curl -fsSL "$DOWNLOAD_URL" -o monero.tar.bz2

# 3) Find the root directory inside the tar
ROOT_DIR=$(tar -tf monero.tar.bz2 | head -n1 | cut -d/ -f1)

# 4) Extract only the wallet CLI into a fresh folder
rm -rf monero
mkdir monero
tar -xjf monero.tar.bz2 --strip-components=1 -C monero "$ROOT_DIR/monero-wallet-cli"

# 5) Clean up
rm monero.tar.bz2

# 6) Verify
if [[ -x monero/monero-wallet-cli ]]; then
  echo "✅ monero-wallet-cli v${ROOT_DIR##*-v} pulled successfully"
  ls -lh monero/monero-wallet-cli
else
  echo "❌ Error: monero-wallet-cli missing or not executable" >&2
  exit 1
fi
