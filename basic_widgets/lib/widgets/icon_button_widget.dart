import 'package:flutter/material.dart';

class IconButtonWidgetExample extends StatelessWidget {
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
