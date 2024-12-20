import 'package:flutter/material.dart';

// stl 입력후 탭 키하면 StatelessWidget 자동 완성
class TextWidgetExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(
            'text example', // Text 내용
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w700, // 굵기
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }
}
