# Mori web desktop wrapper — macOS

This folder packages the Mori Vercel website in a standalone Electron window. It creates a universal Intel/Apple Silicon DMG and a SHA-256 sidecar:

```bash
npm ci
bash package.sh 0.2.9
```

The wrapper loads `https://mori-apis-ai.vercel.app/` and opens links to other sites in the system browser. It is a desktop shell for Mori Web; it does not include the Windows WPF desktop companion, overlays, or OS hotkeys.
