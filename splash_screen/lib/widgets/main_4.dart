import 'package:flutter/material.dart';

void main() {
  runApp(const SplashScreen()); // test/widget_test.dart 수정
}

/// Image widget 사용
///
/// Image.asset: asset 파일로 이미지를 그림
/// 1. project에 assets 폴더 생생 후 이미지 파일(logo.png) 복사
/// 2. pubspec.yaml파일에서 assets: 수정 -> pub get 클릭 (README.md 참고)
/// 3. run: stop -> run
/// 4. Image.asset() 추가
/// 5. Colors.orange -> Color(0xFFF99231)로 수정
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Color(0xFFF99231),
          ),
          child: Center(
            child: Image.asset(
              'assets/logo.png',
            ),
          ),
        ),
      ),
    );
  }
}
