import 'package:flutter/material.dart';

/// add style to Text widget in _DDay
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
            _DDay(),
            _CoupleImage(),
          ],
        ),
      ),
    );
  }
}

class _DDay extends StatelessWidget {
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
          onPressed: () {},
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
    return Center(
      child: Image.asset(
        'assets/images/middle_image.png',
        height: MediaQuery.of(context).size.height / 2, // 이미지 높이를 화면의 반으로 설정
      ),
    );
  }
}
