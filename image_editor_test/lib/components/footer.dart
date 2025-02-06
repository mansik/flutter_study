import 'package:flutter/material.dart';

// 스티커를 선택할 때마나 실행할 함수의 시그니처
typedef OnEmoticonTap = void Function(int id);

/// 스티커를 고르는 화면
class Footer extends StatelessWidget {
  final OnEmoticonTap onEmoticonTap;

  const Footer({required this.onEmoticonTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withAlpha((0.9 * 255).toInt()),
      height: 150,
      child: SingleChildScrollView(
        // 가로로 스크롤 가능하게 스티커 구현
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            7,
            (index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  onEmoticonTap(index + 1);
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
