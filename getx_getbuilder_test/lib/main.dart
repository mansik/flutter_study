import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_getbuilder_test/screens/counter_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( // GetX 사용 시 GetMaterialApp 필요
      home: CounterScreen(),
    );
  }
}