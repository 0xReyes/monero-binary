#!/usr/bin/env bash
set -euo pipefail

curl -fsSL https://downloads.getmonero.org/cli/linux64 -o monero.tar.bz2
rm -rf monero monero-*
mkdir monero
tar -xjf monero.tar.bz2
mv monero-*/monero-wallet-cli monero/
rm -rf monero-* monero.tar.bz2
if [[ ! -f monero/monero-wallet-cli || ! -x monero/monero-wallet-cli ]]; then
  echo "❌ Error: monero-wallet-cli missing or not executable" >&2
  exit 1
fi
echo "✅ monero-wallet-cli extracted"