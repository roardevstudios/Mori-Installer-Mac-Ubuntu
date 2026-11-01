#!/usr/bin/env bash
set -euo pipefail

version="${1:?Usage: package.sh VERSION [APP_DIR] [OUTPUT_DIR]}"
app_dir="${2:-build/linux/AppDir}"
output_dir="${3:-output/installers}"
package_name="mori"
architecture="${MORI_DEB_ARCH:-amd64}"

if [[ ! "$version" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "Version must use major.minor.patch, for example 0.2.9." >&2
  exit 2
fi
if [[ ! -x "$app_dir/usr/bin/mori" ]]; then
  echo "Native Linux app payload not found: $app_dir/usr/bin/mori" >&2
  echo "A Linux build must first provide an executable at that path." >&2
  exit 1
fi
if ! command -v dpkg-deb >/dev/null 2>&1; then
  echo "dpkg-deb is required; run this packager on Ubuntu/Debian." >&2
  exit 1
fi

mkdir -p "$output_dir"
work="$(mktemp -d)"
trap 'rm -rf "$work"' EXIT
root="$work/${package_name}_${version}_${architecture}"
mkdir -p "$root/DEBIAN" "$root/usr/bin" "$root/usr/share/applications" "$root/usr/share/icons/hicolor/256x256/apps"
install -m 0755 "$app_dir/usr/bin/mori" "$root/usr/bin/mori"

desktop_file="$app_dir/usr/share/applications/mori.desktop"
if [[ -f "$desktop_file" ]]; then
  install -m 0644 "$desktop_file" "$root/usr/share/applications/mori.desktop"
else
  cat > "$root/usr/share/applications/mori.desktop" <<'DESKTOP'
[Desktop Entry]
Name=Mori
Comment=Your desktop companion
Exec=mori
Terminal=false
Type=Application
Categories=Utility;
DESKTOP
fi

if [[ -f "$app_dir/usr/share/icons/hicolor/256x256/apps/mori.png" ]]; then
  install -m 0644 "$app_dir/usr/share/icons/hicolor/256x256/apps/mori.png" "$root/usr/share/icons/hicolor/256x256/apps/mori.png"
fi

cat > "$root/DEBIAN/control" <<CONTROL
Package: ${package_name}
Version: ${version}
Section: utils
Priority: optional
Architecture: ${architecture}
Maintainer: Mori Project
Description: Mori desktop companion
 A native Linux build of Mori desktop companion.
CONTROL

deb="$output_dir/Mori-v${version}-linux-${architecture}.deb"
dpkg-deb --build --root-owner-group "$root" "$deb"
sha256sum "$deb" > "${deb}.sha256"
echo "Created $deb"
