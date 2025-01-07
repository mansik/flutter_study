# vid_player

A new Flutter project.

화면 회전, 시간 변환, String 패팅
- video_player 플러그인 이름과 겹치지 않게 작명에 주의

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Features

동영상 플레이어
- 로고나 갤러리 버튼을 눌러서 동영상을 선택
- 동영상을 재생, 중지, 3초 뒤, 3초 앞으로 이동
- Slider 위젯을 이용해서 원하는 동영상의 위치로 이동
- 동영상 화면을 탭하면 동영상을 제어하는 버튼들을 화면에 보여줌

## Usage

- 홈스크린에서 로고를 눌러 동영상을 선택
- Slider 위젯을 조작해서 원하는 위치로 이동하거나 화면을 한 번 탭해서 컨트롤 버튼을 띄운 후 동영상을 30초 앞으로 돌려보기
- 갤러리 아이콘 버튼을 눌러서 새로운 동영상을 선택

## Skill

Stack, Positioned, VideoPlayer, ImagePicker, LinearGradient

## Plugin

- video_player: 2.8.1
- image_picker: 1.0.4 

## prior knowledge

- padLeft(), padRight() 함수
```dart
// 최소 길이가 3이며, 길이가 부족할 때 '0'을 왼쪽부터 채운다. 
'23'.padLeft(3, '0'); // 023,  3: 최소 길이, '0': 길이가 부족할 때 채워줄 값, padLeft: 왼쪽에 채줘준다.
'23'.padRight(3, '0'); // 230
'234'.padRight(3, '0'); // 234
```

## Layout

HomeScreen widget
- renderEmpty(): logo, app name
- renderVideo(): play, stop, prev, next, select movies


## Setps

### add a video to device

drag and grop video to device

### add the image and video plugins in pubspec.yaml, `pub get`

see below for [run and fix errors](#run-and-fix-errors)
- /assets/images/
- /assets/video/
```yaml
dependencies:
  image_picker: ^1.1.2
  video_player: ^2.9.2
    
flutter:
  assets:
    - assets/images/
```

### configuring native setting
adding permissions for gallery or video access 

- iOS: NSPhotoLibraryUsageDescription permission to Info.plist file
- android: add permission.READ_EXTERNAL_STORAGE permission to AndroidManifest.xml file
- /android/app/src/main/AndroidManifest.xml
```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
    <application
```

### initialize project

- /lib/main.dart
```dart
import 'package:flutter/material.dart';
import 'package:vid_player/screens/home_screen.dart';

void main() {
  runApp(
    MaterialApp(
      home: HomeScreen(),
    ),
  );
}
```

- lib/screens/home_screen.dart
```dart
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text('home'));
  }
}
```

### run and fix errors

1. modify /android/settings.gradle
Upgrade the version of com.android.application from 8.1.0 to 8.2.1.
- /android/settings.gradle
```gradle
plugins {
    id "dev.flutter.flutter-plugin-loader" version "1.0.0"
    id "com.android.application" version "8.2.1" apply false
    id "org.jetbrains.kotlin.android" version "1.8.22" apply false
}
```

2. modify /android/app/build.gradle
Upgrade the versin of compileOptions and kotlinOptions from JavaVersion.VERSION_1_8 to JavaVersion.VERSION_17
or change the minSdk from flutter.minSdkVersion to 30

compileOptions {
sourceCompatibility = JavaVersion.VERSION_17
targetCompatibility = JavaVersion.VERSION_17
}

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17
    }

or 
minSdk = 30

- /android/app/build.gradle
```gradle
android {
    namespace = "com.example.vid_player"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_1_8
    }

    defaultConfig {        
        applicationId = "com.example.vid_player"        
        minSdk = 30 //flutter.minSdkVersion
```

### implement HomeScreen as a StatefulWidget

Manage state related to video file selection on the home screen
홈 스크린에서 동영상 파일 선택과 관련한 상태 관리를 하기 위해서 HomeScreen을 StatefulWidget으로 변경한다.

