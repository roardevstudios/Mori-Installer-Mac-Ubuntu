#!/usr/bin/env bash
set -euo pipefail

version="${1:-0.3.0}"
if [[ ! "$version" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "Version must look like 0.3.0; got '$version'." >&2
  exit 2
fi
if [[ "$(uname -s)" != "Linux" ]]; then
  echo "The Ubuntu DEB must be built on a Linux runner." >&2
  exit 1
fi

cd "$(dirname "$0")"
./node_modules/.bin/electron-builder --linux deb --x64 --config electron-builder.yml -c.extraMetadata.version="$version"
sha256sum "../../output/installers/ubuntu/Mori-Web-v${version}-linux-amd64.deb" > "../../output/installers/ubuntu/Mori-Web-v${version}-linux-amd64.deb.sha256"



