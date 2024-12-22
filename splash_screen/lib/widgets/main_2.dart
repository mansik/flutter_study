import 'package:flutter/material.dart';

/// 2. 배경색 변경: body: Container로 수정
void main() {
  runApp(const SplashScreen()); // test/widget_test.dart 수정
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Colors.orange,
          ),
          child: Center(
            child: Text('Splash Screen'),
          ),
        ),
      ),
    );
  }
}
