import 'package:flutter/material.dart';
import 'package:random_dice/consts/colors.dart';
import 'package:random_dice/screens/root_screen.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: backgroudColor,
        // Slider widget theme
        sliderTheme: SliderThemeData(
          thumbColor: primaryColor, // 노브 색상
          activeTickMarkColor: primaryColor, // 노브가 이동한 트랙 색상
          // 노브가 아직 이동하지 않는 트랙 색상
          inactiveTrackColor: primaryColor.withAlpha((0.3*255).toInt()),
        ),
        // BottomNavigationBar widget theme
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: primaryColor,
          unselectedItemColor: secondaryColor,
          backgroundColor: backgroudColor,
        ),
      ),
      home: RootScreen(),
    ),
  );
}
