import 'package:flutter/material.dart';

/// 디자인 관련 위젯: SizedBox
///
/// 일정 크기의 공간을 공백으로 두고 싶을 때 사용
/// Container 위젯을 사용해도 공백을 만들 수 있지만
/// SizedBox는 const 생성자를 사용했을 때 퍼포먼스에서 이점을 얻을 수 있다.
class SizedBoxWidgetExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: SizedBox(
            height: 200.0,
            width: 200.0,
            child: Container(
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
