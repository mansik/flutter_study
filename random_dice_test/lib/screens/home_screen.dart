import 'package:flutter/material.dart';
import 'package:random_dice_test/consts/colors.dart';

class HomeScreen extends StatelessWidget {
  final int number; // 주사위 숫자, RootScreen에서 넘겨 받음

  const HomeScreen({required this.number, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image.asset('assets/images/$number.png'),
        ),
        SizedBox(
          height: 32.0,
        ),
        Text(
          'Lucky number',
          style: TextStyle(
            color: secondaryColor,
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: 32.0,
        ),
        Text(
          number.toString(),
          style: TextStyle(
            color: primaryColor,
            fontSize: 60.0,
            fontWeight: FontWeight.w200,
          ),
        )
      ],
    );
  }
}
