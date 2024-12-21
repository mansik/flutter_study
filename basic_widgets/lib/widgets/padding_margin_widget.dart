import 'package:flutter/material.dart';

/// 디자인 관련 위젯: Padding
///
/// margin: 위젯의 바깥에 간격을 추가
/// padding: 위젯의 안쪽에 간격을 추가
class PaddingMarginWidgetExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            color: Colors.black,
            child: Container(
              color: Colors.blue,
              margin: EdgeInsets.all(16.0), // blue 박스의 바깥 두께
              child: Padding(
                padding: EdgeInsets.all(16.0), // blue 박스 안쪽의 간격
                child: Container(
                  color: Colors.red,
                  width: 50,
                  height: 50,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
