# Mori Ubuntu/Linux packaging

`package.sh` creates a Debian `.deb` and SHA-256 sidecar from a **native Linux** app payload. It runs on Ubuntu/Debian and requires `dpkg-deb`.

```bash
bash installer/ubuntu/package.sh 0.2.9 build/linux/AppDir output/installers
```

The input directory must contain an executable `usr/bin/mori`. Mori's currently available desktop app is Windows WPF, so it cannot supply this Linux executable; a Linux app port/build is required first.
