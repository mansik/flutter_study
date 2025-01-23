import 'package:flutter/material.dart';

/// implement the EmoticonSticker Widget
class EmoticonSticker extends StatefulWidget {
  final VoidCallback onTransform; // 스티커의 상태가 변경될 때마다 실행
  final String imagePath; // 이미지 경로

  const EmoticonSticker({
    required this.onTransform,
    required this.imagePath,
    super.key,
  });

  @override
  State<EmoticonSticker> createState() => _EmoticonStickerState();
}

class _EmoticonStickerState extends State<EmoticonSticker> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 스티커를 눌렀을 때 실행할 함수
      onTap: () {
        widget.onTransform(); // 스티커의 상태가 변경될 때마다 실행
      },

      // 스티커의 확대 비율이 변경됐을 때 실행
      onScaleUpdate: (details) {
        widget.onTransform(); // 스티커의 상태가 변경될 때마다 실행
      },

      // 스티커의 확대 비율 변경이 완료됐을 때 실행
      onScaleEnd: (details) {},

      child: Image.asset(
        widget.imagePath,
      ),
    );
  }
}
