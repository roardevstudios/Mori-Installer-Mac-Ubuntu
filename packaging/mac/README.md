# Mori macOS packaging

`package.sh` creates a compressed `.dmg` and SHA-256 sidecar from a **native macOS** `Mori.app` bundle. It runs on macOS because it uses `hdiutil`.

```bash
bash installer/mac/package.sh 0.2.9 build/macos/Mori.app output/installers
```

The app bundle must contain `Contents/Info.plist` and a macOS executable. Mori's currently available desktop app is Windows WPF, so it cannot supply this bundle; a macOS app port/build is required first.
