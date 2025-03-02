import 'package:flutter/material.dart';

/// 디자인 관련 위젯: Container
///
/// 다른 위셋을 담는데 사용
/// 위젯의 너미와 높이를 지정하거나
/// 배경이나 테두리를 추가할 때 많이 사용
class ContainerWidgetExample extends StatelessWidget {
  const ContainerWidgetExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.amber,
              border: Border.all(
                width: 16,
                color: Colors.blue,
              ),
              // 모서리 둥글게 만들기
              borderRadius: BorderRadius.circular(
                16.0,
              ),
            ),
            height: 200.0,
            width: 100.0,
          ),
        ),
      ),
    );
  }
}
