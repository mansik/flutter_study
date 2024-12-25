import 'package:flutter/material.dart';
import 'package:u_and_i/screens/home_screen.dart';

/// text widget의 기본 스타일을 변경하기 위해서 theme를 사용
void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      fontFamily: 'sunflower',
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          color: Colors.white,
          fontSize: 80.0,
          fontWeight: FontWeight.w700, // 두께
          fontFamily: 'parisienne',
        ),
        headlineMedium: TextStyle(
          color: Colors.white,
          fontSize: 50.0,
          fontWeight: FontWeight.w700,
        ),
        bodyLarge: TextStyle(
          color: Colors.white,
          fontSize: 30.0,
        ),
        bodyMedium: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),
      ),
    ),
    home: HomeScreen(),
  ));
}
