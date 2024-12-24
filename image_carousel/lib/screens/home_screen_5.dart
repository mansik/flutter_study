import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// initState() 함수에서 Timer.periodic() 추가
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // initState() 함수에서 Timer.periodic(); 함수 실행해서 주기적으로 콜백 함수 호출한다.
  // 마우스 우측 -> Generate..(Alter + Insert) -> initState  클릭
  // initState()는 핫 리로드로 반영이 안된다.
  // 이유는 initState()는 State가 생성될 때 딱 한번만 실행된다.
  @override
  void initState() {
    super.initState(); // 부모 initState() 실행

    // async 패키지 사용: import 필요
    Timer.periodic(
      Duration(seconds: 3),
      (timer) {
        print('timer');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // 상태바 색상 변경
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return Scaffold(
      body: PageView(
        children: [1, 2, 3, 4, 5]
            .map(
              (number) => Image.asset(
                'asset/images/image_$number.jpeg',
                fit: BoxFit
                    .cover, // 부모 위젯 전체를 덮는 선에서 최소한 크기로 조절한다. 여백은 생기지 않지만 가로 또는 세로로 이미지가 잘릴 수 있다.
              ),
            )
            .toList(),
      ),
    );
  }
}

// StatefulWidget로 대체
// /// HomeScreen을 HomeScreenStateless로 변경: StatelessWidget
// class HomeScreenStateless extends StatelessWidget {
//   const HomeScreenStateless({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // 상태바 색상 변경
//     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
//
//     return Scaffold(
//       body: PageView(
//         children: [1, 2, 3, 4, 5]
//             .map(
//               (number) => Image.asset('asset/images/image_$number.jpeg',
//                   fit: BoxFit
//                       .cover // 부모 위젯 전체를 덮는 선에서 최소한 크기로 조절한다. 여백은 생기지 않지만 가로 또는 세로로 이미지가 잘릴 수 있다.
//                   ),
//             )
//             .toList(), // 이미지 위젯 리스트
//       ),
//     );
//   }
// }
