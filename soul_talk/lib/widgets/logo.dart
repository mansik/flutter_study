import 'package:flutter/material.dart';

/// Logo image and app description text
class Logo extends StatelessWidget {
  // 직접 너비/높이를 정의할 경우를 대비
  final double width;
  final double height;

  const Logo({super.key, this.width = 200, this.height = 200});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // logo image
        Image.asset('assets/images/logo.png', width: width, height: height),
        const SizedBox(height: 32),
        // app description text
        Text(
          'Hi! I am your soul chat bot. How can I help you?',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}
