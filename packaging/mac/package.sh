#!/usr/bin/env bash
set -euo pipefail

version="${1:?Usage: package.sh VERSION [APP_BUNDLE] [OUTPUT_DIR]}"
app_bundle="${2:-build/macos/Mori.app}"
output_dir="${3:-output/installers}"

if [[ ! "$version" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "Version must use major.minor.patch, for example 0.2.9." >&2
  exit 2
fi
if [[ ! -d "$app_bundle" || ! -f "$app_bundle/Contents/Info.plist" ]]; then
  echo "Native Mori app bundle not found: $app_bundle" >&2
  echo "A macOS build must first create Mori.app with Contents/Info.plist and a native executable." >&2
  exit 1
fi
if ! command -v hdiutil >/dev/null 2>&1; then
  echo "hdiutil is required; run this packager on macOS." >&2
  exit 1
fi

mkdir -p "$output_dir"
stage="$(mktemp -d)"
trap 'rm -rf "$stage"' EXIT
ditto "$app_bundle" "$stage/Mori.app"
ln -s /Applications "$stage/Applications"

image="$output_dir/Mori-v${version}-mac.dmg"
rm -f "$image"
hdiutil create -volname "Mori ${version}" -srcfolder "$stage" -ov -format UDZO "$image"
shasum -a 256 "$image" > "${image}.sha256"
echo "Created $image"
