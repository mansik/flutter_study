import 'package:flutter/material.dart';

/// 제스처 관련 위젯: IconButton
class IconButtonWidgetExample extends StatelessWidget {
  const IconButtonWidgetExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.home,
            ),
          ),
        ),
      ),
    );
  }
}
