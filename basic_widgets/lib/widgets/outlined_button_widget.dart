import 'package:flutter/material.dart';

/// 제스처 관련 위젯: OutlinedButton
class OutlinedButtonWidgetExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: Text('outlined button'),
          ),
        ),
      ),
    );
  }
}
