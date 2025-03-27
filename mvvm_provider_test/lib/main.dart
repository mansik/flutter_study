import 'package:flutter/material.dart';
import 'package:mvvm_provider_test/data/repositories/album_repository.dart';
import 'package:mvvm_provider_test/data/data_sources/album_data_source.dart';
import 'package:mvvm_provider_test/view_models/album_viewmodel.dart';
import 'package:mvvm_provider_test/views/album_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // AlbumViewModel과 AlbumRepository를 Provider를 통해 제공, 의존성 주입(Dependency Injection, DI)
      home: ChangeNotifierProvider(
        create:
            (_) => AlbumViewModel(
              albumRepository: AlbumRepository(
                albumDataSource: AlbumDataSource(),
              ),
            ),
        child: const AlbumView(),
      ),
    );
  }
}
