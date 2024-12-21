import 'package:flutter/material.dart';

/// Layout 관련 위젯: Stack
///
/// Stack는 위젯을 겹친다.
/// 플러터의 그래픽 엔진인 스키아 엔진은 2D 엔진이기 때문에 겹친 두께는 표현하지 못하지만
/// 겹친 듯한 효과를 줄 수 있다.
/// Stack은 children에 위치한 순서대로 위젯을 겹치게 한다.
class StackWidgetExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SizedBox(
          child: Stack(
            children: [
              Container(
                height: 300.0,
                width: 300.0,
                color: Colors.red,
              ),
              Container(
                height: 250.0,
                width: 250.0,
                color: Colors.yellow,
              ),
              Container(
                height: 200.0,
                width: 200.0,
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
