#!/usr/bin/env bash
set -euo pipefail

# Direct “latest” redirect URL
REDIRECT_URL="https://downloads.getmonero.org/cli/linux64"

# Fetch the real download location (follow the redirect headers)
DOWNLOAD_URL=$(curl -fsSI "$REDIRECT_URL" \
  | grep -i '^Location:' \
  | head -n1 \
  | awk '{print $2}' \
  | tr -d '\r')

if [[ -z "$DOWNLOAD_URL" ]]; then
  echo "Error: couldn’t resolve latest Monero URL" >&2
  exit 1
fi

# Derive version from the filename
VERSION=$(basename "$DOWNLOAD_URL" | sed -E 's/monero-linux-x64-v([0-9.]+)\.tar\.bz2/\1/')

echo "Latest Monero CLI version: $VERSION"

# Clean up old files
rm -rf monero monero.tar.bz2

# Download & extract
curl -fsSL "$REDIRECT_URL" -o monero.tar.bz2
tar -xvjf monero.tar.bz2

# Move extracted folder to a consistent name
ROOT_DIR=$(tar -tf monero.tar.bz2 | head -1 | cut -d/ -f1)
mv "$ROOT_DIR" monero
rm monero.tar.bz2

# Verify
ls -lh monero/monero-wallet-cli
