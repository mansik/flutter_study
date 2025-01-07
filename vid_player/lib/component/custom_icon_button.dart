import 'package:flutter/material.dart';

/// iconbutton 위젯
///
/// 외부에서 GestureTapCallback와 IconData를 입력받아서 iconbutton 위젯을 만든다.
class CustomIconButton extends StatelessWidget {
  // 외부에서 입력 받을 데이터 선언
  final GestureTapCallback onPressed; // 아이콘 버튼을 눌렀을 때 실행할 함수
  final IconData iconData; // 아이콘

  const CustomIconButton(
      {required this.onPressed, required this.iconData, super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      iconSize: 30.0,
      color: Colors.white,
      icon: Icon(iconData),
    );
  }
}
