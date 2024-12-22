import 'package:flutter/material.dart';

void main() {
  runApp(const SplashScreen()); // test/widget_test.dart 수정
}

/// animation widget 추가: LinearProgressIndicator, CircularProgressIndicator
/// Row, Column widget 사용: Image, animation 위젯을 사용하기 위해서
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
              children: [
                Image.asset(
                  'assets/logo.png',
                ),
                CircularProgressIndicator(),
              ]
          ),
        ),
      ),
    );
  }
}