1. 동영상을 선택할 때 사용할 image_picker 플러그인은 
이미지나 동영상을 선택했을 때 XFile이라는 클래스 형태로 선택된 값을 반환한다.
2. 동영상이 선택 유무에 따라 renderEmpty(), renderVideo() 함수가 반환하는 위젯을 보여준다. 

- /lib/screens/home_screen.dart
```dart
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

/// 동영상을 선택할 때 사용할 image_picker 플러그인은 
/// 이미지나 동영상을 선택했을 때 XFile이라는 클래스 형태로 선택된 값을 반환한다.
class _HomeScreenState extends State<HomeScreen> {
  XFile? video; // 이미지나 동영상을 선택했을 때 저장할 변수(image_picker plugin)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: video == null ? renderEmpty(): renderVideo(),
    );
  }

  // 동영상 선택 전 보여줄 위젯
  Widget renderEmpty(){
    return Container();
  }

  // 동영상 선택 후 보여줄 위젯
  Widget renderVideo(){
    return Container();
  }
}
```


### implement renderEmpty()

add _Logo widget, _AppName widget

- /lib/screens/home_screen.dart
```dart
/// 동영상을 선택할 때 사용할 image_picker 플러그인은
/// 이미지나 동영상을 선택했을 때 XFile이라는 클래스 형태로 선택된 값을 반환한다.
class _HomeScreenState extends State<HomeScreen> {
  XFile? video; // 이미지나 동영상을 선택했을 때 저장할 변수(image_picker plugin)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: video == null ? renderEmpty() : renderVideo(),
    );
  }

  // 동영상 선택 전 보여줄 위젯
  Widget renderEmpty() {
    return Container(
      width: MediaQuery.of(context).size.width, // 너비를 MaterialApp 위젯의 크기로 늘려주기
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 30.0, // 아래 SizedBox 대신 사용 가능
        children: [
          _Logo(), // 로고 이미지
          // SizedBox(height: 30.0), // flutter 3.27에서 row, column에서 spacing 사용
          _AppName(), // 앱이름
        ],
      ),
    );
  }

  // 동영상 선택 후 보여줄 위젯
  Widget renderVideo() {
    return Container();
  }
}

/// widget to display the logo
class _Logo extends StatelessWidget {
  const _Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo.png',
    );
  }
}

/// widget to display the app title
class _AppName extends StatelessWidget {
  const _AppName({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: 30.0,
      fontWeight: FontWeight.w300,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 10.0,
      children: [
        Text(
          'VIDEO',
          style: textStyle,
        ),
        Text(
          'PLAYER',
          style: textStyle.copyWith(
            // textStyle에서 두께만 700으로 변경
            fontWeight: FontWeight.w700,
          ),
        )
      ],
    );
  }
}
```

### implement renderEmpty()

Add gradient to the background color
- BoxDecoration class: Container 위젯의 배경색, 테투리, 모서리 둥근 정도 등 전반적인 디자인을 변경할 수 있다.
- /lib/screens/home_screen.dart
```dart
  // 동영상 선택 전 보여줄 위젯
  Widget renderEmpty() {
    return Container(
      width: MediaQuery.of(context).size.width, // 너비를 MaterialApp 위젯의 크기로 늘려주기
      decoration: getBoxDecoration(), // 배경색 gradient 적용
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 30.0, // 아래 SizedBox 대신 사용 가능
        children: [
          _Logo(), // 로고 이미지
          // SizedBox(height: 30.0), // flutter 3.27에서 row, column에서 spacing 사용
          _AppName(), // 앱이름
        ],
      ),
    );
  }

  // Container 위젯의 배경색 gradient 적용
  BoxDecoration getBoxDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF2A3A7C),
          Color(0xFF000118),
        ],
      ),
    );
  }
```

### implement renderEmpty()

