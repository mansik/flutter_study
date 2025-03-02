import 'package:flutter/material.dart';

/// 제스처 관련 위젯: GestureDetector
///
/// 손가락으로 하는 여러 가지 입력을 인식하는 위젯
class GestureDetectorWidgetExample extends StatelessWidget {
  const GestureDetectorWidgetExample({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: GestureDetector(
            // 한 번 탭했을 때 실행할 함수
            onTap: (){
              print('on tap');
            },
            // 두 번 탭했을 때 실행할 함수
            onDoubleTap: (){
              print('on double tap');
            },
            onLongPress: (){
              print('on long press');
            },
            // 제스처를 적용할 위젯
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              width: 100.0,
              height: 100.0,
            ),
          ),
        ),
      ),
    );
  }
}
