import 'package:flutter/material.dart';

/// 1. 기본 위젯 만들기: body: Center
void main() {
  runApp(const SplashScreen()); // test/widget_test.dart 수정
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Splash Screen'),
        ),
      ),
    );
  }
}
