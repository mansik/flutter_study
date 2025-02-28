# flutter study

코드팩토리의 플러터 프로그래밍 2판

## language version

- flutter : 3.27.1
- dart: 3.6.0

## Environment Device Manager

android: Pixel 8 API 34, android 14
android: Pixel 9 API 35, android 15

## How to create project

1. new flutter project -> empty project로 생성 후
2. 개별 프로젝트는 이 프로젝트의 아래에 위치해서 생성함

## Project fold structure

- screens
- components
- models
- consts
- repogitory
  
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

## tips.

### (dart v3.7이상) 라인 정렬 기능(project 별로 셋팅 가능)

- analysis_options.yaml
```yaml
  include: package:flutter_lints/flutter.yaml

  # 라인 정렬이 page_width에 따라 달라짐. : default page width of 80
  formatter:
    page_width: 80
```

### Gradle DSL(Domain Specific Language)(.gradle)와 Kotlin DSL 설정 파일(.gradle.kts)

* Gradle DSL(Domain Specific Language)선택지에 Groovy 혹은 Kotlin이 있었어나
* Flutter v3.29에서 Groovy가 삭제되고 Kotlin을 사용하게 되었음
* Kotlin DSL(.gradle.kts)을 사용한 Gradle 스크립트 설정은 더 타입 안전(정적 타입 검사)하며, 코드 완성 기능을 제공합니다.

* build.gradle: Groovy 방식, Flutter v3.29이전 버전에서 많이 사용되었음
* build.gradle.kts: Kotlin 방식, Flutter v3.29부터 무조건 사용함.

### Flutter Project에서 android directory를 삭제하고 다시 생성하는 방법(migration from .gradle to .gradle.kts)

1. open project in android studio
2. open Terminal
3. your project prompt> rm -r android
4. your project prompt> flutter create --platforms=android .

### Flutter pub(라이브러리) 사용시 주의 사항

* 각종 NDK, Gradle 설정, jdk 설정등을 맞춰줘야 한다.
* SDK Management 에서 SDK Tool도 update 해줘야 한다.

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

### u_and_i app: 만난지 며칠

Cepertino Widget, CupertinoDatePicker, Dialog, StateWidget 상태관리

DateTime, Duration, setState(), MediaQuery, Theme, showCupertinoDialog

### randon_dice app: 디지털 주사위

가속도계, sensor_plus, BottomNavigationBar, Slider

TabBarView, Slider, initState(), dart:math

### vid_player app: 동영상 플레이어

화면 회전, 시간 변환, String 패딩

Stack, Positioned, VideoPlayer, ImagePicker, LinearGradient, Align, didUpdateWidget()

### video_call app: 영상 통화

WebRTC, 내비게이션, 아고라 API, 권한 관리

### chool_check app: 출석 체크

구글 지도, Geolocator plugin, Dialog

Circle, Marker

### image_editor app: 포토 스티커

GestureDetector, ImagePicker, InteractiveViewer를 이용한 Transform, hashCode와 == 오퍼레이터 오버라이드

onScaleUpdate, ImageGallerySaverPlus plugin

### cf_tube: 코팩튜브

REST API, JSON, 유튜브 API

Dio, ListView, RefreshIndicator



