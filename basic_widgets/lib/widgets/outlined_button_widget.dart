import 'package:flutter/material.dart';

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
