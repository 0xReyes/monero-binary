#!/bin/bash
set -e

VERSION=$(curl -s https://www.getmonero.org/downloads/ | grep -oP 'monero-linux-x64-v\K[0-9.]+(?=\.tar\.bz2)' | head -n 1)

echo "Latest version: $VERSION"

wget -q https://downloads.getmonero.org/cli/monero-linux-x64-v$\{VERSION\}.tar.bz2 -O monero.tar.bz2
tar -xvjf monero.tar.bz2
mv monero-x86_64-linux-gnu-v${VERSION} monero
rm monero.tar.bz2

ls -lh monero/monero-wallet-cli
