#!/usr/bin/env bash
set -euo pipefail

version="${1:-0.2.9}"
if [[ ! "$version" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "Version must look like 0.2.9; got '$version'." >&2
  exit 2
fi
if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "The macOS DMG must be built on a macOS runner." >&2
  exit 1
fi

cd "$(dirname "$0")"
./node_modules/.bin/electron-builder --mac dmg --universal --config electron-builder.yml -c.extraMetadata.version="$version"
shasum -a 256 "../../output/installers/mac/Mori-Web-v${version}-mac-universal.dmg" > "../../output/installers/mac/Mori-Web-v${version}-mac-universal.dmg.sha256"
