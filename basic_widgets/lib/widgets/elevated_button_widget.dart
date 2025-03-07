import 'package:flutter/material.dart';

/// 제스처 관련 위젯: ElevatedButton
class ElevatedButtonWidgetExample extends StatelessWidget {
  const ElevatedButtonWidgetExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: Text('Elevated Button'),
          ),
        ),
      ),
    );
  }
}
