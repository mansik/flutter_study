import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/models/album_model.dart';
import 'package:provider_test/providers/album_provider.dart';

/// Provider 사용하기
///
/// Consumer<AlbumProvider>: AlbumProvider 상태를 구독하고 UI를 자동 업데이트한다.
class AlbumView extends StatefulWidget {
  const AlbumView({super.key});

  @override
  State<AlbumView> createState() => _AlbumViewState();
}

class _AlbumViewState extends State<AlbumView> {
  late List<Album> _albums;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Albums')),
      body: Consumer<AlbumProvider>( // AlbumProvider 상태를 구독하고 UI를 자동 업데이트한다.
        builder: (context, provider, child) {
          _albums = provider.getAlbums();
          return ListView.builder(
            itemCount: _albums.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: const EdgeInsets.all(16.0),
                child: Text('${_albums[index].id}: ${_albums[index].title}'),
              );
            },
          );
        },
      ),
    );
  }
}
