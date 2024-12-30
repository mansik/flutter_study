import 'package:flutter/material.dart';
import 'package:random_dice/consts/colors.dart';

/// 주사위 이미지 + text
///
/// 숫자는 RootScreen 위젯에서 정해서 생성자를 통해 입력받음
class HomeScreen extends StatelessWidget {
  final int number;

  //const HomeScreen({required this.number, Key? key}) : super(key: key);
  const HomeScreen({required this.number, super.key}); // 동일함

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
