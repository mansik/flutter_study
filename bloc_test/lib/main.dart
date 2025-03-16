import 'package:bloc_test/bloc/album_bloc.dart';
import 'package:bloc_test/providers/api_provider.dart';
import 'package:bloc_test/repositories/album_repository.dart';
import 'package:bloc_test/views/album_view.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void setupGetIt() {
  // AlbumApiProvider를 싱글톤으로 등록합니다.
  GetIt.I.registerSingleton<AlbumApiProvider>(AlbumApiProvider());
  // AlbumRepository 등록: AlbumRepository를 등록할 때 AlbumApiProvider를 주입합니다.
  GetIt.I.registerFactory<AlbumRepository>(
        () => AlbumRepository(GetIt.I.get<AlbumApiProvider>()),
  );
  // AlbumBloc을 팩토리로 등록합니다.: AlbumBloc을 등록할 때 AlbumRepository를 주입합니다.
  GetIt.I.registerFactory<AlbumBloc>(
        () => AlbumBloc(GetIt.I.get<AlbumRepository>()),
  );
}

void main() {
  // GetIt 초기화
  setupGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AlbumView(),
    );
  }
}