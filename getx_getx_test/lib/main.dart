import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 1. 컨트롤러 정의
class CounterController extends GetxController {
  var count = 0.obs; // Rx 변수 선언 및 초기화. .obs를 사용

  void increment() => count++;
}

void main() {
  runApp(GetMaterialApp(home: CounterScreen()));
}

class CounterScreen extends StatelessWidget {
  // 2. 컨트롤러 인스턴스 생성(Get.put()를 사용하여 객체 주입)
  // Get.put()은 GetX에서 객체를 전역에서 관리할 때 사용(Dependency Injection)
  final CounterController counterController = Get.put(CounterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("GetX GetX Counter")),
      body: Center(
        // 3. Rx 변수 사용
        child: GetX<CounterController>(
          builder: (controller) => Text("Count: ${controller.count}"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: counterController.increment,
        child: Icon(Icons.add),
      ),
    );
  }
}
