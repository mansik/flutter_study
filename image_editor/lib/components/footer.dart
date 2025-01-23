import 'package:flutter/material.dart';

//  2. 스티커를 선택할 때마다 실행할 함수의 시그니처
typedef OnEmotionTap = void Function(int id);

class Footer extends StatelessWidget {
  final OnEmotionTap onEmotionTap;

  const Footer({required this.onEmotionTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withAlpha((0.9 * 255).toInt()),
      height: 150,
      child: SingleChildScrollView( // 가로로 스크롤 가능하게 스티커 구현
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            7,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GestureDetector(
                onTap: () {
                  onEmotionTap(index + 1); // 스티커 선택할 때 실행할 함수
                },
                child: Image.asset(
                  'assets/images/emoticon_${index + 1}.png',
                  height: 100,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