Add file selection to _Logo widget
- (4.1~)_Logo 위젯에 GestureDetector를 추가해서 onTap() 함수가 실행됐을 때 동영상 선택하는 함수를 구현
- /lib/screens/home_screen.dart
```dart

/// 동영상을 선택할 때 사용할 image_picker 플러그인은
/// 이미지나 동영상을 선택했을 때 XFile이라는 클래스 형태로 선택된 값을 반환한다.
class _HomeScreenState extends State<HomeScreen> {

  // 동영상 선택 전 보여줄 위젯
  Widget renderEmpty() {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width, // 너비를 MaterialApp 위젯의 크기로 늘려주기
      decoration: getBoxDecoration(), // 배경색 gradient 적용
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 30.0, // 아래 SizedBox 대신 사용 가능
        children: [
          _Logo(
            onTap: onNewVideoPressed, // 4.1 로고를 탭하면 실행하는 함수
          ), // 로고 이미지
          // SizedBox(height: 30.0), // flutter 3.27에서 row, column에서 spacing 사용
          _AppName(), // 앱이름
        ],
      ),
    );
  }

  // 4.2 imagePicker를 통해서 동영상을 선택
  void onNewVideoPressed() async {
    final video = await ImagePicker().pickVideo(source: ImageSource.gallery,);

    if (video != null) {
      setState(() {
        this.video = video;
      });
    }
  }
}

/// widget to display the logo
class _Logo extends StatelessWidget {
  final GestureTapCallback onTap; // 탭했을 때 실행할 함수

  const _Logo({required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // 4.3 상위 위젯으로부터 탭 콜백 받기
      child:
      Image.asset(
        'assets/images/logo.png',
      ),
    );
  }
}
```

### implement renderVideo()

add /lib/component/custom_video_player.dart
- CustomVideoPlayer 위젯은 HomeScreen 위젯에서 선택된 동영상을 재상하는 모든 상태를 관리한다.
- 그러므로, SatefulWidget으로 생성한다.

- /lib/component/custom_video_player.dart
```dart
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CustomVideoPlayer extends StatefulWidget {
  final XFile video; // 선택한 동영상을 저장

  const CustomVideoPlayer({required this.video, super.key});

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'custom video player',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
```

modify renderVideo()

- /lib/home_screen.dart
```dart
// 동영상 선택 후 보여줄 위젯
Widget renderVideo() {
  return Center(
    child: CustomVideoPlayer(video: video!,),
  );
}
```

### implement CustomVideoPlayer

VideoPlayerController와 VideoPlayer 위젯을 사용해서 선택한 동영상을 화면에 보여주는 기능을 구현

VideoPlayerController's Named Constructors
- VideoPlayerController.asset: asset 파일의 경로로부터 동영상을 불러옴
- VideoPlayerController.network: 네트워크 URL로부터 동영상을 불러옴
- VideoPlayerController.file: 파일 경로로부터 동영상을 불러옴

- /lib/component/custom_video_player.dart
```dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  final XFile video; // 선택한 동영상을 저장

  const CustomVideoPlayer({required this.video, super.key});

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  // 2.1 동영상을 조작하는 컨트롤러
  VideoPlayerController? videoController;

  // 2.2 컨트롤러 초기화
  // VideoPlayerController는
  // State가 생성되는 순간 한 번만 생성되어야 하므로 initState() 함수에서 초기화
  @override
  void initState() {
    super.initState();

    initializeController(); // 2.2 컨트롤러 초기화
  }

  // 2.3 선택한 동영상으로 컨트롤러 초기화
  initializeController() async {
    // 2.3.1 파일로부터 VideoPlayerController 생성
    final videoController = VideoPlayerController.file(
      File(widget.video.path),
    );

    // 2.3.2 생성 후 VideoPlayerController 초기화
    await videoController.initialize();

    // 2.3.3 초기화 후 클래스 변수에 저장
    setState(() {
      this.videoController = videoController;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 2.4 동영상 컨트롤러가 준비 중일 때 로딩 표시
    if (videoController == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    // 2.5 동영상 비율에 따른 화면 렌더링
    // AspectRatio(종횡비): child 매개변수에 입력되는 위젯의 비율을 정할 수 있는 위젯
    // videoController!.value.aspectRatio: 입력된 동영상의 비율
    return AspectRatio(
      aspectRatio: videoController!.value.aspectRatio, // 16/9,...
      child: VideoPlayer(
        videoController!,
      ),
    );
  }
}
```

### link Slider widget with video playback(비디오 재생과 연결)

