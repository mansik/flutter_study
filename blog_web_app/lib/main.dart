import 'package:blog_wep_app/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  // 플러터 프레임워크가 앱을 실행할 준비가 될 때까지 기다림(앱을 실행할 준비가 됐는지 확인)
  // StatelessWidget에서  WebViewController를 프로퍼티로 직접 인스턴스화하려면
  // 반드시 이 함수를 직접 실행해 주어야 한다.
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
      home: HomeScreen(),
    )
  );
}
