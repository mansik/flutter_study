# video_call

A new Flutter project.

영상 통화 앱
- WebRTC, 내비게이션, 아고라 API

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Features

- 1:1 영상 통화
- 영상통화 종료

## Usage

- [입장하기] 버튼을 눌러서 영상 통화에 참여할 수 있다.
- [채널 나가기] 버튼을 눌러서 영상 통화를 종료할 수 있다.

## Skill

아고라 API, 권한 관리, WebRTC

## Plugin

- agora_rtc_engine: ^6.5.0
- permission_handler: ^11.3.1

permission_handler: manage permissions on a device
- usage permission_handler: check only one permission
```dart
import 'package:permission_handler/permission.handler.dart';

// request camera permission
final permission = await Permission.camera.request(); 

// check permission status
if (permission == PermissionStatus.granted) {
  print('permission granted');
} else {
  print('permission denied');
}
```

- check multiple permission
```dart
import 'package:permission_handler/permission.handler.dart';

// request permission of list
final resp = await [Permission.camera, Permission.microphone].request(); 

// check permission status
final cameraPermission = resp[Permission.camera];
final micPermission = resp[Permission.microphone];

if (cameraPermission == PermissionStatus.granted) {
thorw 'camera permission granted';
}

if (micPermission == PermissionStatus.granted) {  
  thorow 'permission denied';
}
```

## prior knowledge

#### Agora
영상 통화와 통화 기능 API를 유료로 제공하는 서비스이며, 
회원가입을 하면 매달 1만 분을 무료로 사용 가능하다.
API 토근을 발급 받아야 한다.

## Layout

2개의 화면으로 구성
- HomeScreen: 화상 통화 채널에 참여할 수 있는 화면
- CamScreen: 화상 통화를 하는 화면

일반적으로 홈 화면에서 참여할 채널 또는 화상 통화를 진행할 상대를 선택하는 기능이 있어야 하지만
이 프로젝트에서는 하나의 채널만 있다는 가정하에 앱을 구현한다.

## Setps

### get the required constants from agora


organizing values related to [agora](https://agroa.io)(관련된 값을 정리)
1. new project -> project name: video_call
2. select video_call project and click edit button at `Action` -> app id:
3. click `Generate temp Token` -> channel name: testchannel, temp token:
- /lib/const/agora.dart
```dart
const appId = 'your app id';
const channelName = 'your channel name';
const tempToken = 'your token';
```

### add plugins and assets in pubspec.yaml, `pub get`

- /assets/images/
```yaml
dependencies:
  agora_rtc_engine: ^6.5.0
  permission_handler: ^11.3.1
    
flutter:
  assets:
    - assets/images/
```

### configuring native setting

add permission on android
- READ_PHONE_STATE, ACCESS_NETWORK_STATE: 네트워크 상태을 읽는 권한
- INTERNET
- RECORD_AUDIO, MODIFY_AUDIO_SETTINGS, CAMERA: 녹음, 녹화 기능 권환
- BLUETOOTH_CONNECT: 블루투스를 이용한 녹음, 녹화 기능할 수 있으므로 블루투스 권한

add permission on iOS
- NSCameraUsageDescription: 카메라 권한
- NSMicrophoneUsageDescription: 마이크 권한

- /android/app/src/main/AndroidManifest.xml
```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools">
    <uses-permission android:name="android.permission.READ_PHONE_STATE" />
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.RECORD_AUDIO" />
    <uses-permission android:name="android.permission.CAMERA" />
    <uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.BLUETOOTH" />
    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.WAKE_LOCK" />
    <uses-permission android:name="android.permission.READ_PRIVILEGED_PHONE_STATE" tools:ignore="ProtectedPermissions" />
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

### implement home screen

- lib/screens/home_screen.dart
```dart
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100]!,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(child: _Logo()),
              Expanded(child: _Image()),
              Expanded(child: _EntryButton()),
            ],
          ),
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(16.0),
          // Container 위젯에 그림자 추가
          boxShadow: [
            BoxShadow(
              color: Colors.blue[300]!,
              blurRadius: 12.0,
              spreadRadius: 2.0,
            )
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.videocam,
                color: Colors.white,
                size: 40.0,
              ),
              SizedBox(width: 12.0),
              Text(
                'LIVE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  letterSpacing: 4.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Image extends StatelessWidget {
  const _Image({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset('assets/images/home_img.png'),
    );
  }
}

