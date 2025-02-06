import 'package:flutter/material.dart';

/// 이모티콘 스티커를 이미지에 붙이는 기능, 확대, 축소, 상하좌우 이동
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
  double _scale = 1.0; // 스티커의 확대 비율
  double _hTranslation = 0.0; // 스티커의 수평 이동 거리
  double _vTranslation = 0.0; // 스티커의 수직 이동 거리
  double _actualScale = 1.0; // 실제 스티커의 확대 비율, 위젯의 초기 크기 기준 확대/축소 비율

  @override
  Widget build(BuildContext context) {
    return Transform( // child 위젯을 변형할 수 있는 위젯
      transform: Matrix4.identity()
        ..translate(_hTranslation, _vTranslation) // 수평, 수직 이동
        ..scale(_scale), // 확대, 축소
      child: Container(
        // 선택된 상태일 때만 테두리 색상 구현
        decoration: widget.isSelected
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(4.0), // 모서리 둥글게
                border: Border.all(color: Colors.blue, width: 1.0),
              )
            : BoxDecoration(
                // 테두리는 투명이나 너비를 1로 설정해서 스티커가 선택, 취소될 때 깜빡이는 현상 제거
                border: Border.all(color: Colors.transparent, width: 1.0),
              ),
        child: GestureDetector(
          // 스티커를 터치하면 실행할 함수
          onTap: () {
            widget.onTransform(); // 스티커의 상태가 변경될 때마다 실행
          },
          // 스티커의 확대 비율이 변경됐을 때 실행
          onScaleUpdate: (details) {
            widget.onTransform();
            setState(() {
              _scale = details.scale * _actualScale; // 최근 확대 비율을 기반으로 실제 확대 비율 계산
              _vTranslation += details.focalPoint.dy; // 스티커의 수직 이동 거리 계산
              _hTranslation += details.focalPoint.dx; // 스티커의 수평 이동 거리 계산
            });
          },
          // 스티커의 확대 비율 변경이 완료됐을 때 실행
          onScaleEnd: (details) {
            _actualScale = _scale; // 실제 스티커의 확대 비율을 최근 확대 비율로 변경
          },

          child: Image.asset(widget.imagePath),
        ),
      ),
    );
  }
}
