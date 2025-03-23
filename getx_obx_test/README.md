# getx_obx_test

A new Flutter project.

GetX의 3가지 상태 관리 방법 중 Obx(반응형 상태 관리)를 사용한 상태 관리

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


## Features

GetX는 GetBuilder(간단한 상태 관리), Obx(반응형 상태 관리), GetxController(고급 상태 관리)를 사용한 3가지의 상태 관리가 있다.
그 중 Obx(반응형 상태 관리)를 다룬다.

## Skill

getx: obx

## Plugin(pub.dev)

-  get: ^4.7.2

## prior knowledge

### GetX란?

GetX는 Flutter의 강력한 상태 관리, 라우팅, 의존성 주입을 제공하는 프레임워크입니다.
Flutter 개발을 더욱 간단하고 효율적으로 만들기 위해 설계되었으며, 코드량을 줄이고 성능을 최적화하는 데 도움을 줍니다.

#### 1. GetX의 주요 기능

- 상태 관리(State Management) → GetBuilder, Obx, GetxController를 사용한 상태 관리.
- 라우팅 관리(Navigation) → Get.to(), Get.off(), Get.back()을 활용한 간편한 화면 이동.
- 의존성 주입(Dependency Injection) → Get.put(), Get.lazyPut(), Get.find()를 사용한 객체 관리.
- 국제화(Localization) → 여러 언어 지원.
- Snackbar, Dialog, BottomSheet → 기본 Flutter 위젯보다 더 간단한 UI 구성 가능.

#### 2. 상태 관리 (State Management)

- GetX는 세 가지 방식의 상태 관리 방법을 제공합니다.
- Get has two different state managers: the simple state manager (we'll call it GetBuilder) and the reactive state manager (GetX/Obx)
- Rx(ReactiveX), Obs(Observable)

1) 간단한 상태 관리 (GetBuilder)
- 상태가 변경될 때 UI를 다시 그리는 방식.
- GetxController를 상속받은 클래스를 생성하고, update()를 호출하여 UI를 갱신.
2) 반응형 상태 관리 (Obx/GetX)
- Rx 변수를 사용하여 상태 변화를 감지하고 자동으로 UI를 업데이트.
- Rx 변수를 사용하면 update() 호출 없이 자동 반영됨.
- GetBuilder, GetX와 다르게 Obx안에서 Controller를 초기화 할 수 없다.
3) 고급 상태 관리 (GetX)
- GetX 위젯을 사용하면 특정 Controller를 감시할 수 있음.
- GetX는 Obx보다 세밀한 상태 관리를 할 수 있음.


#### 3. 라우팅 (Navigation)

- Flutter의 Navigator 대신 GetX의 Get.to(), Get.back()를 사용하면 더 간단하게 화면을 이동할 수 있음.

#### 4. 의존성 주입 (Dependency Injection)

- GetX는  Get.put(), Get.lazyPut(), Get.find()를 사용하여 객체를 전역에서 관리할 수 있도록 도와줌.

6. 결론
- GetX는 Flutter에서 강력한 상태 관리, 라우팅, 의존성 주입을 제공하는 라이브러리!
- 기존 Provider, Navigator보다 코드가 간결하고 사용이 편리함.
- GetBuilder, Obx, GetX를 활용한 다양한 상태 관리 방법 제공.
- Get.to(), Get.back()으로 간편한 화면 전환 가능.
- 의존성 주입을 통해 객체를 효율적으로 관리할 수 있음.


## Steps

### modify pubspec.yaml
```
dependencies:
   get: ^4.7.2
```

### implement countController

- GetxController를 상속받은 클래스를 생성하고, 
- 변수 초기화시 .obs를 사용하여 Rx 변수로 선언.

- /lib/controllers/count_controller.dart
```dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 1. 컨트롤러 정의
// Obx를 사용해 count가 변경될 때 UI가 자동 업데이트됨.
class CounterController extends GetxController {
  var count = 0.obs; // Rx 변수 선언 및 초기화. .obs를 사용

  void increment() => count++; // Rx 변수 업데이트. Rx 변수를 사용하면 update() 호출 없이 자동 반영됨.
}
```

### implement main

- GetX 사용 시 GetMaterialApp 필요

- /lib/main.dart
```dart
import 'package:get/get.dart';

void main() {
  runApp(
    GetMaterialApp(home: CounterScreen()), // GetX 사용 시 GetMaterialApp 필요
  );
}
```

### implement counter_screen

- Rx 변수를 사용하면 자동으로 UI를 업데이트.
- Get.put()은 GetX에서 객체를 전역에서 관리할 때 사용(Dependency Injection)

- /lib/screens/counter_screen.dart
```dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_obx_test/controllers/count_controller.dart';

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
```



