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
