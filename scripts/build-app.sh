#!/bin/sh
set -eu
cd "$(dirname "$0")/.."
export CLANG_MODULE_CACHE_PATH="$PWD/.build/clang-cache"
export SWIFTPM_MODULECACHE_OVERRIDE="$PWD/.build/module-cache"
swift build -c release --disable-sandbox
BIN_DIR=$(swift build -c release --show-bin-path --disable-sandbox)
APP="$PWD/dist/RayOpen.app"
mkdir -p "$APP/Contents/MacOS"
cp "$BIN_DIR/RayOpen" "$APP/Contents/MacOS/RayOpen"
cat > "$APP/Contents/Info.plist" <<'PLIST'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0"><dict>
<key>CFBundleExecutable</key><string>RayOpen</string>
<key>CFBundleIdentifier</key><string>org.rayopen.launcher</string>
<key>CFBundleName</key><string>RayOpen</string>
<key>CFBundlePackageType</key><string>APPL</string>
<key>CFBundleShortVersionString</key><string>0.1.0</string>
<key>CFBundleVersion</key><string>1</string>
<key>LSMinimumSystemVersion</key><string>14.0</string>
<key>LSUIElement</key><true/>
<key>NSAppTransportSecurity</key><dict><key>NSAllowsLocalNetworking</key><true/></dict>
</dict></plist>
PLIST
printf 'Application built : %s\nLaunch: open "%s"\n' "$APP" "$APP"
