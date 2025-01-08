# camera_test

A new Flutter project.

카메라 앱

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Features

camera app

## Plugin

- camera: ^0.11.0+2

## Setps

### add plugins in pubspec.yaml, `pub get`

```yaml
dependencies:
  camera: ^0.11.0+2    
```

### modify settings.gradle

- /android/settings.gradle
```gradle
plugins {
    id "dev.flutter.flutter-plugin-loader" version "1.0.0"
    id "com.android.application" version "8.2.1" apply false
    id "org.jetbrains.kotlin.android" version "2.0.20" apply false
```

### modify build.gradle

- /android/app/build.gradle
```gradle
  minSdk = 29 //flutter.minSdkVersion
```