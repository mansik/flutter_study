# web_app

A new Flutter project.

web app 연습

appbar, webview

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


## Steps

### 1. [add plugin pubspec.yaml](https://pub.dev/packages/webview_flutter/install)

webview_flutter: ^4.10.0 을 사용하면
- /android/settings.gladle의 "com.android.application" version 이 "8.2.1" 이상 되어야 한다.
- /android/app/build.gradle의 minSdk를 지정할 경우  minSdk = 21 이상 되어야 한다.
```yaml
dependencies:
  flutter:
    sdk: flutter

  # The following adds the Cupertino Icons font to your application.
  # Use with the CupertinoIcons class for iOS style icons.
  cupertino_icons: ^1.0.8
  # webview_flutter: ^4.10.0 하면 
  # /android/settings.gradle 에서 pluings {  id "com.android.application" version "8.2.1" ...로 해줘야 한다.
  webview_flutter: ^4.10.0
```

### 2. change gladle plugin version in android/settings.gladle
- /android/settings.gladle
  change version: "com.android.application" version "8.2.1" apply false
```gladle 
plugins {
    id "dev.flutter.flutter-plugin-loader" version "1.0.0"
    id "com.android.application" version "8.2.1" apply false // 8.1.0 -> 8.2.1
    id "org.jetbrains.kotlin.android" version "1.8.22" apply false
}
```

### 3. [add Authority](https://docs.flutter.dev/data-and-backend/networking)

Android apps must declare their use of the internet in the Android manifest (AndroidManifest.xml):
- /android/app/src/main/Androidmainfest.xml
  add <uses-permission android:name="android.permission.INTERNET" />
```xml
    <manifest xmlns:android...>
     ...
     <uses-permission android:name="android.permission.INTERNET" />
     <application ...
    </manifest>
```

### 4. alter main.dart

### 5. add screens/home_screen.dart