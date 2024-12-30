import 'package:flutter/material.dart';
import 'package:random_dice/consts/colors.dart';

class SettingsScreen extends StatelessWidget {
  final double threshold; // Slider의 현잿값
  final ValueChanged<double> onThresholdChage; // Slider가 변경될 때마다 실행되는 함수

  const SettingsScreen({
    super.key,
    required this.threshold,
    required this.onThresholdChage,
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
                'sensibility(민감도)',
                style: TextStyle(
                  color: secondaryColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
        ),
        Slider(
          min: 0.1,
          max: 10.0,
          divisions: 101,
          // 최솟값과 최대값 사이의 구간 개수
          value: threshold,
          onChanged: onThresholdChage,
          label: threshold.toStringAsFixed(1), // slicer값을 소수점 1 자리까지 표시
        ),
      ],
    );
  }
}
