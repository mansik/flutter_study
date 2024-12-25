import 'package:flutter/material.dart';

/// 처음은 StatelessWidget로 생성
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('home screen'),
    );
  }
}

