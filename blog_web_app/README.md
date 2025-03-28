# blog_web_app

A new Flutter project.

blog web app

AppBar, WebView, 콜백 함수, 네이티브 설정

![Image](https://github.com/user-attachments/assets/0832f4f1-2097-4073-8e86-ca1bb7250d68)

## Features

- 웹뷰를 사용해서 앱에서 웹사이트 실행하기

## Usage

- 앱을 실행하면 웹사이트가 실행

## Skill

StatelessWidget, AppBar, WebView, IconButton

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Steps

### [add plugin pubspec.yaml](https://pub.dev/packages/webview_flutter/install)

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

### change gladle plugin version in android/settings.gladle
- /android/settings.gladle
  change version: "com.android.application" version "8.2.1" apply false
```gladle 
plugins {
    id "dev.flutter.flutter-plugin-loader" version "1.0.0"
    id "com.android.application" version "8.2.1" apply false // 8.1.0 -> 8.2.1
    id "org.jetbrains.kotlin.android" version "1.8.22" apply false
}
```

### [add Authority](https://docs.flutter.dev/data-and-backend/networking)

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

### allow http protocol in the Android manifest
https만 사용하면 필요가 없으며, https가 아닌 http로 사이트를 호출할 때 필요
- /android/app/src/main/Androidmainfest.xml
  add android:usesCleartextTraffic="true"
```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    ...
    <application
        android:label="blog_wep_app"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher"
        android:usesCleartextTraffic="true"> <!-- android:usesCleartextTraffic="true" 추가 -->
```

### [change the Gradle build configuration](https://docs.flutter.dev/deployment/android#review-the-gradle-build-configuration)

[webview_flutter](https://pub.dev/packages/webview_flutter)
- /android/app/build.gradle
  - compileSdk = 34 // flutter.compileSdkVersion
  - minSdk = 21 // flutter.minSdkVersion

```gradle
android {
    namespace = "com.example.[project]"
    // Any value starting with "flutter." gets its value from
    // the Flutter Gradle plugin.
    // To change from these defaults, make your changes in this file.
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    ...

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.[project]"
        // You can update the following values to match your application needs.
        minSdk = 21 //flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        // These two properties use values defined elsewhere in this file.
        // You can set these values in the property declaration
        // or use a variable.
        versionCode = flutterVersionCode.toInteger()
        versionName = flutterVersionName
    }

    buildTypes {
        ...
    }
}
```

### create home screen 
- /screens/home_screen.dart
```dart
/// 앱의 기본 홈 화면으로 사용할 위젯 만들기
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key}); // const 인스턴스를 생성, 리소스를 적게 사용

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Home Screen'),
    );
  }
}
```
### alter main.dart
```dart
void main() {
  runApp(
    MaterialApp(
      home: HomeScreen(),
    )
  );
}
```

### implementing appbar(앱바 구현하기)
- /screens/home_screen.dart
add `AppBar`
```dart
@override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. 앱바 위젯 추가, Scaffold에 추가한다.
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Title"),
        centerTitle: true, // 가운데 정렬
      ),
      body: Text('Home Screen'),
    );
  }
```

### implementing webview
add `WebViewController` and `WebViewWidget`
```dart
class HomeScreen extends StatelessWidget {
  // 2. WebViewController 선언
  // JavaScriptMode.unrestricted: JavaScript가 제한 없이 실행 된다.
  WebViewController webViewController = WebViewController()
    ..loadRequest(Uri.parse('https://google.com/'))
    ..setJavaScriptMode(JavaScriptMode.unrestricted);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ...
      // 3. 웹뷰 위젯 생성
      body: WebViewWidget(controller: webViewController),
    );
  }
}
```

### alter main.dart
add `WidgetsFlutterBinding.ensureInitialized();`
```dart
void main() {
  // 플러터 프레임워크가 앱을 실행할 준비가 될 때까지 기다림
  // StatelessWidget에서  WebViewController를 프로퍼티로 직접 인스턴스화하려면
  // 이 함수를 직접 실행해 주어야 한다.
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
          MaterialApp(
            home: HomeScreen(),
          )
  );
}
```

### implementing Home button on screens/home_screen.dart
add `actions:` in AppBar()
```dart
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. 앱바 위젯 추가, Scaffold에 추가한다.
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Title"),
        centerTitle: true, // 가운데 정렬

        // 4. appbar에 액션 버튼을 추가할 수 있는 매개변수
        // actions: 우측끝에 위젯이 생성됨
        actions: [
          IconButton(
            onPressed: () {
              webViewController.loadRequest(Uri.parse('https://google.com/'));
            },
            icon: Icon(Icons.home),
          ),
        ],
      ),
      // 3. 웹뷰 위젯 생성
      body: WebViewWidget(controller: webViewController),
    );
  }
}
```