class _EntryButton extends StatelessWidget {
  const _EntryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
          ),
          child: Text(
            'Entry',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
```

### implement cam screen

- StatefulWidget
- AppBar

- /lib/screens/cam_screen.dart
```dart
import 'package:flutter/material.dart';

class CamScreen extends StatefulWidget {
  const CamScreen({super.key});

  @override
  State<CamScreen> createState() => _CamScreenState();
}

class _CamScreenState extends State<CamScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LIVE'),
      ),
      body: Center(
        child: Text('Cam Screen'),
      ),
    );
  }
}
```

### add navitation feature in the onPressed parameter

- push() : 새로운 화면으로 이동
- /lib/screens/home_screen.dart
```dart
      children: [
        ElevatedButton(
          onPressed: () {
            // cam screen으로 이동
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => CamScreen(),
              ),
            );
          },         
        ),
      ],
```

### add permissions required for video calls

- /lib/screens/cam_screen.dart
```dart
import 'package:permission_handler/permission_handler.dart';

class _CamScreenState extends State<CamScreen> {
  // 권한 관련 작업
  Future<bool> init() async {
    final resp = await [Permission.camera, Permission.microphone].request();

    final cameraPermission = resp[Permission.camera];
    final micPermission = resp[Permission.microphone];

    if (cameraPermission != PermissionStatus.granted ||
        micPermission != PermissionStatus.granted) {
      throw 'camera or mic permissions is denied';
    }

    return true;
  }
```

### add Rendering a widget based on the Future value (init())

- FutureBuilder: 비동기 작업의 결과를 기반으로 위젯을 동적으로 빌드하는데 사용하는 위젯
- 주로 네트워크 요청, 파일 읽기, 데이터베이스 쿼리와 같은 
- 비동기 작업이 완료될 때까지 기다렸다가 결과를 UI에 반영해야 할 때 유용하다.

build() 함수는 위젯이 생성되면 즉시 실행된다.  
하지만 카메라와 마이크의 권한이 있을 때와 없을 때 보여줄 수 있는 화면이 달라야 한다. 
문제는 init()가 비동기로 실행되므로 언제 권한 요청이 끝날지 알 수 없으므로, 
FutureBuilder 위젯을 사용하여 Future를 반환하는 함수의 결과에 따라 위젯을 렌더링하도록 한다. 
- init()에서 에러를 던지면 에러 내용을 보여주고
- 아직 로딩중이면 CircularProgressIndicator를 보여주고
- 모든 권한이 허가되면 'all permissions granted'를 보여준다.


- /lib/screens/cam_screen.dart
```dart
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LIVE'),
      ),

      // Future값(init())을 기반으로 위젯 렌더링
      body: FutureBuilder(
        future: init(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // Future 실행 후 에러가 있을 때 에러 표시
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }

          // Future 실행 후 아직 데이터가 앖을 때 로딩 중 표시
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          // 나머지 상황에 권한 있음을 표시
          return Center(
            child: Text('all permissions granted!'),
          );
        },
      ),
    );
  }
```

### activating  the agora API

3 steps to active the agora API
1. agora RtcEngine을 활성화 및 각종 이벤트를 받을 수 잇는 콜백 함수 설정
2. RtcEngine를 통해 사용하는 핸트폰의 카메라를 활성화
3. 미리 받아둔 아고라 API 상수값들을 사용해서 채널에 참여한다.

- /lib/screens/cam_screen.dart
```dart
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:video_call/const/agora.dart';


class _CamScreenState extends State<CamScreen> {
  RtcEngine? engine; // 아고라 엔진을 저장
  int? uid; // 내 ID
  int? otherUid; // 상대방 ID

