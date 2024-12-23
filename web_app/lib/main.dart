import 'package:flutter/material.dart';
import 'package:web_app/screens/home_screen.dart';

void main() {
  // StatelessWidget에서 WebViewController를 직접 인스턴스화 하려면
  // 반드시 WidgetsFlutterBinding.ensureInitialized();를 실행해야 한다.
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}
