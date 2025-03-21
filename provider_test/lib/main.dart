import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/providers/album_provider.dart';
import 'package:provider_test/views/album_view.dart';

void main() {
  runApp(const MyApp());
}

/// Provider 등록하기
///
/// ChangeNotifierProvider를 사용하여 Provider를 등록한다.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider<AlbumProvider>(
        create: (context) => AlbumProvider(), // AlbumProvider 인스턴스 생성
        child: const AlbumView(),
      ),
    );
  }
}
