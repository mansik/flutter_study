import 'package:flutter/material.dart';

/// Layout 관련 위젯: Flexible
///
/// Row, Column에서 사용하는 위젯
/// Flexible에 제공된 child가 크기를 최소한으로 차지하거나
/// flex 매개변수를 이용하여 공간을 차지하는 비율을 지정할 수 있다.
class FlexibleWidgetExample extends StatelessWidget {
  const FlexibleWidgetExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SizedBox(
          child: Column(
            children: [
              Flexible(
                // flex는 남은 공간을 차지할 비율이다, flex값을 제공하지 않으면 기본값은 1
                flex: 3, // 1, 2, 3 변경해 보기.

                // FlexFit.loose: 자식 위젯이 필요한 만큼의 공간만 차지한다.
                // expanded_widget.dart에서 상세히 설명
                // fit: FlexFit.loose,

                child: Container(
                  color: Colors.blue,
                ),
              ),
              Flexible(
                // flex값은 기본값인 1
                child: Container(
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
