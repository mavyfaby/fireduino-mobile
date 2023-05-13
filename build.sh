#! /usr/bin/env bash
flutter build apk --split-per-abi

# If has --install, install apk to device
if [[ $* == *--install* ]]; then
    echo "Installing APK to device..."
    adb install build/app/outputs/flutter-apk/app-arm64-v8a-release.apk
fi