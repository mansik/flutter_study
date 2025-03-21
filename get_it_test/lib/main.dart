import 'package:flutter/material.dart';
import 'package:get_it_test/locators/locator.dart';
import 'package:get_it_test/models/album_model.dart';
import 'package:get_it_test/services/album_service.dart';

void main() {
  setupLocator(); // 1. getIt 초기화
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'GetIt Test', home: const MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // 2.  GetIt을 사용하여 AlbumService 인스턴스를 가져온다.
  final AlbumService _albumService = getIt<AlbumService>();

  late Future<List<Album>> _albumsFuture;

  @override
  void initState() {
    super.initState();
    // 3. getit 사용
    _albumsFuture = _albumService.fetchAlbums();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GetIt Test')),
      body: FutureBuilder(
        future: _albumsFuture,
        // future: _albumService.fetchAlbums(); // _albumsFuture를 사용하여 데이터 가져오기를 분리
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // 데이터 로딩 중
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // 에러 발생
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // 데이터가 없거나 비어있음
            return const Center(child: Text('No data available.'));
          } else {
            // 데이터 있음
            final albums = snapshot.data!;
            return ListView.builder(
              itemCount: albums.length,
              itemBuilder: (context, index) {
                final album = albums[index];
                return ListTile(
                  title: Text('${album.id}: ${album.title}'),
                  // subtitle: Text('ID: ${album.id}'),
                );

                // Container를 사용하는 대신에 ListTile을 사용하여, 코드를 명료하게 합니다.
                // return Container(
                //   padding: const EdgeInsets.all(16.0),
                //   child: Text('${albums[index].id}:${albums[index].title}'),
                // );
              },
            );
          }
        },
      ),
    );
  }
}
