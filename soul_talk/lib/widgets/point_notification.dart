import 'package:flutter/material.dart';

/// Gemini에게 메시지를 보낼 때마다 몇 포인트가 적립됐는지 표시해 줄 알림 텍스트
///
/// Notification text to show how many points have been earned each time a message is sent to Gemini.
class PointNotification extends StatelessWidget {
  // 포인터
  final int point;

  const PointNotification({super.key, required this.point});

  @override
  Widget build(BuildContext context) {
    return Text(
      '$point points',
      style: const TextStyle(
        color: Colors.blueAccent,
        fontStyle: FontStyle.italic,
      ),
    );
  }
}
