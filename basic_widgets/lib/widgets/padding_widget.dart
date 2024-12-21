import 'package:flutter/material.dart';

/// 디자인 관련 위젯: Padding
///
/// child 위젯에 여백을 제공할 때 사용
/// Padding 위젯의 상위 위젯과 하위 위젯 사이의 여백
/// EdgeInsets.all(16.0): 상하좌우 균등하게 padding 적용
/// EdgeInsets.symmetric(horizontal: 16.0, vertical:16.0): 가로, 세로 따로 padding 적용
/// EdgeInsets.only(top:16.0, bottom:16.0, left:16.0, right:16.0): 각각 따로 padding 적용
/// EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0): 포지셔널 파라미터를 left, top, right, bottom 순으로 입력
class PaddingWidgetExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            color: Colors.blue,
            child: Padding(
              padding: EdgeInsets.all(
                16.0,
              ),
              child: Container(
                color: Colors.red,
                width: 50.0,
                height: 50.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
