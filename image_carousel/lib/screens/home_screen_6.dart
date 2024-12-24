import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// PageController 추가, 사용하여 주기적으로 페이지 변경
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 1. PageView를 조작하기 위해서 PageController 사용
  final PageController pageController = PageController();

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
        // print('timer');

        // 3. PageController 사용하여 페이지 변경하기
        // pageController.page 게터를 사용해서 PageView의 현재 페이지를 가져오며,
        // 페이지가 변경 중인 경우 소수점으로 표현되어 double값이 반환된다.
        // 하지만 페이지 증가 및 animateToPage()에서 정수값을 필요로 하므로 정수로 변환하였음.
        int? nextPage = pageController.page?.toInt(); // 현재 페이지 가져오기

        // 페이지가 없을 때 예외 처리
        if (nextPage == null) {
          return;
        }

        // 첫 페이지와 마지막 페이지 분기 처리 및 다음 페이지 셋팅
        if (nextPage == 4) {
          nextPage = 0;
        } else {
          nextPage++;
        }

        // 페이지 변경
        pageController.animateToPage(
          nextPage,
          duration: Duration(milliseconds: 500), // 이동시 소요 시간
          curve: Curves.ease, // 페이지가 변경되는 애니메이션 작동 방식(https://api.flutter.dev/flutter/animation/Curves-class.html)
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // 상태바 색상 변경
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return Scaffold(
      body: PageView(
        // 2. PageController 등록
        controller: pageController,
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