두 가지 기능 구현
1. Slider 위젯을 스크롤하면 동영상이 해당되는 위치로 이동하기
2. 동영상이 실행되는 위치에 따라 자동으로 Slider 위젯이 움직이기


(3.1~)여기서는 화면만 구현
- VideoPlayer 위젯 위에 Slider 위젯이 위치하도록 Stack 위젯을 사용한다. 
- Stack 위젯은 List에 입력되는 순서대로 아래부터 쌓아 올려진다. children 위젯들을 정중앙에 위치시킨다.
- Positioned 위젯은 child 위젯의 위치를 정할 수 있는 위젯, left, right, top, bottom: 픽셀 단위

- /lib/component/custom_video_player.dart
```dart
 @override
  Widget build(BuildContext context) {
    // 2.4 동영상 컨트롤러가 준비 중일 때 로딩 표시
    if (videoController == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    // 2.5 동영상 비율에 따른 화면 렌더링
    // AspectRatio(종횡비): child 매개변수에 입력되는 위젯의 비율을 정할 수 있는 위젯
    // videoController!.value.aspectRatio: 입력된 동영상의 비율
    return AspectRatio(
      aspectRatio: videoController!.value.aspectRatio, // 16/9,...
      // 3.1 Stack 위젯을 사용해서 VideoPlayer 위젯 위에 Slider 위젯을 올림
      child: Stack(
        children: [
          VideoPlayer(
            videoController!,
          ),
          Positioned(
            // 3.2 child 위젯의 위치를 정할 수 있는 위젯
            left: 0, // right: 0 과 함께 사용하여 좌우측 Slider 위젯을 끝까지 늘림            
            right: 0,
            bottom: 0, // Stack 위젯의 가장 아래에(아래에서 0픽셀 떨어진 위치) Slider 위젯을 위치시킴
            child: Slider(
              // 3.3 Slider 위젯
              onChanged: (double val) {},
              value: 0,
              min: 0,
              max: videoController!.value.duration.inSeconds
                  .toDouble(), // max값은 현재 동영상의 전체 재생 길이를 초 단위로 변환
            ),
          ),
        ],
      ),
    );
  }
```

### implement Slider widget parameter

두 가지 기능 구현
1. Slider 위젯을 스크롤하면 동영상이 해당되는 위치로 이동하기
2. 동영상이 실행되는 위치에 따라 자동으로 Slider 위젯이 움직이기

(4.1~)
- /lib/component/custom_video_player.dart
```dart
 @override
  Widget build(BuildContext context) {
    // 2.4 동영상 컨트롤러가 준비 중일 때 로딩 표시
    if (videoController == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    // 2.5 동영상 비율에 따른 화면 렌더링
    // AspectRatio(종횡비): child 매개변수에 입력되는 위젯의 비율을 정할 수 있는 위젯
    // videoController!.value.aspectRatio: 입력된 동영상의 비율
    return AspectRatio(
      aspectRatio: videoController!.value.aspectRatio, // 16/9,...
      // 3.1 Stack 위젯을 사용해서 VideoPlayer 위젯 위에 Slider 위젯을 올림
      child: Stack(
        children: [
          VideoPlayer(
            videoController!,
          ),
          Positioned(
            // 3.2 child 위젯의 위치를 정할 수 있는 위젯
            left: 0, // right: 0 과 함께 사용하여 좌우측 Slider 위젯을 끝까지 늘림
            right: 0,
            bottom: 0, // Stack 위젯의 가장 아래에(아래에서 0픽셀 떨어진 위치) Slider 위젯을 위치시킴
            // 3.3 Slider 위젯
            child: Slider(
              // 4.1 슬라이더가 이동할 때마다 실행할 함수
              onChanged: (double val) {
                // seekTo: 동영상의 재생위치를 특정 위치로 이동
                videoController!.seekTo(
                  Duration(seconds: val.toInt()),
                );
              },
              // 4.2 현재 재생 위치를 초 단위로 표현
              value: videoController!.value.position.inSeconds.toDouble(),
              min: 0,
              max: videoController!.value.duration.inSeconds
                  .toDouble(), // max값은 현재 동영상의 전체 재생 길이를 초 단위로 표현
            ),
          ),
        ],
      ),
    );
  }
```

