import 'package:flutter/material.dart';

/// 이모티콘 선택 기능 구현
class EmoticonSticker extends StatefulWidget {
  final VoidCallback onTransform; // 스티커의 상태가 변경될 때마다 실행
  final String imagePath; // 이미지 경로
  final bool isSelected; // 스티커가 선택된 상태인지 지정

  const EmoticonSticker({
    required this.onTransform,
    required this.imagePath,
    required this.isSelected,
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
    return Container(
      // 선택된 상태일 때만 테두리 색상 구현
      decoration: widget.isSelected
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(4.0), // 모서리 둥글게
              border: Border.all(color: Colors.blue, width: 1.0), // 테두리 색상과 두께
            )
          : BoxDecoration(
              // 테두리는 투명이나 너비는 1로 설정해서 스티커가 선택, 취소될 때 깜빡이는 현상 제거
              border: Border.all(color: Colors.transparent, width: 1.0),
            ),
      child: GestureDetector(
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
      ),
    );
  }
}
