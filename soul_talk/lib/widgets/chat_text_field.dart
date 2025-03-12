import 'package:flutter/material.dart';

/// 채팅 입력창
///
/// TextField에 입력된 값을 받아올 수 있도록 controller를 입력받고,
/// 메시지 전송 버튼을 눌렀을 때 함수를 실행할 수 있도록 onSend를 입력받음.
class ChatTextField extends StatelessWidget {
  // 입력값 추출을 위해 외부에서 controller 직접 입력 받기
  final TextEditingController controller;

  // 메시지 전송 버튼을 눌렀을 때 실행할 함수
  final VoidCallback onSend;

  // 에러 메시지 있을 경우 입력 받기
  final String? errorText;

  // 로딩 중일 경우 전송 버튼 디자인을 회색으로 변경 및 비활성화하기 위한 상태값
  final bool loading;

  const ChatTextField({
    super.key,
    required this.controller,
    required this.onSend,
    this.errorText,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: Colors.blueAccent,
      textAlignVertical: TextAlignVertical.center,

      // 입력 필드 최소 1줄
      minLines: 1,

      // 입력 필드 최대 4줄
      maxLines: 4,
      decoration: InputDecoration(
        errorText: errorText,

        // 텍스트 필드 전송 버튼
        // suffixIcon은 UI 디자인에서 입력 필드(Input field) 등에서 끝(오른쪽)에 표시되는 아이콘을 의미
        suffixIcon: IconButton(
          onPressed: loading ? null : onSend,
          icon: Icon(
            Icons.send_outlined,
            color: loading ? Colors.grey : Colors.blueAccent,
          ),
        ),

        // 테두리 둥근 형태
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),

        // 텍스트 필드가 선택되어 있는 경우 파란색 테두리로 변경
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
          borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
        ),
        hintText: 'Input message!',
      ),
    );
  }
}