### implement Video Control button

동영상을 컨트롤하는 4개의 버튼 구현
- 재생/일시정지 버튼
- 뒤로 3초 돌리기 버튼
- 앞으로 3초 돌리기 버튼
- 새로운 동영상 선택하기 버튼

add /lib/component/custom_icon_button.dart

- /lib/component/custom_icon_button.dart
```dart
import 'package:flutter/material.dart';

/// iconbutton 위젯
///
/// 외부에서 GestureTapCallback와 IconData를 입력받아서 iconbutton 위젯을 만든다.
class CustomIconButton extends StatelessWidget {
  // 외부에서 입력 받을 데이터 선언
  final GestureTapCallback onPressed; // 아이콘 버튼을 눌렀을 때 실행할 함수
  final IconData iconData; // 아이콘

  const CustomIconButton(
      {required this.onPressed, required this.iconData, super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      iconSize: 30.0,
      color: Colors.white,
      icon: Icon(iconData),
    );
  }
}
```

(5.1~)버튼 구현
- /lib/component/custom_video_player.dart
```dart
@override
  Widget build(BuildContext context) {
    // 2.4 동영상 컨트롤러가 준비 중일 때 로딩 표시
    if (videoController == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    // 2.5 동영상 비율에 따른 화면 렌더링
    // AspectRatio(종횡비): child 매개변수에 입력되는 위젯의 비율을 정할 수 있는 위젯
    // videoController!.value.aspectRatio: 입력된 동영상의 비율
    return AspectRatio(
      aspectRatio: videoController!.value.aspectRatio, // 16/9,...
      // 3.1 Stack 위젯을 사용해서 VideoPlayer 위젯 위에 Slider 위젯을 올림
      child: Stack(
        children: [
          VideoPlayer(
            videoController!,
          ),
          Positioned(
            // 3.2 child 위젯의 위치를 정할 수 있는 위젯
            left: 0, // right: 0 과 함께 사용하여 좌우측 Slider 위젯을 끝까지 늘림
            right: 0,
            bottom: 0, // Stack 위젯의 가장 아래에(아래에서 0픽셀 떨어진 위치) Slider 위젯을 위치시킴
            // 3.3 Slider 위젯
            child: Slider(
              // 4.1 슬라이더가 이동할 때마다 실행할 함수
              onChanged: (double val) {
                // seekTo: 동영상의 재생위치를 특정 위치로 이동
                videoController!.seekTo(
                  Duration(seconds: val.toInt()),
                );
              },
              // 4.2 현재 재생 위치를 초 단위로 표현
              value: videoController!.value.position.inSeconds.toDouble(),
              min: 0,
              max: videoController!.value.duration.inSeconds
                  .toDouble(), // max값은 현재 동영상의 전체 재생 길이를 초 단위로 표현
            ),
          ),
          // 5.1 새 동영상 아이콘: 오른쪽 위에 위치
          Align(
            alignment: Alignment.topRight,
            child: CustomIconButton(
                onPressed: () {}, iconData: Icons.photo_camera_back),
          ),
          // 5.2 동영상 재생 관련 아이콘: 가운데 위치
          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // 되감기 버튼
                CustomIconButton(
                  onPressed: () {},
                  iconData: Icons.rotate_left,
                ),
                // 재생 버튼
                CustomIconButton(
                  onPressed: () {},
                  iconData: videoController!.value.isPlaying
                      ? Icons.pause
                      : Icons.play_arrow,
                ),
                // 앞으로 감기 버튼
                CustomIconButton(
                  onPressed: () {},
                  iconData: Icons.rotate_right,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
```

### implement onPressed function of video control button

