import 'package:flutter/material.dart';

/// 하트 버튼 눌렀을 때 실행할 함수 구현
///
/// - HomeScreen은 StatefulWidget로 상태관리가 가능하지만, _DDay는 StatelessWidget로 상태 관리가 불가능하다.
/// 하트 버튼의 onPressed 매개변수가 _DDay 위젯에 위치해 있어서 _HomeScreenState에서 버튼이 눌렀을 때 콜백을 받을 수 없다.
/// _DDay 위젯에 하트 아이콘을 눌렀을 때 실행되는 콜백 함수를 매개변수로 노출해서 _HomeScreenState에서 상태 관리를 하도록 한다.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime firstDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100], // 100% opacity(불투명)
      body: SafeArea(
        // 시스템 UI 피해서 UI 그리기
        top: true,
        bottom: false,

        // 위아래 배치
        child: Column(
          // 위아래 끝에 위젯 배치하고 처음과 마지막 위젯 사이는 균일하게 배치
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // 반대축 최대 크기로 늘리기
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _DDay(
              // 4.5. 하트 눌렀을 때 실행할 함수 전달
              onHeartPressed: onHeartPressed,
            ),
            _CoupleImage(),
          ],
        ),
      ),
    );
  }

  // 4.4. Heart button 을 눌렀을 때 실행할 함수
  void onHeartPressed() {
    print('clicked');
  }
}

class _DDay extends StatelessWidget {
  // 4.1. Heart button 눌렀을 때 실행할 함수(GestureTapCallback는 typedef
  final GestureTapCallback onHeartPressed;

  // 4.2 생성자에 상위에서 함수를 입력받도록 매개변수 구현
  const _DDay({required this.onHeartPressed});

  @override
  Widget build(BuildContext context) {
    // 1. 테마 불러오기
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        const SizedBox(height: 16.0), // 공백
        Text(
          'U&I',
          style: textTheme.headlineLarge, // 2. 스타일 적용
        ),
        const SizedBox(height: 16.0),
        Text(
          '우리 처음 만난 날',
          style: textTheme.bodyLarge,
        ),
        const SizedBox(height: 16.0),
        Text(
          '2024.12.25',
          style: textTheme.bodyMedium,
        ),
        const SizedBox(height: 16.0),
        IconButton(
          iconSize: 60.0,
          onPressed: onHeartPressed, // 4.3. 아이콘 눌렀을 때 실행할 함수
          icon: Icon(
            Icons.favorite,
            color: Colors.red,
          ),
        ),
        const SizedBox(height: 16.0),
        Text(
          'D+365',
          style: textTheme.headlineMedium,
        ),
      ],
    );
  }
}

class _CoupleImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 핸드폰의 화면 크기가 작을 경우 오버플로가 발생하지 않게 하기 위해서 Expanded 사용
    // Expanded: 이미지를 남는 공간 만큼만 차지하도록 한다.
    return Expanded(
      child: Center(
        child: Image.asset(
          'assets/images/middle_image.png',
          height: MediaQuery.of(context).size.height / 2, // 이미지 높이를 화면의 반으로 설정
        ),
      ),
    );
  }
}
