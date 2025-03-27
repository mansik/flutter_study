import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_riverpot_test/data/models/album.dart';
import 'package:mvvm_riverpot_test/view_models/album_viewmodel.dart';

// 사용자에게 보여지는 영역
class AlbumView extends ConsumerWidget {
  const AlbumView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final albumState = ref.watch(albumViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Album List'),
        actions: [
          IconButton(
            onPressed: () {
              //새로고침 버튼을 눌렀을 시 리스트를 새로고침함
              ref.read(albumViewModelProvider.notifier).refreshAlbumList();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: albumState.when(
        data: (albums) {
          return _buildAlbumList(albums);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Widget _buildAlbumList(List<Album> albums) {
    return ListView.builder(
      itemCount: albums.length,
      itemBuilder: (context, index) {
        final album = albums[index];
        return ListTile(title: Text('${album.id}: ${album.title}'));
      },
    );
  }
}