(6.1~)버튼 구현
- /lib/component/custom_video_player.dart
```dart
@override
  Widget build(BuildContext context) {
    // 2.4 동영상 컨트롤러가 준비 중일 때 로딩 표시
    if (videoController == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    // 2.5 동영상 비율에 따른 화면 렌더링
    // AspectRatio(종횡비): child 매개변수에 입력되는 위젯의 비율을 정할 수 있는 위젯
    // videoController!.value.aspectRatio: 입력된 동영상의 비율
    return AspectRatio(
      aspectRatio: videoController!.value.aspectRatio, // 16/9,...
      // 3.1 Stack 위젯을 사용해서 VideoPlayer 위젯 위에 Slider 위젯을 올림
      child: Stack(
        children: [
          VideoPlayer(
            videoController!,
          ),
          Positioned(
            // 3.2 child 위젯의 위치를 정할 수 있는 위젯
            left: 0, // right: 0 과 함께 사용하여 좌우측 Slider 위젯을 끝까지 늘림
            right: 0,
            bottom: 0, // Stack 위젯의 가장 아래에(아래에서 0픽셀 떨어진 위치) Slider 위젯을 위치시킴
            // 3.3 Slider 위젯
            child: Slider(
              // 4.1 슬라이더가 이동할 때마다 실행할 함수
              onChanged: (double val) {
                // seekTo: 동영상의 재생위치를 특정 위치로 이동
                videoController!.seekTo(
                  Duration(seconds: val.toInt()),
                );
              },
              // 4.2 현재 재생 위치를 초 단위로 표현
              value: videoController!.value.position.inSeconds.toDouble(),
              min: 0,
              max: videoController!.value.duration.inSeconds
                  .toDouble(), // max값은 현재 동영상의 전체 재생 길이를 초 단위로 표현
            ),
          ),
          // 5.1 새 동영상 아이콘: 오른쪽 위에 위치
          Align(
            alignment: Alignment.topRight,
            child: CustomIconButton(
                onPressed: () {}, iconData: Icons.photo_camera_back),
          ),
          // 5.2 동영상 재생 관련 아이콘: 가운데 위치
          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // 되감기 버튼
                CustomIconButton(
                  onPressed: onReversePressed,
                  iconData: Icons.rotate_left,
                ),
                // 재생 버튼
                CustomIconButton(
                  onPressed: onPlayPressed,
                  iconData: videoController!.value.isPlaying
                      ? Icons.pause
                      : Icons.play_arrow,
                ),
                // 앞으로 감기 버튼
                CustomIconButton(
                  onPressed: onForwardPressed,
                  iconData: Icons.rotate_right,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // 6.1 3초 되감기
  void onReversePressed() {
    final currentPosition = videoController!.value.position;

    Duration position = Duration(); // 0초로 실행 위치 초기화

    if (currentPosition.inSeconds > 3) {
      position = currentPosition - Duration(seconds: 3);
    }

    videoController!.seekTo(position);
  }

  // 6.2 재생, 일시정지
  void onPlayPressed() {
    if (videoController!.value.isPlaying) {
      videoController!.pause();
    } else {
      videoController!.play();
    }
  }

  // 6.3 3초 앞으로 감기
  void onForwardPressed() {
    final maxPosition = videoController!.value.duration; // 동영상 길이
    final currentPosition = videoController!.value.position;

    Duration position = maxPosition; // 동영상 길이로 실행 위치 초기화

    if ((maxPosition - Duration(seconds: 3)).inSeconds >
        currentPosition.inSeconds) {
      position = currentPosition + Duration(seconds: 3);
    }

    videoController!.seekTo(position);
  }
```

### link Slider widget with video control button

controller의 addListener() 함수를 사용해서 videoController 변수의 상태가 변경될 때마다 setState() 함수로
build() 함수를 재실행하여 동영상의 위치가 Slider 위젯에 반영되도록 한다.

(7.1~)
- /lib/component/custom_video_player.dart
```dart
  // 2.3 선택한 동영상으로 컨트롤러 초기화
  initializeController() async {
    // 2.3.1 파일로부터 VideoPlayerController 생성
    final videoController = VideoPlayerController.file(
      File(widget.video.path),
    );

    // 2.3.2 생성 후 VideoPlayerController 초기화
    await videoController.initialize();
    
    // 7.1 컨트롤러의 속성이 변경될 때마다 실행할 함수 등록
    videoController.addListener(videoControllerListener);

    // 2.3.3 초기화 후 클래스 변수에 저장
    setState(() {
      this.videoController = videoController;
    });
  }

  // 7.2 동영상의 재생 상태가 변경될 때마다
  // setState()를 실행해서 build()를 재실행한다.
  void videoControllerListener() {
    setState(() {});
  }
  
  // 7.3 listener 삭제
  @override
  void dispose() {
    videoController!.removeListener(videoControllerListener);
    super.dispose();
  }
```

