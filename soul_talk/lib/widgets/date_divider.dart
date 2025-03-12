import 'package:flutter/material.dart';

/// 날짜를 입력받고 화면에 '2025-03-08' 형식으로 출력하는 위젯
///
/// 이전 채팅 메시지와 현재 채팅 메시지의 생성 날짜가 다를 때 화면에 출력한다.
class DateDivider extends StatelessWidget {
  final DateTime date;

  const DateDivider({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Text(
      '${date.year}-${date.month}-${date.day}',
      style: TextStyle(fontSize: 12, color: Colors.black54),
      textAlign: TextAlign.center,
    );
  }
}
