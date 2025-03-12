import 'package:flutter/material.dart';
import 'package:soul_talk/widgets/point_notification.dart';

/// 제이나이와 내가 한 채팅 내용을 보여줄 채팅 버블
///
/// 왼쪽은 제미나이 메시지, 오른쪽은 내가 보낸 메시지를 위치시킴
class Message extends StatelessWidget {
  // true면 왼쪽 정렬, false면 오른쪽 정렬
  final bool alignLeft;

  // 보여줄 메시지
  final String message;

  // 현재까지 적립된 포인트
  final int? point;

  const Message({
    super.key,
    this.alignLeft = true,
    this.point,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    // alignLeft를 기준으로 Alingment 프로퍼티 생성하기
    final alignment = alignLeft ? Alignment.centerLeft : Alignment.centerRight;

    // 왼쪽 정렬이면 더 어두운 배경 사용
    final backgroundColor = alignLeft ? Color(0xFFF4F4F4) : Colors.white;
    final borderColor = alignLeft ? Color(0xFFE7E7E7) : Colors.black12;

    return Column(
      children: [
        // 메시지 버블 디자인 정의
        Align(
          alignment: alignment,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32.0),
              color: backgroundColor,
              border: Border.all(color: borderColor, width: 1.0),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Text(
                message,
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
            ),
          ),
        ),
        if (point != null)
          Align(alignment: alignment, child: PointNotification(point: point!)),
      ],
    );
  }
}
