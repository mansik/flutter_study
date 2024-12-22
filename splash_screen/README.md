# splash_screen

A new Flutter project.
p.175 7.4 splash screen

1. 기본 위젯 만들기: body: Center: splash_screen_1.dart 
2. 배경색 변경하기: body: Container로 수정: splash_screen_2.dart
3. 배경 바꾸기
   1. create `assets` fold
   2. fix pubspec.yaml -> click `pub get` 
    ```yaml
      assets: # 주석 해제
        - assets/ # 폴더 추가
    ```
   3. rerun: stop -> run, put get 후에는 반드시 실행
   4. Image.asset() 추가
   5. Colors.orange -> Color(0xFFF99231)로 수정
4. animation widget 추가: LinearProgressIndicator, CircularProgressIndicator
5. 위젯 정렬하기 : column, row widget
   1. Column 위젯 추가
   2. 가운데 정렬 추가
   3. 이미지 사이즈 추가
   4. Row 위젯 추가
      1. Row 위젯으로 Column 위젯(왼쪽부터 정렬)을 감싸면 Row 위젯도 왼쪽부터 위젯들을 정렬한다.
      2. Column 위젯은 세로로 최대한 크기를 차지하고 가로로는 최소한 크기만 차지한다.
      3. Row 위젯은 가로로 최대한 크기를 차지하고 세로로 최소 크기를 차지한다.
   5. CircularProgressIndicator 색 변경: valueColor 추가

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
