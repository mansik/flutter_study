import 'package:basic_widgets/widgets/padding_margin_widget.dart';
import 'package:basic_widgets/widgets/container_widget.dart';
import 'package:basic_widgets/widgets/elevated_button_widget.dart';
import 'package:basic_widgets/widgets/floating_action_button_widget.dart';
import 'package:basic_widgets/widgets/gesture_detector_widget.dart';
import 'package:basic_widgets/widgets/icon_button_widget.dart';
import 'package:basic_widgets/widgets/outlined_button_widget.dart';
import 'package:basic_widgets/widgets/padding_widget.dart';
import 'package:basic_widgets/widgets/safe_area_widget.dart';
import 'package:basic_widgets/widgets/sized_box_widget.dart';
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
          // 위젯명을 입력하면 import는 자동 완성됨.
          // child: TextWidgetExample(),
          // child: TextButtonWidgetExample(),
          // child: OutlinedButtonWidgetExample(),
          // child: ElevatedButtonWidgetExample(),
          // child: IconButtonWidgetExample(),
          // child: GestureDetectorWidgetExample(),
          // child: FloatingActionButtonWidgetExample(),
          // child: PaddingWidgetExample(),
          // child: PaddingMarginWidgetExample(),
          // child: SizedBoxWidgetExample(),
          // child: ContainerWidgetExample(),
          child: SafeAreaWidgetExample(),
        ),
      ),
    );
  }
}
