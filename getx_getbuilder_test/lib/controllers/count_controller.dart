import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 상태 관리 컨트롤러 생성
class CounterController extends GetxController {
  int count = 0;

  void increment() {
    count++;
    update(); // UI 업데이트, update()를 호출하면 GetBuilder가 포함된 UI가 자동으로 갱신됨.
  }
}