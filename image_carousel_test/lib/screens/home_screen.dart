import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 5. PageView에 사용할 PageController 추가
  PageController pageController = PageController();

  // 3. initState() 추가
  // Alt + Insert(Generate..) : override Methods..
  // 4. Timer.periodic() 추가
  // 7. pageController 사용하여 페이지를 주기적으로 변경한다.
  @override
  void initState() {
    super.initState();

    Timer.periodic(
      Duration(seconds: 3),
      (timer) {

        // pageController.page 게터를 사용해서 현재 페이지를 가져온다.
        int? page = pageController.page?.toInt();

        if (page == null) {
          return;
        }

        // 마지막 페이지이면 첫 페이지로 변경, 그외는 페이지 증가
        if (page == 4) {
          page = 0;
        } else {
          page++;
        }

        // Timer.periodic()에 설정된 시간 만큼 주기적으로 page를 변경한다.
        pageController.animateToPage(
          page,
          duration: Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // 2. 상태바 색상 변경
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    // 1. PageView 추가
    return Scaffold(
      body: PageView(
        // 6. controller에 pageController 등록
        controller: pageController,
        children: [1, 2, 3, 4, 5]
            .map(
              (number) => Image.asset(
                'asset/images/image_$number.jpeg',
                fit: BoxFit.cover, // 이미지가 부모 위젯 전체를 덮는선에서 최소한의 크기로 조절
              ),
            )
            .toList(),
      ),
    );
  }
}
