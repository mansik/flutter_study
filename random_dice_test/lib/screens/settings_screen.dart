import 'package:flutter/material.dart';
import 'package:random_dice_test/consts/colors.dart';

class SettingsScreen extends StatelessWidget {
  // Slider의 현재값, RootScreen에서 입력받음
  final double threshold;

  // Slider가 변경될 때마다 실행되는 함수(콜백함수), RootScreen에서 입력받음
  final ValueChanged<double> onThresholdChange;

  const SettingsScreen({
    super.key,
    required this.threshold,
    required this.onThresholdChange,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              Text(
                'sensibility',
                style: TextStyle(
                  color: secondaryColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        Slider(
          min: 0.1,
          max: 10.0,
          divisions: 101,
          value: threshold,
          onChanged: onThresholdChange,
          label: threshold.toStringAsFixed(1), // slider 값을 소수점 1 자리까지 표시
        )
      ],
    );
  }
}
