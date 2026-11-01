# Mori Web installers (macOS and Ubuntu)

The Actions workflow at `.github/workflows/build-mac-ubuntu.yml` packages the Mori Vercel website as a desktop web wrapper with Electron. It runs native builds on a `macos-latest` and `ubuntu-latest` matrix and uploads a universal macOS DMG and an Ubuntu x64 DEB, each with a SHA-256 sidecar.

The app opens `https://mori-apis-ai.vercel.app/` in a standalone window. It requires an internet connection and does not include the Windows WPF desktop companion, screen overlays, or OS hotkeys. These packages are not a macOS/Linux port of Mori Desktop.

## Run the workflow

1. Open the fork and select **Actions**.
2. Choose **Build Mori Web desktop installers** and click **Run workflow**.
3. Enter `v0.2.9` and start the run.
4. From the completed run, download the `Mori-Web-v0.2.9-mac` and `Mori-Web-v0.2.9-ubuntu` artifacts. Each is a ZIP containing its installer and checksum.

The macOS DMG is unsigned; signing and notarization require Apple Developer credentials and are not configured in this repository.
