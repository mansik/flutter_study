# image_editor_test

A new Flutter project.

photo sticker: 이미지 수정

GestureDetector

![Image](https://github.com/user-attachments/assets/266d70ed-c03e-4076-a1cc-7fc90321f986)

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Features

- 갤러리에서 이미지를 선택할 수 있다.
- 스티커를 탭해서 이미지에 올려놓을 수 있다.
- 삭제 버튼을 눌러서 추가한 이미지를 삭제할 수 있다.
- 저장 버튼을 눌러서 수정한 이미지를 갤러리에 저장할 수 있다.

## Usage

- 이미지 선택 버튼을 눌러서 이미지를 선택할 수 있다.
- 스티커를 탭해서 추가하고 크기 및 위치를 조절할 수 있다.
- 스티커를 선택한 후 삭제 버튼을 눌러서 스티커를 살게할 수 있다.
- 저장 버튼을 눌러서 수정한 이미지를 갤러리에 저장할 수 있다.

## Skill

imagePicker, GestureDetector를 이용한 Transform, InteractiveViewer, hashCode와 == 오퍼레이터 오버라이드

## Plugin

- image_picker: ^1.1.2
- image_gallery_saver_plus: '^3.0.5'
- uuid: ^4.5.1

## prior knowledge

#### GestureDetector 와 Gesture

GestureDetector는 플러터에서 지원하는 모든 제스처들을 구현할 수 있는 위젯이다.
단순 탭뿐만 아니라 더블 탭, 길게 누르기, 드래그 등 여러 가지 제스처를 인식할 수 있다.
제스처가 인식되면 매개변수에 입력된 콜백 함수가 실행된다.

흔히 사용하는 제스처
- onTap: 한 번 탭했을 때 콜백 함수를 실행한다.
- onDoubleTap: 두 번 탭했을 때 콜백 함수를 실행한다.
- onLongPress: 길게 눌렀을 때 콜백 함수를 실행한다.
- onScale: 확대하기를 했을 때 콜백 함수를 실행한다.
- onVerticalDragStart: 수직 드래그가 시작됐을 때 콜백 함수를 실행한다.
- onVerticalDragEnd: 수직 드래그가 끝났을 때 콜백 함수를 실행한다.
- onHorizonatalDragStart: 수평 드래그가 시작됐을 때 콜백 함수를 실행한다.
- onHorizonatalDragEnd: 수평 드래그가 끝났을 때 콜백 함수를 실행한다.
- onPanStart: 드래그가 시작됐을 때 콜백 함수를 실행한다.
- onPanEnd: 드래그가 끝났을 때 콜백 함수를 실행한다.

## Layout

하나의 스크린으로 구성되며, 이미지가 선택되었을 때와 선택되지 않았을 때의 화면으로 구성

이미지가 선택되지 않았을 때는 화면의 중앙에 [select image] 버튼이 보이고,
이미지가 선택된 상태에서는 AppBar, Body, Footer로 3등분된 화면으로 구성된 화면을 보여준다.
- AppBar: 타이틀
- Body: 이미지를 보여준다.
- Footer: 스티커를 고른다.

## Setps

### copy image to th /assets/images

- /assets/images

### 가상 머신에 이미지 추가하기

- 안드로이드 에뮬레이터에 assets/images/background.jpg Drag and Drop

- iOS 시뮬레이터에 assets/images/background.jpg Drag and Drop

### add plugins and assets in pubspec.yaml, `pub get`

- /assets/images/
```yaml
dependencies:
 image_picker: ^1.1.2
 image_gallery_saver_plus: ^3.0.5
 uuid: ^4.5.1

flutter:
 assets:
   - assets/images/
```

### configuring native setting

on android

- /android/app/src/main/AndroidManifest.xml
  안드로이드 11 버전을 기준으로 새로운 파일 저장소가 추가되었으며,
  안드로이드 11 이전 운영체제를 실행 중이면 기존 파일 저장소를 사용하기 위해서 requestLegacyExternalStroage 옵션을 true로 설정
```xml
    <application
        android:label="image_editor"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher"
        android:requestLegacyExternalStorage="true">
```

- /android/settings.gradle
  id "com.android.application" version "8.2.1" apply false
```gradle
plugins {
    id "dev.flutter.flutter-plugin-loader" version "1.0.0"
    id "com.android.application" version "8.2.1" apply false
```

[on iOS]
- /ios/Runner/Info.plist
```plist
  <dict>
    <key>NSPhotoLibraryUsageDescription</key>
    <string>We need permission to save photos and videos to your library for your convenience.</string>
    <key>NSCameraUsageDescription</key>
    <string>We need permission to camera for your convenience.</string>
    <key>NSMicrophoneUsageDescription</key>
    <string>We need permission to microphone for your convenience.</string>    
  </dict>
  </plist>
```

### initialize project

- /lib/main.dart
```dart
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
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text('home'));
  }
}
```

### implement the AppBar from Container widget

- /lib/components/main_app_bar.dart
```dart
import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget {
  final VoidCallback onPickImage; // 이미지 선택 버튼 눌렀을 때 실행할 함수
  final VoidCallback onSaveImage; // 이미지 저장 버튼 눌렀을 때 실행할 함수
  final VoidCallback onDeleteItem; // 이미지 삭제 버튼 눌렀을 때 실행할 함수

  const MainAppBar(
          {required this.onPickImage,
            required this.onSaveImage,
            required this.onDeleteItem,
            super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(
          (0.9 * 255).toInt(),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(
            onPressed: onPickImage,
            icon: const Icon(Icons.image_search_outlined),
            color: Colors.grey[700],
          ),
          IconButton(
            onPressed: onDeleteItem,
            icon: const Icon(Icons.delete_forever_outlined),
            color: Colors.grey[700],
          ),
          IconButton(
            onPressed: onSaveImage,
            icon: const Icon(Icons.save),
            color: Colors.grey[700],
          ),

        ],
      ),
    );
  }
}
```

### implement the home screen

- /lib/screens/home_screen.dart
```dart
import 'package:flutter/material.dart';
import 'package:image_editor/components/main_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand, // 자식들이 최대한의 크기의 공간을 차지하도록 함. <-> StackFit.loose
        children: [
          // AppBar
          Positioned(
            top: 0, // 맨 위에 AppBar 위치 시키기
            left: 0, // 좌우 최대 크기
            right: 0,
            child: MainAppBar(
              onPickImage: onPickImage,
              onSaveImage: onSaveImage,
              onDeleteItem: onDeleteItem,
            ),
          ),
        ],
      ),
    );
  }

  void onPickImage() {
    print('onPickImage');
  }

  void onSaveImage() {
    print('onSaveImage');
  }

  void onDeleteItem() {
    print('onDeleteItem');
  }
}
```

### convert home screem from the StatelessWidget to the StatefulWidget

- /lib/screens/home_screen.dart
  HomeScreen에서 상태 관리를 하므로 StatefulWidget으로 변경
- cursor on StatelessWidget -> Alt + Enter -> convert to StatefulWidget
```dart
import 'package:flutter/material.dart';
import 'package:image_editor/components/main_app_bar.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? _image; // 이미지 파일을 저장할 변수

  void onPickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    setState(() {
      this._image = image;
    });
  }
```

### rerun the App

### implement the body

1. 이미지가 선택되지 않은 상태: [select image] 버튼을 화면 중앙에 보여주기
2. 이미지가 선택된 상태: 선택된 이미지를 화면에 보여주기
3. 추가로 위젯을 확태하고 좌우로 이동할 수 있는 InteractiveViewer로 Image 위젯을 감싸서 Image 위젯에 자동으로 제스처 기능이 적용되게 구현
- /lib/screens/home_screen.dart
```dart
import 'dart:io';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand, // 자식들이 최대한의 크기의 공간을 차지하도록 함. <-> StackFit.loose
        children: [
          renderBody(), // body
          // AppBar
          Positioned(
            top: 0, // 맨 위에 AppBar 위치 시키기
            left: 0, // 좌우 최대 크기
            right: 0,
            child: MainAppBar(
              onPickImage: onPickImage,
              onSaveImage: onSaveImage,
              onDeleteItem: onDeleteItem,
            ),
          ),
        ],
      ),
    );
  }

  Widget renderBody() {
    if (_image != null) {
      // Stack 크기의 최대 크기만큼 차지하기
      return Positioned.fill(
        // 위젯 확대 및 좌우 이동을 가능하게 하는 위젯
        child: InteractiveViewer(
          child: Image.file(
            File(_image!.path),
            fit: BoxFit.cover, // 이미지가 부모 위젯 크기 최대를 차지하도록 하기
          ),
        ),
      );
    } else {
      return Center(
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.grey,
          ),
          onPressed: onPickImage,
          child: Text('select image'),
        ),
      );
    }
  } 
```


### implement the footer

스티커를 선택할 footer 위젯
- /lib/components/footer.dart
```dart
import 'package:flutter/material.dart';

//  2. 스티커를 선택할 때마다 실행할 함수의 시그니처
typedef OnEmoticonTap = void Function(int id);

class Footer extends StatelessWidget {
  final OnEmoticonTap onEmoticonTap;

  const Footer({required this.onEmoticonTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withAlpha((0.9 * 255).toInt()),
      height: 150,
      child: SingleChildScrollView( // 가로로 스크롤 가능하게 스티커 구현
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            7,
                    (index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GestureDetector(
                onTap: () {
                  onEmoticonTap(index + 1); // 스티커 선택할 때 실행할 함수
                },
                child: Image.asset(
                  'assets/images/emoticon_${index + 1}.png',
                  height: 100,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
```


### implement footer to home screen

- /lib/screens/home_screen.dart
```dart
class _HomeScreenState extends State<HomeScreen> {
  XFile? _image; // 이미지 파일을 저장할 변수

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand, // 자식들이 최대한의 크기의 공간을 차지하도록 함. <-> StackFit.loose
        children: [
          renderBody(), // body
          // AppBar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: MainAppBar(
              onPickImage: onPickImage,
              onSaveImage: onSaveImage,
              onDeleteItem: onDeleteItem,
            ),
          ),
          // footer
          if (_image != null)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Footer(
                onEmoticonTap: onEmoticonTap,
              ),
            ),
        ],
      ),
    );
  }

  void onEmoticonTap(int index) {
  }
```

### implement the EmoticonSticker Widget

이모티콘 스티커를 이미지에 붙이는 기능: Footer 위젯에서 이모티콘을 탭하면 이미지 위에 선택한 이모티콘이 올려지고
이모티콘을 드래그해서 이동하거나 크기를 변경했을 때 화면에 적절히 반영되도록 한다.

onScaleUpdate와 onTap 매개변수가 실행됐을 때 스티커 상태가 변경이 된다는 걸 부모 위젯에 알리는
onTransfrom() 함수를 정의하고 실행한다.

- /lib/component/emoticon_sticker.dart
 ```dart
import 'package:flutter/material.dart';

class EmoticonSticker extends StatefulWidget {
  final VoidCallback onTransform; // 스티커의 상태가 변경될 때마다 실행
  final String imagePath; // 이미지 경로

  const EmoticonSticker({
    required this.onTransform,
    required this.imagePath,
    super.key,
  });

  @override
  State<EmoticonSticker> createState() => _EmoticonStickerState();
}

class _EmoticonStickerState extends State<EmoticonSticker> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 스티커를 눌렀을 때 실행할 함수
      onTap: () {
        widget.onTransform(); // 스티커의 상태가 변경될 때마다 실행
      },

      // 스티커의 확대 비율이 변경됐을 때 실행
      onScaleUpdate: (details) {
        widget.onTransform(); // 스티커의 상태가 변경될 때마다 실행
      },

      // 스티커의 확대 비율 변경이 완료됐을 때 실행
      onScaleEnd: (details) {},

      child: Image.asset(
        widget.imagePath,
      ),
    );
  }
}

```

#### Implement a feature to capture gesture input(제스처를 입력받아보는 기능)

가로, 세로로 이동한 수치와 확대 및 축소가 된 수치를 변수로 저장해두고
확대/축소 제스처에 대한 콜백이 실행될 때마다 변수들을 업데이트
- details.scale: 제스처가 시작된 순간을 기준으로 scale

- /lib/component/emoticon_sticker.dart
```dart
class _EmoticonStickerState extends State<EmoticonSticker> {
  double _scale = 1.0; // 스티커의 확대 비율
  double _hTranslation = 0.0; // 스티커의 수평 이동 거리
  double _vTranslation = 0.0; // 스티커의 수직 이동 거리
  double _actualScale = 1.0; // 실제 스티커의 확대 비율, 위젯의 초기 크기 기준 확대/축소 비율

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 스티커를 터치하면 실행할 함수
      onTap: () {
        widget.onTransform(); // 스티커의 상태가 변경될 때마다 실행
      },
      // 스티커의 확대 비율이 변경됐을 때 실행
      onScaleUpdate: (details) {
        widget.onTransform();
        setState(() {
          _scale = details.scale * _actualScale; // 최근 확대 비율을 기반으로 실제 확대 비율 계산
          _vTranslation += details.focalPoint.dy; // 스티커의 수직 이동 거리 계산
          _hTranslation += details.focalPoint.dx; // 스티커의 수평 이동 거리 계산
        });
      },
      // 스티커의 확대 비율 변경이 완료됐을 때 실행
      onScaleEnd: (details) {
        _actualScale = _scale; // 실제 스티커의 확대 비율을 최근 확대 비율로 변경
      },

      child: Image.asset(
        widget.imagePath,
      ),
    );
  }
}
```


#### 이모티콘 선택 기능 구현

이모티콘 스티커 여러 개를 이미지 하나에 추가한다.
따라서 현재 어떤 이모티콘 스티거가 선택되어 있는지 확인할 수 있어야 삭제 또는 이동 및 확대/축소 기능을 제공할 수 있다.

- /lib/component/emoticon_sticker.dart
```dart
class EmoticonSticker extends StatefulWidget {
  final VoidCallback onTransform; // 스티커의 상태가 변경될 때마다 실행
  final String imagePath; // 이미지 경로
  final bool isSelected; // 스티커가 선택된 상태인지 지정

  const EmoticonSticker({
    required this.onTransform,
    required this.imagePath,
    required this.isSelected,
    super.key,
  });

  @override
  State<EmoticonSticker> createState() => _EmoticonStickerState();
}

class _EmoticonStickerState extends State<EmoticonSticker> {
  double _scale = 1.0; // 스티커의 확대 비율
  double _hTranslation = 0.0; // 스티커의 수평 이동 거리
  double _vTranslation = 0.0; // 스티커의 수직 이동 거리
  double _actualScale = 1.0; // 실제 스티커의 확대 비율, 위젯의 초기 크기 기준 확대/축소 비율

  @override
  Widget build(BuildContext context) {
    return Container(
      // 선택된 상태일 때만 테두리 색상 구현
      decoration: widget.isSelected
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(4.0), // 모서리 둥글게
              border: Border.all(color: Colors.blue, width: 1.0), // 테두리 색상과 두께
            )
          : BoxDecoration(
              // 테두리는 투명이나 너비는 1로 설정해서 스티커가 선택, 취소될 때 깜빡이는 현상 제거
              border: Border.all(color: Colors.transparent, width: 1.0),
            ),
      child: GestureDetector(
```

#### 위젯의 움직임 및 확대/축소를 위젯에 반영

이제까지는 위젯의 움직임 및 확대/축소를 감지하고 있지만 이 변화를 위젯에 반영하고 있지는 않고 있다. 이제 위젯에 반영하는
기능을 구현한다.

- /lib/component/emoticon_sticker.dart
```dart
class _EmoticonStickerState extends State<EmoticonSticker> {
  double _scale = 1.0; // 스티커의 확대 비율
  double _hTranslation = 0.0; // 스티커의 수평 이동 거리
  double _vTranslation = 0.0; // 스티커의 수직 이동 거리
  double _actualScale = 1.0; // 실제 스티커의 확대 비율, 위젯의 초기 크기 기준 확대/축소 비율

  @override
  Widget build(BuildContext context) {
    return Transform( // child 위젯을 변형할 수 있는 위젯
            transform: Matrix4.identity()
      ..translate(_hTranslation, _vTranslation) // 수평, 수직 이동
      ..scale(_scale), // 확대, 축소
      child: Container(
```

### implement sticker placement (스티커 붙이기)

#### StickerModel 클래스를 구현

여러개의 스티커를 한꺼번에 관리하기 편하도록 StickerModel 클래스를 구현해서 각각 스티커에 필요한 정보를 저장

Map을 사용해도 되나, Map을 사용할 경우 데이터 구조가 강제되지 않아서
상태 관리를 할 때는 꼭 클래스를 사용해서 데이터를 구조화하는 게 좋다.

- /lib/models/sticker_model.dart
```dart
class StickerModel {
  final String id;
  final String imagePath;

  StickerModel({
    required this.id,
    required this.imagePath,
  });
  
  @override
  bool operator ==(Object other) { // 하나의 인스턴스가 다른 인스턴스와 같은지 비교할 때 사용하는 로직
    return (other as StickerModel).id == id;
  }
  
  // Set에서 중복 여부를 결정하는 속성
  // ID 값이 같으면 Set 안에서 같은 인스턴스로 인식
  @override  
  int get hashCode => id.hashCode;
}
```

#### 각각 StickerModel을 기반으로 화면에 EmoticonSticker 위젯을 렌더링할 수 있게 구현

화면에 붙여줄 스티커들을 Set<StickerModel>로 관리해주면 쉽게 상태 관리가 가능하다.
또한 selectedId 변수를 선언해서 선택된 스티커의 id를 저장한다.

- /lib/screens/home_screen.dart
```dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_editor/components/emoticon_sticker.dart';
import 'package:image_editor/components/footer.dart';
import 'package:image_editor/components/main_app_bar.dart';
import 'package:image_editor/model/sticker_model.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? _image; // 이미지 파일을 저장할 변수
  Set<StickerModel> _stickerSet = {}; // 화면에 추가된 스티커를 저장할 Set
  String? _selectedStickerId; // 선택된 스티커의 ID를 저장할 변수

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand, // 자식들이 최대한의 크기의 공간을 차지하도록 함. <-> StackFit.loose
        children: [
          renderBody(), // body
          // AppBar
          Positioned(
            top: 0, // 맨 위에 AppBar 위치 시키기
            left: 0, // 좌우 최대 크기
            right: 0,
            child: MainAppBar(
              onPickImage: onPickImage,
              onSaveImage: onSaveImage,
              onDeleteItem: onDeleteItem,
            ),
          ),
          // footer
          if (_image != null)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0, // 맨 아래에 Footer 위치 시키기
              child: Footer(
                onEmoticonTap: onEmoticonTap,
              ),
            ),
        ],
      ),
    );
  }

  Widget renderBody() {
    if (_image != null) {
      // Stack 크기의 최대 크기만큼 차지하기
      return Positioned.fill(
        // 위젯 확대 및 좌우 이동을 가능하게 하는 위젯
        child: InteractiveViewer(
          child: Stack(
            fit: StackFit.expand, // 크기를 최대로 늘려주기
            children: [
              Image.file(
                File(_image!.path),
                fit: BoxFit.cover, // 이미지가 부모 위젯 크기 최대를 차지하도록 하기
              ),
              // ...stickers.map()은 여러개의 스티커를 children 리스트에 나열한다. 
              ..._stickerSet.map(
                        (sticker) => Center(
                  child: EmoticonSticker(
                    key: ObjectKey(sticker.id),
                    onTransform: () {
                      onTransform(sticker.id);
                    },
                    imagePath: sticker.imagePath,
                    isSelected: sticker.id == _selectedStickerId,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Center(
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.grey,
          ),
          onPressed: onPickImage,
          child: Text('select image'),
        ),
      );
    }
  }

  void onPickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    setState(() {
      this._image = image;
    });
  }

  void onSaveImage() {
    print('onSaveImage');
  }

  void onDeleteItem() {
    print('onDeleteItem');
  }

  void onEmoticonTap(int index) {}

  void onTransform() {}
}

```

#### Footer 위젯에서 각 스티커를 누를 때마다 stickers 변수를 업데이트

- /lib/screens/home_screen.dart
```dart
import 'package:uuid/uuid.dart';

/// footer 위젯에서 각 스티커를 누를 때마다 _stickerSet 변수를 업데이트
void onEmoticonTap(int index) async {
  setState(() {
    // 기존 _stickerSet에 새로운 스티커를 추가
    _stickerSet = {
      ..._stickerSet,
      StickerModel(
        id: Uuid().v4(),
        imagePath: 'assets/images/emoticon_$index.png',
      ),
    };
  });
}
```

#### selectedId 변수에 선택된 스티커의 id를 저장

- onTransform(sticker.id)
- void onTransform(String id)

- /lib/screens/home_screen.dart
```dart
Widget renderBody() {
  if (_image != null) {
    // Stack 크기의 최대 크기만큼 차지하기
    return Positioned.fill(
      // 위젯 확대 및 좌우 이동을 가능하게 하는 위젯
      child: InteractiveViewer(
        child: Stack(
          fit: StackFit.expand, // 크기를 최대로 늘려주기
          children: [
            Image.file(
              File(_image!.path),
              fit: BoxFit.cover, // 이미지가 부모 위젯 크기 최대를 차지하도록 하기
            ),
            // ...stickers.map()은 여러개의 스티커를 children 리스트에 나열한다.
            ..._stickerSet.map(
                      (sticker) => Center(
                child: EmoticonSticker(
                  key: ObjectKey(sticker.id),
                  onTransform: () {
                    onTransform(sticker.id);
                  },
                  imagePath: sticker.imagePath,
                  isSelected: sticker.id == _selectedStickerId,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  } else {
    return Center(
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.grey,
        ),
        onPressed: onPickImage,
        child: Text('select image'),
      ),
    );
  }
}

/// 스티커가 변경될 때마다 변형 중인 스티커를 현재 선택한 스티커로 지정
void onTransform(String id) {
  setState(() {
    _selectedStickerId = id;
  });
}
```

### hot reload

1. Footer의 첫 번ㅉ재 이모티콘을 누르면 이미지 위에 이모티콘 스티커가 위치한다.
2. 해당 이모티콘을 누르거나, 확대/축소 비율을 조절하거나(ctrl+드래그), 위치를 이동하면 이모티콘 이미지 주위에 파란색 테누리가 생기며
3. 현재 선택된 이모티콘이라는 표시가 된다.


### implement sticker deletion

스티커 삭제 버튼은 MainAppBar 위젯에 있으며, onDeleteItem() 함수만 작업하면 된다.
- /lib/screens/home_screen.dart
```dart
  void onDeleteItem() async {
  setState(() {
    _stickerSet.removeWhere((sticker) => sticker.id == _selectedStickerId);
    _selectedStickerId = null;
  });
}

 // void onDeleteItem() async {
 //   setState(() {
 //     // 현재 선택되어 있는 스티커 삭제 후 Set로 변환
 //     stickers = stickers.where((sticker) => sticker.id != selectedId).toSet();
 //   });
 // }
```

### implement image saving

RepaintBoundary 위젯을 사용해서 위젯을 이미지로 추출한 후 갤러리에 저장

#### RepaintBoundary 위젯을 사용해서 이미지를 추출해서 Uint8List 형태로 변경
RepaintBoundary 위젯은 자식 위젯을 이미지로 추출하는 기능이 있다. 이 기능을 사용하려면
RepaintBoundary에 key 매개변수를 입력해주고 이미지를 추출할 때 이 값을 사용한다.
- /lib/screens/home_screen.dart
```dart
class _HomeScreenState extends State<HomeScreen> {
  XFile? _image; // 이미지 파일을 저장할 변수
  Set<StickerModel> stickers = {}; // 화면에 추가된 스티커를 저장할 변수
  String? selectedId; // 선택된 스티커의 id를 저장할 변수
  GlobalKey imageKey = GlobalKey(); // 이미지로 전환할 위젯에 입력해줄 값, 애플리케이션 전체에서 위젯을 고유하게 식별하는 데 사용되는 특별한 키

  Widget renderBody() {
    if (_image != null) {
      // Stack 크기의 최대 크기만큼 차지하기
      return RepaintBoundary(
              key: _imageKey, // 위젯을 이미지로 저장하는 데 사용
              child: Positioned.fill(
```

- /lib/screens/home_screen.dart
```dart
import 'dart:ui' as ui;
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';
void onSaveImage() async {
  // 실제 화면에 렌더링된 RepatintBoundary 위젯을 찾음
  RenderRepaintBoundary boundary = imageKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;

  // 바운더리를 이미지로 변경
  ui.Image image = await boundary.toImage(); // dart:ui 패키지의 Image 클래스
  // byte data 형태로 형태 변경, 반환되는 확장자는 png로 지정
  ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  // Uint8List 형태로 형태 변경, 8비트 정수형으로 변환, image_gallery_saver_plus 패키지의 saveImage 함수에 전달
  Uint8List pngBytes = byteData!.buffer.asUint8List();
}
```

#### 이미지 저장

- /lib/screens/home_screen.dart
```dart
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';

void onSaveImage() async {
  // 실제 화면에 렌더링된 RepatintBoundary 위젯을 찾음
  RenderRepaintBoundary boundary =
  imageKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

  // 바운더리를 이미지로 변경
  ui.Image image = await boundary.toImage(); // dart:ui 패키지의 Image 클래스
  // byte data 형태로 형태 변경, 반환되는 확장자는 png로 지정
  ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  // Uint8List 형태로 형태 변경, 8비트 정수형으로 변환, image_gallery_saver_plus 패키지의 saveImage 함수에 전달
  Uint8List pngBytes = byteData!.buffer.asUint8List();

  // 이미지 저장하기
  await ImageGallerySaverPlus.saveImage(pngBytes, quality: 100);

  // snackBar 보여주기
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('image saved!'),
    ),
  );
}
```

