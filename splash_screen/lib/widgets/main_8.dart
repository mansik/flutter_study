import 'package:flutter/material.dart';

void main() {
  runApp(const SplashScreen()); // test/widget_test.dart 수정
}

/// Row, Column widget 사용: Image, animation 위젯을 사용하기 위해서
/// 1. Column 위젯 추가
/// 2. Column 가운데 정렬: mainAxisAlignment 추가
/// 3. image 크기 조정: width 추가
/// 4. Row 위젯 추가
/// # Row 위젯으로 Column 위젯(왼쪽부터 정렬)을 감싸면 Row 위젯도 왼쪽부터 위젯들을 정렬한다.
/// # Column 위젯은 세로로 최대한 크기를 차지하고 가로로는 최소한 크기만 차지한다.
/// # Row 위젯은 가로로 최대한 크기를 차지하고 세로로 최소 크기를 차지한다.
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                // 가운데 정렬
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo.png',
                    width: 200,
                  ),
                  CircularProgressIndicator(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
