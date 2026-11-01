# macOS and Ubuntu build workflow

The workflow is at `.github/workflows/build-mac-ubuntu.yml`. It has a manual `workflow_dispatch` input defaulting to `v0.2.9`, builds on `macos-latest` and `ubuntu-latest`, searches `dist/`, `release/`, and common Tauri bundle output directories, then uploads each platform's native installer as a separate Actions artifact.

## Current Mori compatibility

This repository contains the Windows installer packaging scripts. Mori's desktop application source is a WPF project targeting `net10.0-windows`; the Windows-only source cannot produce a native `.dmg`, `.deb`, or `.AppImage` merely by running it on macOS or Ubuntu. The small Electron launcher also starts `Mori.Desktop.exe`, so it does not make the app cross-platform.

The workflow deliberately stops with a clear message until a cross-platform desktop app and root `package.json` scripts named `package:mac` and `package:linux` are present. Once the app is ported to Electron/Tauri (or another cross-platform framework), those scripts should invoke its native packaging commands and write outputs under one of the workflow's searched directories.

## Add it to your fork from Windows

1. Open your fork of `Mori-Installer` on GitHub.
2. Select **Add file → Create new file**.
3. Enter `.github/workflows/build-mac-ubuntu.yml` as the filename. GitHub creates the missing folders.
4. Open this workflow file from the Mori source checkout and copy its full contents into the GitHub editor.
5. Commit the file to your fork's default branch. No Windows software installation is needed for this GitHub editor method.

Alternatively, in PowerShell after cloning your fork:

```powershell
New-Item -ItemType Directory -Force .github\workflows | Out-Null
Copy-Item "C:\path\to\build-mac-ubuntu.yml" .github\workflows\build-mac-ubuntu.yml
git add .github/workflows/build-mac-ubuntu.yml
git commit -m "Add macOS and Ubuntu installer workflow"
git push
```

## Run it and download artifacts

1. Open your fork on GitHub and select **Actions**. If prompted, enable Actions for the fork.
2. Select **Build Mori macOS and Linux packages** in the workflow list.
3. Select **Run workflow**, leave the version as `v0.2.9`, and start the run.
4. Open the completed run. Download `Mori-v0.2.9-mac` and `Mori-v0.2.9-linux` from **Artifacts**. GitHub downloads each artifact as a ZIP.
5. Extract the macOS package (`.dmg`/`.pkg`) into `C:\Users\samko\Desktop\HackathonJigJoy\installer\mac` and the Linux package (`.deb`/`.AppImage`/`.rpm`) into `C:\Users\samko\Desktop\HackathonJigJoy\installer\ubuntu`.

The current WPF app will cause the workflow to stop during compatibility validation. The native installers will be available after Mori's desktop application is ported and the platform package scripts are added.
