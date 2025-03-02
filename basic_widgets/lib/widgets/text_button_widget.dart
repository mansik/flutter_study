import 'package:flutter/material.dart';

/// 제스처 관련 위젯: TextButton
// stl 입력후 탭 키하면 StatelessWidget 자동 완성
class TextButtonWidgetExample extends StatelessWidget {
  const TextButtonWidgetExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: TextButton(
            onPressed: () {}, // 클릭 시 실행
            style: TextButton.styleFrom(
              foregroundColor: Colors.red, // 주색상 지정
            ), // 스타일 지정
            child: Text('text button'), // 버튼에 넣을 위젯
          ),
        ),
      ),
    );
  }
}
