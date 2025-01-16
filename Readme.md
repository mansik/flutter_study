# flutter study

코드팩토리의 플러터 프로그래밍 2판

## language version

- flutter : 3.27.1
- dart: 3.6.0

## Environment Device Manager

android: Pixel 8 API 34

## How to create project

1. new flutter project -> empty project로 생성 후
2. 개별 프로젝트는 이 프로젝트의 아래에 위치해서 생성함

## Project fold structure

- screens
- components
- models
- consts
  
## Android Studio shortcut

- *Reformat Code: `Ctrl + Alt + L` 
- *Basic code completion: `Ctrl + Space`
- Smart code completion: `Ctrl + Shift + Space`
- complete statement: `Ctrl + Shift + Enter`
- *Show Context Actions: `Alt + Enter`
(Wrap with widget,Remove this Widget, Convert to stateless widget, Convert to stateful widget, Convert to async function)
- *Generate code: `Alt + Ins`
- *Parameter info: `Ctrl + P` 
- *Quick documentation loop: `Ctrl + Q`
- Quick definition: `Ctrl + Shift + I`
- View Override Method: `Ctrl + O`
- 
- *Extend selection: `Ctrl + W`
- *Shrink selection: `Ctrl + Shift + W`
- *Recent files popup: `Ctrl + E`
- *Rename: `Shift + F6`
- *Go to previous or next editor tab: `Alter + Left(Right)`
- Search everywhere: `Double Shift`
- Duplicate current line: `Ctrl + D`
- Delete line at caret: `Ctrl + Y`
- 
- Run: `Shift + F10`
- hot reload: `Ctrl + \`, Ctrl+ S(저장)하면 저장이 되면서 hot reload가 됨.
  
## pubspec.yaml 파일

프로젝트에서 사용할 폰트, 이미지, 외부 플러그인 등을 지정하는데 사용한다.  
yaml 파일을 수정 후에는 반드시 앱을 다시 실행해야 한다.  
[youtube](https://youtu.be/1GRKklx4xeo)

## How to add plugin

- [pub.dev](https://pub.dev): 플러터 오픈 소스 저장소, 여기서 plugin을 찾아서 등록함
- pubspec.yaml 파일에 플러그인을 추가하고 `pub get` 버튼을 눌러주면 등록한 플러그인을 사용할 수 있다.
- `pubspec.yaml 파일`
```yaml
dependencies:
  # webview_flutter: ^4.10.0 하면 
  # /android/settings.gradle 에서 pluings {  id "com.android.application" version "8.2.1" ...로 해줘야 한다.
  webview_flutter: 4.10.0 # 웹뷰 플러그인 추가 -> flutter command 에 'Pub get' 버튼 눌러서 현재 프로젝트에 적용
```
- yaml 파일을 수정 후에는 반드시 앱을 다시 실행해야 한다.

### plugins

- sensors_plus: Accelerometer(핸드폰의 움직이는 속도 측정), Gyroscope(회전 측정), Magnetometer(자기장 측정)
- geolocator: gps
- camera
- flutter_blue: bluetooth
- wifi_iot: wifi

## Color Hex Code

```dart
color: Color(0xFFF99231), // 0x(16진수), FF: 불투명도 100%, F99231: 색상 코드
```

## Widgets

위젯의 2가지 형태
- stateful widget: 위젯 내부에서 값이 변경되었을 때 위젯 자체에서 다시 렌더링을 실행시킬 수 있는 위젯, 자동완성: stful 탭
- stateless widget: 위젯 내부에서 값이 변경되어도 위젯 자체적으로는 다시 렌더링할 수 없는 위젯, stless 탭탭
p.221

### Text widget

- Text

### Gesture related widgets

- Botton
- ElevatedButton
- OutlinedButton
- IconButton
- GestureDetector
- FloatingActionButton

### Design related widgets

- Container
- SizedBox
- Padding
- SafeArea

### Layout related widgets

- Row
- Column
- Flexible
- Expanded
- Stack
- ListView
 
## use image widget

several constructors: Image, Image.asset, Image.network, Image.file, Image.memory

### Image.asset: asset 파일로 이미지를 그림

1. project에 assets 폴더 생생 후 이미지 파일(logo.png) 복사
2. pubspec.yaml파일에서 asset 폴더 수정 -> pub get 클릭
3. run: stop -> run
4. Image.asset() 추가
5. Colors.orange -> Color(0xFFF99231)로 수정 : 0x(16진수), FF: 불투명도 100%, F99231: 색상 코드 


## splash screen app

p.175 7.4 연습용 앱 만들기: 스플래시 스크린 앱

1. 기본 위젯 만들기: body: Center: splash_screen_1.dart
2. 배경색 변경하기: body: Container로 수정: splash_screen_2.dart
3. 배경 바꾸기
    1. create `assets` fold
    2. fix pubspec.yaml -> click `pub get` or on terminal input `flutter pub get` 
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


### blog web app

webview, appbar

### web app

webview, appbar

### image carousel app: 전자액자

stateful, timer.periodic



