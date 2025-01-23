import 'package:flutter/material.dart';

/// Implement a feature to capture gesture input(제스처를 입력받아보는 기능)
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
  double scale = 1.0; // 스티커의 확대 비율
  double hTranslation = 0.0; // 스티커의 가로 이동 거리
  double vTtranslation = 0.0; // 스티커의 세로 이동 거리
  double actualScale = 1; // 위젯의 초기 크기 기준 확대/축소 배율

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
        setState(() {
          scale = details.scale * actualScale; //최근 확대 비율을 기반으로 실제 확대 비율 계산
          vTtranslation += details.focalPointDelta.dy; // 세로 이동 거리 계산
          hTranslation += details.focalPointDelta.dx; // 가로 이동 거리 계산
        });
      },

      // 스티커의 확대 비율 변경이 완료됐을 때 실행
      onScaleEnd: (details) {
        actualScale = scale; // 위젯의 실제 초기 크기 대비 배율
      },

      child: Image.asset(
        widget.imagePath,
      ),
    );
  }
}
