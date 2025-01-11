import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

/// add permissions required for video calls
/// and add Rendering a widget based on the Future value (init())
///
/// - FutureBuilder: 비동기 작업의 결과를 기반으로 위젯을 동적으로 빌드하는데 사용하는 위젯
/// - 주로 네트워크 요청, 파일 읽기, 데이터베이스 쿼리와 같은
/// - 비동기 작업이 완료될 때까지 기다렸다가 결과를 UI에 반영해야 할 때 유용하다.
///
/// build() 함수는 위젯이 생성되면 즉시 실행된다.
/// 하지만 카메라와 마이크의 권한이 있을 때와 없을 때 보여줄 수 있는 화면이 달라야 한다.
/// 문제는 init()가 비동기로 실행되므로 언제 권한 요청이 끝날지 알 수 없으므로,
/// FutureBuilder 위젯을 사용하여 Future를 반환하는 함수의 결과에 따라 위젯을 렌더링하도록 한다.
/// - init()에서 에러를 던지면 에러 내용을 보여주고
/// - 아직 로딩중이면 CircularProgressIndicator를 보여주고
/// - 모든 권한이 허가되면 'all permissions granted'를 보여준다.
class CamScreen extends StatefulWidget {
  const CamScreen({super.key});

  @override
  State<CamScreen> createState() => _CamScreenState();
}

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
}
