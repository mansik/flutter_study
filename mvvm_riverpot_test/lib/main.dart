import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_riverpot_test/views/album_view.dart';

void main() {
  // Riverpod을 사용하려면 ProviderScope로 앱을 감싸야 합니다.
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: AlbumView());
  }
}
