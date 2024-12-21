import 'package:flutter/material.dart';

/// Layout 관련 위젯: Expanded
///
/// Expanded 위젯은 Flexible 위젯을 상쇽하는 위젯
/// Column, Row 위젯에서 Expanded 위젯을 사용하면 남은 공간을 최대한으로 차지한다.
/// fit 매개변수에 FlexFit.tight, FlexFit.loose를 입력한다.
/// FlexFit.loose는 자식 위젯이 필요한 만큼의 공간만 차지한다.
/// FlexFit.tight는 자식 위젯이 차지하는 공간과 관계없이 남은 공간을 모두 차지한다.
/// Expanded 위젯은 Flexible 위젯의 fit 매개변수에 FlexFit.tight를 기본으로 제공해준 위젯이다.
class ExpandedWidgetExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SizedBox(
          // Expanded 위젯이 2개이기 때문에 각 위젯이 남는 공간을 똑같이 나눠 갖는다.
          child: Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.blue,
                ),
              ),

              Expanded(
                child: Container(
                  color: Colors.red,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