  // 1. 권한 관련 작업
  Future<bool> init() async {
    final resp = await [Permission.camera, Permission.microphone].request();

    final cameraPermission = resp[Permission.camera];
    final micPermission = resp[Permission.microphone];

    if (cameraPermission != PermissionStatus.granted ||
        micPermission != PermissionStatus.granted) {
      throw 'camera or mic permissions is denied';
    }

    // 3. 아고라 API를 활성화
    if (engine == null) {
      // 3.1 아고라 엔진 생성
      engine = createAgoraRtcEngine();

      //3.2 아고라 엔진 초기화
      await engine!.initialize(
        RtcEngineContext(
          appId: appId,
          channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
        ),
      );

      //3.3 아고라 엔진에서 받을 수 있는 이벤트 값들을 등록
      engine!.registerEventHandler(
        RtcEngineEventHandler(
          // 내가 채널 접속에 성공했을 때 실행
          onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
            print('Entered the channel, uid:${connection.localUid}');
            setState(() {
              uid = connection.localUid;
            });
          },
          // 내가 채널을 퇴장했을 때 실행
          onLeaveChannel: (RtcConnection connection, RtcStats stats) {
            print('Leave channel');
            setState(() {
              uid = null;
            });
          },
          // 다른 사용자가 접속했을 때 실행
          onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
            print('User joined, uid:$remoteUid');
            setState(() {
              otherUid = remoteUid;
            });
          },

          // 다른 사용자가 채널을 나갔을 때 실행
          onUserOffline: (RtcConnection connection, int remoteUid,
              UserOfflineReasonType reason) {
            print('User offline, uid:$remoteUid');
            setState(() {
              otherUid = null;
            });
          },
        ),
      );
    }

    //3.4 엔진으로 영상을 송출하겠다고 설정
    await engine!.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    // 3.5 동영상 기능을 활성화
    await engine!.enableVideo();
    // 3.6 카메라를 이용해 동영상을 화면에 실행
    await engine!.startPreview();

    // 3.7 채널 입장
    await engine!.joinChannel(
      token: tempToken,
      channelId: channelName,
      uid: 0, // 내 고유 ID 지정, 0을 입력하면 자동으로 고유 ID가 배정됨.
      options: ChannelMediaOptions(), // 영상과 관련된 여러 가지 설정을 할 수 있음. 현재 프로젝트에서는 기본 설정 사용
    );

    return true;
  }

  @override
  Widget build(BuildContext context) {
```

### implement renderMainView() and renderSubView()

RtcEngine에서 송수신하는 정보를 화면에 그려주는 코드 작성

- /lib/screens/cam_screen.dart
```dart
@override
Widget build(BuildContext context) {

}

// 내 핸드폰이 찍는 화면 랜더링
Widget renderSubView() {
  if (uid != null) {
    return AgoraVideoView(
      controller: VideoViewController(
        rtcEngine: engine!,
        canvas: const VideoCanvas(uid: 0),
      ),
    );
  } else {
    return CircularProgressIndicator();
  }
}

// 상대 핸드폰이 찍는 화면 랜더링
Widget renderMainView() {
  if (otherUid != null) {
    return AgoraVideoView(
      controller: VideoViewController.remote(
        rtcEngine: engine!,
        canvas: VideoCanvas(uid: otherUid),
        connection: const RtcConnection(channelId: channelName),
      ),
    );
  } else {
    return Center(
      child: const Text(
        'waiting for other user',
        textAlign: TextAlign.center,
      ),
    );
  }
}
```

### implement build() related to renderMainView() and renderSubView()

- /lib/screens/cam_screen.dart
```dart
  @override
  Widget build(BuildContext context) {
  // ...
          // Future 실행 후 아직 데이터가 앖을 때 로딩 중 표시
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          // 화면 랜더링
          return Stack(
            children: [
              renderMainView(), // 상대방 화면
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  color: Colors.grey,
                  height: 160,
                  width: 120,
                  child: renderSubView(),
                ),
              ),
            ],
          );
          
```

### implment Exit button

채널 나가기 및 뒤로 가기

- /lib/screens/cam_screen.dart
```dart
  @override
  Widget build(BuildContext context) {
  // ...
          // Future 실행 후 아직 데이터가 앖을 때 로딩 중 표시
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          // 화면 랜더링
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    renderMainView(), // 상대방 화면
                    // 내 화면
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        color: Colors.grey,
                        height: 160,
                        width: 120,
                        child: renderSubView(),
                      ),
                    ),                    
                  ],
                ),                
              ),
              // 채널 퇴장 및 뒤로 가기 버튼
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: ElevatedButton(
                  onPressed: () async {
                    // 채널 나가기 
                    if(engine != null) {
                      await engine!.leaveChannel();
                    }

                    // 뒤로 가기
                    Navigator.of(context).pop();
                  },
                  child: Text('Leave Channel'),
                ),
              ),
            ],
          );
          
```

