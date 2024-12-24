import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Timer를 추가해서 액자가 자동으로 변경되게 하기 위해서 StatefulWidget 사용
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