### rerun

핫 리로드를 실행하면 Slider 위젯이 작동되지 않는다. State가 생성되는 순간 단 한번만 initState()가 실행되기 때문이다.
그러므로 앱을 재실행해야 동영상 재생 위치에 따라 Slider가 이동되고 Slider 및 버튼의 작동이 정상적으로 작동한다.

### implement new video button

영상 선택 버튼의 기능을 정의,
HomeScreen에 이미 정의를 해뒀기 때문에 단순히 onNewVideoPressed() 함수를 전달하는 방식으로 작업한다.

1. HomeScreen에서 CustomVideoPlayer 위젯 생성시 onNewVideoPressed 함수를 매개변수로 준다.(6.1~)
- /lib/home_screen.dart
```dart
  // 동영상 선택 후 보여줄 위젯
  Widget renderVideo() {
    return Center(
      child: CustomVideoPlayer(
        video: video!,
        onNewVideoPressed: onNewVideoPressed, // 6.1 onNewVideoPressed 함수를 전달
      ),
    );
  }
```

2. onNewVideoPresse 함수를 받을 수 있도록 생성자 구현(8.1~)
- /lib/component/custom_video_player.dart
```dart
class CustomVideoPlayer extends StatefulWidget {
  final XFile video; // 선택한 동영상을 저장
  final GestureTapCallback onNewVideoPressed; // 8.1 새로운 동영상을 선택하면 실행되는 함수

  const CustomVideoPlayer(
      {required this.video, required this.onNewVideoPressed, super.key});
```

3. 새 동영상 아이콘을 눌렀을 때 실행할 함수 연결(8.1~)
- /lib/component/custom_video_player.dart
```dart
          // 5.1 새 동영상 아이콘: 오른쪽 위에 위치
          Align(
            alignment: Alignment.topRight,
            child: CustomIconButton(
                onPressed: widget.onNewVideoPressed, // 8.2 새로운 동영상을 선택할 함수 실행
                iconData: Icons.photo_camera_back),
          ),
```

### 동영상을 이미 선택한 상태에서도 새로운 동영상을 선택할 수 있게 기능 구현

동영상을 이미 선택한 상태에서 새로운 동영상을 선택해도 화면에는 새로 선택한 영상이 실행되지 않는다.
그 이유는 동영상의 소스를 videoController 변수를 인스턴스화할 때 선언했는데 현재 코드에서 videoController 변수는 
initState() 함수에서만 선언되기 때문이다.
그래서 SatefulWidget의 생명주기의 또 하나의 함수인 didUpdateWidget() 함수를 사용해서 새로운 동영상이 선택되었을 때
videoController를 새로 생성하도록 코드를 추가해야 한다.
- StatefulWidget의 생명주기에서 위젯은 매개변수 값이 변경될 때 폐기되고 새로 생성된다.

- /lib/component/custom_video_player.dart
```dart
class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  // 2.1 동영상을 조작하는 컨트롤러
  VideoPlayerController? videoController;
  
  // 9.1 didUpdateWidget() 함수를 사용해서 새로운 동영상이 선택되었을 때 videoController를 
  // 새로 생성하도록 한다.
  // StatefulWidget의 생명주기에서 위젯은 매개변수 값이 변경될 때 폐기되고 새로 생성된다.
  @override
  void didUpdateWidget(covariant CustomVideoPlayer oldWidget) {    
    super.didUpdateWidget(oldWidget);
    
    // 새로 선택한 동영상이 같은 동영상인지 확인
    if(oldWidget.video.path != widget.video.path) {
      initializeController();
    }
  }
```

### implement the ability to hide/show the control button

