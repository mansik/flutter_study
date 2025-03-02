import 'package:flutter/material.dart';

/// 디자인 관련 위젯: SafeArea
///
/// 아이폰 노치, 안드로이드 디자인에서 노치 부근을 피해서 위젯을 배치
class SafeAreaWidgetExample extends StatelessWidget {
  const SafeAreaWidgetExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: SafeArea(
              top: false, // true와 비교
              bottom: true,
              left: true,
              right: true,
              child: Container(
                color: Colors.red,
                height: 300.0,
                width: 300.0,
              )),
        ),
      ),
    );
  }
}
