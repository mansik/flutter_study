import 'package:flutter/material.dart';
import 'package:random_dice_test/consts/colors.dart';
import 'package:random_dice_test/screens/root_screen.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor, // scaffold widget의 배경색
        // Slider widget theme
        sliderTheme: SliderThemeData(
          thumbColor: primaryColor, // 노브 색상
          activeTrackColor: primaryColor, // 노브가 이동한 트랙 색상
          // 노브가 아직 이동하지 않은 트랙 색상
          inactiveTrackColor: primaryColor.withAlpha((0.3 * 255).toInt()),
        ),
        // bottomNavigationBar widget theme
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: primaryColor,
          unselectedItemColor: secondaryColor,
          backgroundColor: backgroundColor,
        ),
      ),
      home: RootScreen(),
    ),
  );
}
