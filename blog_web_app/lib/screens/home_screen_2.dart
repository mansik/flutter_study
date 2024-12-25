import 'package:flutter/material.dart';

/// 앱바 구현하기
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key}); // const 인스턴스를 생성, 리소스를 적게 사용

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. 앱바 위젯 추가, Scaffold에 추가한다.
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Title"),
        centerTitle: true, // 가운데 정렬
      ),
      body: Text('Home Screen'),
    );
  }
}
