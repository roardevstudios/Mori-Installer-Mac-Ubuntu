# macOS and Ubuntu packaging

Platform packaging scripts live under `packaging/mac/` and `packaging/ubuntu/`. The GitHub Actions workflow at `.github/workflows/build-mac-ubuntu.yml` uses a `macos-latest`/`ubuntu-latest` matrix, accepts a manual version input defaulting to `v0.2.9`, invokes the native build script for each platform, packages the output, and uploads the installer plus its SHA-256 sidecar.

## Expected native build outputs

The workflow expects these platform-specific source build scripts and outputs:

- macOS: `desktop/mac/build-app.sh` creates `build/macos/Mori.app` with a native executable and `Contents/Info.plist`.
- Ubuntu: `desktop/ubuntu/build-app.sh` creates `build/linux/AppDir/usr/bin/mori` as an executable.

The packaging scripts then produce `Mori-v<version>-mac.dmg` and `Mori-v<version>-linux-amd64.deb`.

## Current source limitation

This installer repository does not contain the desktop app source. The app source available in the Mori workspace is WPF targeting `net10.0-windows`; WPF only runs on Windows. The existing Electron launcher also starts `Mori.Desktop.exe`. GitHub Actions cannot create a native macOS/Linux app binary from those Windows-only sources, and the workflow intentionally refuses to package the Windows executable under another platform's installer extension.

The packaging scripts are ready to use when native macOS and Linux app build scripts and payloads are added. Until then, the Actions workflow will stop at its source check and produce no installer artifact.

## Run Actions after adding the native app builds

1. Open the fork and select **Actions**.
2. Choose **Package Mori for macOS and Ubuntu** and select **Run workflow**.
3. Set the version to `v0.2.9` and start the run.
4. Download `Mori-v0.2.9-mac` and `Mori-v0.2.9-ubuntu` from the completed run's **Artifacts** section.
