import 'package:flutter/material.dart';

void main() {
  runApp(const SplashScreen()); // test/widget_test.dart 수정
}

/// Row, Column widget 사용: Image, animation 위젯을 사용하기 위해서
/// 1. Column 추가
/// 2. Column 가운데 정렬: mainAxisAlignment 추가
/// 3. image 크기 조정: width 추가
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
          child: Column(
              // 가운데 정렬
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo.png',
                  width: 200,
                ),
                CircularProgressIndicator(),
              ]),
        ),
      ),
    );
  }
}
