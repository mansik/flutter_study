# get_it_test

A new Flutter project.

출처: https://youtu.be/SN85Vf2eoGY


## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


## Features

riverpot

## Skill

riverpot

## Plugin(pub.dev)

- flutter_riverpod: ^2.6.1

## prior knowledge

### Riverpod이란?
- Riverpod은 Flutter의 상태 관리 패턴 중 하나로, Provider의 단점을 개선한 더 안전하고 효율적인 상태 관리 라이브러리입니다.
- Dart 개발자인 Rémi Rousselet가 만들었으며, Provider의 개선 버전이라고 볼 수 있습니다.

#### 1. Riverpod의 특징
- 전역 상태 관리 → 어디서든 데이터를 접근하고 관리할 수 있음.
- 타입 안전성 → Provider를 생성할 때 타입을 명확하게 지정. 
- 의존성 주입(DI, Dependency Injection) → 여러 Provider를 서로 의존하게 만들 수 있음.
- BuildContext가 필요 없음 → BuildContext 없이도 상태를 관리 가능.
- Flutter와 독립적 → Dart 콘솔 앱에서도 사용 가능.
- 자동 상태 정리 → 사용되지 않는 Provider는 자동으로 메모리에서 해제됨.

#### 2. Riverpod의 주요 Provider 종류
|Provider 종류|설명|
|:---|:---|
|StateProvider|간단한 상태 값 관리 (int, String, bool 등)|
|FutureProvider|비동기 데이터 관리 (API 호출 등)|
|StreamProvider|실시간 데이터 관리 (WebSocket, Firebase 등)|
|StateNotifierProvider|복잡한 상태 로직을 관리|
|ChangeNotifierProvider|ChangeNotifier 기반 상태 관리|

#### 3. 결론
- Riverpod은 Provider의 업그레이드 버전으로 더 안전하고 강력한 상태 관리 제공.
- 타입 안정성이 뛰어나고, BuildContext가 필요 없음.
- StateProvider, FutureProvider, StreamProvider, StateNotifierProvider 등 다양한 상태 관리 가능.
- 기존 Provider를 사용 중이라면 Riverpod으로 마이그레이션을 고려할 만함.


## Steps

home_screen -> main

### modify pubspec.yaml
```
dependencies:
  flutter_riverpod: ^2.6.1
```

### implement main

ProviderScope로 감싸야 함.

- /lib/main.dart
```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpot_test/screens/counter_screen.dart';

void main() {
  runApp(const ProviderScope(child:MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Riverpod Demo',
        home: CounterScreen());
  }
}
```

### implement counter_screen

1. StateNotifier 클래스 생성
2. final counterProvider = StateNotifierProvider((ref) => CounterNotifier());로 Creates a StateNotifier and exposes its current state.
3. final count = ref.watch(counterProvider);로 Returns the value exposed by a provider and rebuild the widget when that value changes.
4. ref.read(counterProvider.notifier).increment();로 Reads a provider without listening to it.


- /lib/screens/home_screen.dart
```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1. 상태를 정의하는 클래스를 생성
class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);

  void increment() => state++; // 상태 변경
}

// 2. StateNotifierProvider로 관리
final counterProvider = StateNotifierProvider((ref) => CounterNotifier());

class CounterScreen extends ConsumerWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 3. 상태값 읽기
    final count = ref.watch(counterProvider);

    // log 보기
    // 상태가 업데이트된 경우 listen을 통해 검증하고 원하는 로직을 실행할 수 있다.
    ref.listen(counterProvider, (previous, next) {
      print('state changed: $previous => $next');
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Count: ${count.toString()}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // 4. 상태값 변경
                ref.read(counterProvider.notifier).increment();
              },
              child: const Text('Increment'),
            ),
          ],
        ),
      ),
    );
  }
}

```



