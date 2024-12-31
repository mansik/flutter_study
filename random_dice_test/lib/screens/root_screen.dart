import 'dart:math';

import 'package:flutter/material.dart';
import 'package:random_dice_test/screens/home_screen.dart';
import 'package:random_dice_test/screens/settings_screen.dart';
import 'package:shake/shake.dart';

/// TabBarView + BottomNavigationBar widget
class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> with TickerProviderStateMixin {
  // 3.5 탭 컨트롤러 생성
  // 3.5.1 TickerProviderStateMixin 사용
  // 3.5.2 TabController 선언
  TabController? controller;
  double threshold = 2.7; // 4.1 settings_screen의 민감도의 기본값
  // 5. 핸드폰을 흔들 때마다 매번 새로운 숫자를 생성
  int number = 1; // 주사위 숫자
  ShakeDetector? shakeDetector; // 5.1 핸드폰 흔들기 감지할 변수

  @override
  void initState() {
    super.initState();

    // 3.5.3 초기화
    controller = TabController(length: 2, vsync: this);

    // 3.6 BottomNavigationBar를 눌러 화면이 전환 되도록 TabController 연동
    // 3.6.1 컨트롤러 속성이 변경될 때마다 실행할 함수 등록
    controller!.addListener(tabListener);

    // 5.2 흔들기 감지를 즉시 시작
    shakeDetector = ShakeDetector.autoStart(
      onPhoneShake: onPhoneShake, // 감지 후 실행할 함수
      shakeThresholdGravity: threshold, // 감지 민감도
      shakeSlopTimeMS: 100, // 감지 주기
    );
  }

  // 5.3 흔들기 감지 후 실행할 함수
  void onPhoneShake() {
    final rand = Random();

    setState(() {
      number = rand.nextInt(5) + 1; // 0~5 + 1
    });
  }

  // 3.6.2 컨트롤러 속성이 변경될 때마다 setState()를 통해 build()를 재실행
  void tabListener() {
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // 3.6.3 리스너에 등록한 함수 등록 취소
    controller!.removeListener(tabListener);
    shakeDetector!.stopListening(); // 5.4 흔들기 감지 중지
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: controller,
        children: renderChildren(),
      ),
      bottomNavigationBar: renderBottomNavigation(),
    );
  }

  List<Widget> renderChildren() {
    return [
      HomeScreen(number: number),
      SettingsScreen(threshold: threshold, onThresholdChange: onThresholdChange)
      // 4.2
    ];
  }

  // 4.3 Slider 값 변경 시 실행할 함수
  // 매개변수로 입력받은 현잿값을 State에 저장
  void onThresholdChange(double val) {
    setState(() {
      threshold = val;
    });
  }

  BottomNavigationBar renderBottomNavigation() {
    return BottomNavigationBar(
      // 3.6.4 현재 화면에 렌더링되는 탭의 인덱스
      currentIndex: controller!.index,
      // 3.6.4 탭이 선택될 때마다 실행도는 함수
      // 컨트롤러를 선택된 인덱스로 변경
      onTap: (int index) {
        setState(() {
          controller!.animateTo(index);
        });
      },

      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.edgesensor_high_outlined,
          ),
          label: 'dice',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.settings,
          ),
          label: 'config',
        ),
      ],
    );
  }
}
