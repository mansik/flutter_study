import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

/// (https://pub.dev)의 `camear` plugin's example를 가져옴

late List<CameraDescription> _cameras;

// Future<void>는 비동기 작업이 완료될 때까지 기다렸다가 다음 코드를 실행하기 위해 사용됩니다.
// 비동기 작업:
// Flutter 앱의 초기화 작업은 availableCameras() 함수를 호출하여 사용 가능한 카메라 목록을 가져오는 것을 포함합니다.
// availableCameras() 함수는 비동기적으로 동작하며, 결과를 반환하는 데 시간이 걸릴 수 있습니다.
// Future<void>를 사용하면 availableCameras() 함수가 완료될 때까지 기다렸다가 앱을 실행할 수 있습니다.
Future<void> main() async {
  // 1. 플러터 앱이 실행될 준비가 되었는지 확인
  // main() 함수의 첫 실행값이 runApp()이면 불필요하지만
  // 다른 코드가 먼저 실행되어야 하면 꼭 제일 먼저 실행해야 한다.
  WidgetsFlutterBinding.ensureInitialized();

  // 2. 핸드폰에 있는 카메라들을 가져오기
  _cameras = await availableCameras();
  runApp(const CameraApp());
}

/// CameraApp is the Main Application.
class CameraApp extends StatefulWidget {
  /// Default Constructor
  const CameraApp({super.key});

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  // 3. 카메라를 제어할 수 있는 컨트롤러 선언
  late CameraController controller;

  @override
  void initState() {
    super.initState();

    // 4. 가장 첫 번째 카메라로 카메라 설정하기
    controller = CameraController(_cameras[0], ResolutionPreset.max);

    // 5. 카메라 초기화
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      // UI 업데이트
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    // 컨트롤러 삭제
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 6. 카메라 초기화 상태 확인
    if (!controller.value.isInitialized) {
      return Container();
    }
    return MaterialApp(
      // 7. 카메라 보여주기
      home: CameraPreview(controller),
    );
  }
}
