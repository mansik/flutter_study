import 'package:flutter/material.dart';

/// 앱의 기본 홈 화면으로 사용할 위젯 만들기
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key}); // const 인스턴스를 생성, 리소스를 적게 사용

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Home Screen'),
    );
  }
}
