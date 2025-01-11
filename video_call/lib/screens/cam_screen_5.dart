import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:video_call/const/agora.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

// implement build() related to renderMainView() and renderSubView()
class CamScreen extends StatefulWidget {
  const CamScreen({super.key});

  @override
  State<CamScreen> createState() => _CamScreenState();
}

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
      options:
          ChannelMediaOptions(), // 영상과 관련된 여러 가지 설정을 할 수 있음. 현재 프로젝트에서는 기본 설정 사용
    );

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LIVE'),
      ),

      //2. Future값(init())을 기반으로 위젯 렌더링
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
        },
      ),
    );
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
}
