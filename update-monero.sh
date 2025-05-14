#!/usr/bin/env bash
set -euo pipefail

# 1) Direct “latest” redirect URL
DOWNLOAD_URL="https://downloads.getmonero.org/cli/linux64"

# 2) Download the tarball (follows redirect automatically)
curl -fsSL "$DOWNLOAD_URL" -o monero.tar.bz2

# 3) Peek inside to get the root dir (e.g. monero-x86_64-linux-gnu-v0.18.4.0)
ROOT_DIR=$(tar -tf monero.tar.bz2 | head -n1 | cut -d/ -f1)

# 4) Extract version from that dir name
VERSION=$(echo "$ROOT_DIR" | sed -E 's/monero-.*-v([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+)$/\1/')

echo "Latest Monero CLI version: $VERSION"

# 5) Remove any previous build & extract quietly
rm -rf monero
tar -xjf monero.tar.bz2

# 6) Rename to a stable folder
mv "$ROOT_DIR" monero

# 7) Cleanup
rm monero.tar.bz2

# 8) Verify
if [[ -x monero/monero-wallet-cli ]]; then
  echo "✅ monero-wallet-cli is present and executable"
else
  echo "❌ Error: monero-wallet-cli missing or not executable" >&2
  exit 1
fi
