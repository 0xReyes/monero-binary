#!/bin/bash
set -e

PAGE=$(curl -s https://www.getmonero.org/downloads/)
VERSION=$(echo "$PAGE" | grep -oE 'monero-linux-x64-v[0-9.]+\.tar\.bz2' | head -n 1 | sed -E 's/monero-linux-x64-v([0-9.]+)\.tar\.bz2/\1/')

if [ -z "$VERSION" ]; then
  echo "Failed to fetch latest version." >&2
  exit 1
fi

echo "Latest version: $VERSION"

wget -q https://downloads.getmonero.org/cli/monero-linux-x64-v$\{VERSION\}.tar.bz2 -O monero.tar.bz2
tar -xvjf monero.tar.bz2
mv monero-x86_64-linux-gnu-v${VERSION} monero
rm monero.tar.bz2

ls -lh monero/monero-wallet-cli
