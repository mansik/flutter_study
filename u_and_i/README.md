# u_and_i

A new Flutter project.

만난 지 며칠 U&I

상태관리, CupertinoWidget , CupertinoDatePicker, Dialog, DateTime

Flutter의 2가지 디자인 시스템: 
- 구글의 머티리얼 디자인을 기반으로 하는 Material Widget 
- iOS 스타일의 디자인인 Cupertino Widget

## Features

- 사용자가 직접 원하는 날짜 선택
- 날짜 선택시 실시간으로 화면의 D-Day 및 만난 날 업데이트

## Usage

1. 가운데 하트 클릭해서 날짜 선택 기능 실행
2. 년, 월, 일을 스크롤해서 원하는 날짜 선택
3. 배경을 눌러서 날짜 저장하기 및 되돌아오기

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Steps

### fonts, images fold 생성

- /assets/images
- /fonts
image 및 폰트를 위에 만든 폴더에 넣기

### modify pubspec.yaml to add assets, fonts keys

add assets, fonts keys and execute `pub get`

- pubspec.yaml
```yaml
flutter:
  uses-material-design: true

  assets:
    - assets/images/

  fonts:
    - family: parisienne
      fonts:
        - asset: fonts/Parisienne-Regular.ttf
    - family: sunflower
      fonts:
        - asset: fonts/Sunflower-Light.ttf
        - asset: fonts/Sunflower-Medium.ttf
          weight: 500
        - asset: fonts/Sunflower-Bold.ttf
          weight: 700
```

### create a home screen with StatelessWidget

먼저 StatelessWidget으로 생성해서 작업 후 StatefulWidget로 변경한다.
- /lib/screens/home_screen.dart
```dart
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('home screen'),
    );
  }
}
```

### modify main.dart

- /lib/main.dart
```dart
void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}

```

### add _DDay widget and _CoupleImage to the HomeScreen widget

- /lib/screens/home_screen.dart
```dart
class _DDay extends StatelessWidget {  
  @override
  Widget build(BuildContext context) {
    return Text('DDay widget');
  }
}

class _CoupleImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Couple image widget');
  }
}
```

### change background color

- /lib/screens/home_screen.dart
```dart
  @override
    Widget build(BuildContext context) {
      return Scaffold(
          backgroundColor: Colors.pink[100], // 100% opacity(불투명)
```

### add Image to the _CoupleImage widget

이미지 중앙 정렬 및 화면의 반만큼 높이 구현

| MediaQuery.of(context)는 현재 위젯 트리에서 가장 가까이에 있는 MedisQuery값을 찾아낸다. 
| 여기서는 MaterialApp에 있는 MediaQuery값이므로 
| MediaQuery.of(context).size.height는 MaterialApp의 높이를 의미한다.

- /lib/screens/home_screen.dart
```dart
class _CoupleImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/images/middle_image.png',
        height: MediaQuery.of(context).size.height / 2, // 이미지 높이를 화면의 반으로 설정
      ),
    );
  }
}
```