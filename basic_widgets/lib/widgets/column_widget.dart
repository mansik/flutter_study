import 'package:flutter/material.dart';

/// Layout 관련 위젯: Column 위젯
///
/// 주축 main axis, 반대축 cross axis
/// Row 위젯: 가로로 배치, main axis = 가로, cross axis = 세로
/// Column 위젯: 세로로 배치, main axis = 세로, cross axis = 가로
/// MainAxisAlignment.start: 주축을 시작에 정렬
/// MainAxisAlignment
/// .start
/// .center
/// .end
/// .spaceBetween: 균등하게 정렬
/// .spaceAround: 균등하게 배치 + 왼쪽, 오른쪽 끝을 위젯 사이의 거리의 반만큼 배정해서 정렬
/// .spaceEvenly: 균등 + 왼쪽, 오른쪽 끝도 균등 배치
/// CrossAxisAligment
/// .start
/// .center
/// .end
class ColumnWidgetExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SizedBox(
          width: double.infinity, // 넓이를 최대한으로 설정
          child: Column(
            // 주축 정렬 지정
            mainAxisAlignment: MainAxisAlignment.start, // center, end, spaceBetween,...
            // 반대축 정렬 지정
            crossAxisAlignment: CrossAxisAlignment.center, // start, end
            // 하위 위젯
            children: [
              // 첫 번째 위젯
              Container(
                height: 50.0,
                width: 50.0,
                color: Colors.red,
              ),

              // 공백 위젯
              const SizedBox(width: 12.0,),

              // 두 번째 위젯
              Container(
                height: 50.0,
                width: 50.0,
                color: Colors.blue,
              ),

              // 공백 위젯
              const SizedBox(width: 12.0,),

              // 세 번째 위젯
              Container(
                height: 50.0,
                width: 50.0,
                color: Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