화면을 탭하여 컨트롤을 숨기고 보이도록 구현(10.1~)
- /lib/component/custom_video_player.dart
```dart
class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  // 2.1 동영상을 조작하는 컨트롤러
  VideoPlayerController? videoController;

  // 10.1 동영상을 조작하는 아이콘을 보일지 여부
  bool showControls = false;
  
```

(10.1~)
- /lib/component/custom_video_player.dart
```dart
@override
  Widget build(BuildContext context) {
    // 2.4 동영상 컨트롤러가 준비 중일 때 로딩 표시
    if (videoController == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    // 2.5 동영상 비율에 따른 화면 렌더링
    // AspectRatio(종횡비): child 매개변수에 입력되는 위젯의 비율을 정할 수 있는 위젯
    // videoController!.value.aspectRatio: 입력된 동영상의 비율
    return GestureDetector(
      // 10.2 화면 전체의 탭을 인식하기 위해서 사용
      onTap: () {
        setState(() {
          showControls = !showControls;
        });
      },
      child: AspectRatio(
        aspectRatio: videoController!.value.aspectRatio, // 16/9,...
        // 3.1 Stack 위젯을 사용해서 VideoPlayer 위젯 위에 Slider 위젯을 올림
        child: Stack(
          children: [
            VideoPlayer(
              videoController!,
            ),
            // 10.3 아이콘 버튼을 보일 때 화면을 어둡게 변경
            if (showControls)
              Container(
                color: Colors.black.withAlpha((0.5 * 255).toInt()),
              ),
            Positioned(
            ),
            // 5.1 새 동영상 아이콘: 오른쪽 위에 위치
            if (showControls) //10.4 showControls가 true일 때만 아이콘 보여주기
              Align(
              alignment: Alignment.topRight,
              child: CustomIconButton(
              onPressed: widget.onNewVideoPressed,
              // 8.2 새로운 동영상을 선택할 함수 실행
              iconData: Icons.photo_camera_back),
              ),
            // 5.2 동영상 재생 관련 아이콘: 가운데 위치
            if (showControls) // 10.5 showControls가 true일 때만 아이콘 보여주기
              Align(
```

### add time stamp

현재 실행 중인 위치와 동영상 길이를 Slider의 좌우에 배치

- /lib/component/custom_video_player.dart
```dart
            Positioned(
              // 3.2 child 위젯의 위치를 정할 수 있는 위젯
              left: 0,
              // right: 0 과 함께 사용하여 좌우측 Slider 위젯을 끝까지 늘림
              right: 0,
              bottom: 0,
              // Stack 위젯의 가장 아래에(아래에서 0픽셀 떨어진 위치) Slider 위젯을 위치시킴
              // 11.1 Slider 위젯 양쪽에 현재 재생 위치와 동영상 길이를 배치하기 위해서 Padding, Row 위젯 사용
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    // 11.2 현재 재생 위치
                    renderTimeTextFromDuration(videoController!.value.position),
                    Expanded(
                      // 11.2
                      // 3.3 Slider 위젯
                      child: Slider(
                        // 4.1 슬라이더가 이동할 때마다 실행할 함수
                        onChanged: (double val) {
                          // seekTo: 동영상의 재생위치를 특정 위치로 이동
                          videoController!.seekTo(
                            Duration(seconds: val.toInt()),
                          );
                        },
                        // 4.2 현재 재생 위치를 초 단위로 표현
                        value: videoController!.value.position.inSeconds
                            .toDouble(),
                        min: 0,
                        max: videoController!.value.duration.inSeconds
                            .toDouble(), // max값은 현재 동영상의 전체 재생 길이를 초 단위로 표현
                      ),
                    ),
                    // 11.3 동영상 총 길이
                    renderTimeTextFromDuration(videoController!.value.duration),
                  ],
                ),
              ),
            ),
```
(11.1~)
- /lib/component/custom_video_player.dart
```dart
  // 11.4 현재 재생 위치와 동영상 길이를 Text로 표시할 위젯
  Widget renderTimeTextFromDuration(Duration duration) {
    return Text(
      '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}',
      style: TextStyle(
        color: Colors.white,
      ),
    );
  }
```