import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 1. 컨트롤러 정의
// Obx를 사용해 count가 변경될 때 UI가 자동 업데이트됨.
class CounterController extends GetxController {
  var count = 0.obs; // Rx 변수 선언 및 초기화. .obs를 사용

  void increment() => count++; // Rx 변수 업데이트. Rx 변수를 사용하면 update() 호출 없이 자동 반영됨.
}

void main() {
  runApp(
    GetMaterialApp(home: CounterScreen()), // GetX 사용 시 GetMaterialApp 필요
  );
}

class CounterScreen extends StatelessWidget {
  // 2. 컨트롤러 인스턴스 생성(Get.put()를 사용하여 객체 주입)
  // Get.put()은 GetX에서 객체를 전역에서 관리할 때 사용(Dependency Injection)
  final CounterController counterController = Get.put(CounterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("GetX Obx Counter")),
      body: Center(
        // 3. Rx 변수 사용
        child: Obx(() => Text("Count: ${counterController.count}")),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: counterController.increment,
        child: Icon(Icons.add),
      ),
    );
  }
}
