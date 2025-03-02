import 'package:flutter/material.dart';

/// 제스처 관련 위젯: FloatingActionButton
class FloatingActionButtonWidgetExample extends StatelessWidget {
  const FloatingActionButtonWidgetExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // FloatingActionButton은 Scaffold와 같이 사용한다.
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Text('clicked'),
        ),
        body: Container(),
      ),
    );
  }
}
