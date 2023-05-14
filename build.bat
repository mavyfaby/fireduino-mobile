
@echo off
flutter build apk --split-per-abi

REM If has --install, install apk to device
if "%*" == --install (
    echo "Installing APK to device..."
    adb install build/app/outputs/flutter-apk/app-arm64-v8a-release.apk
)