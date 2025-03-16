import 'package:bloc_test/bloc/album_bloc.dart';
import 'package:bloc_test/models/albums_model.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

/// AlbumBloc을 사용하여 데이터를 가져옵니다.
class AlbumView extends StatefulWidget {
  const AlbumView({super.key});

  @override
  State<AlbumView> createState() => _AlbumViewState();
}

class _AlbumViewState extends State<AlbumView> {
  late final AlbumBloc _albumBloc;

  @override
  void initState() {
    super.initState();
    _albumBloc = GetIt.I<AlbumBloc>();
    _albumBloc.fetchAllAlbums();
  }

  @override
  void dispose() {
    _albumBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Albums')),
      body: StreamBuilder<Albums>(
        stream: _albumBloc.allAlbumsStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final albumList = snapshot.data!;
            return ListView.builder(
              itemCount: albumList.albums.length,
              itemBuilder: (context, index) {
                final album = albumList.albums[index];
                return ListTile(
                  title: Text('Album Title: ${album.title}'),
                  subtitle: Text('Album ID: ${album.id}'),
                  contentPadding: const EdgeInsets.all(10),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            );
          }
        },
      ),
    );
  }
}