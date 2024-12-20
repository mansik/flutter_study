import 'package:basic_widgets/widgets/elevated_button_widget.dart';
import 'package:basic_widgets/widgets/icon_button_widget.dart';
import 'package:basic_widgets/widgets/outlined_button_widget.dart';
import 'package:basic_widgets/widgets/text_button_widget.dart';
import 'package:basic_widgets/widgets/text_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          // child: TextWidgetExample(), // 위젯명을 입력하면 import는 자동 완성됨.
          // child: TextButtonWidgetExample(),
          // child: OutlinedButtonWidgetExample(),
          // child: ElevatedButtonWidgetExample(),
          child: IconButtonWidgetExample(),
        ),
      ),
    );
  }
}
