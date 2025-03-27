import 'package:flutter/material.dart';
import 'package:mvvm_provider_test/view_models/album_viewmodel.dart';
import 'package:provider/provider.dart';

// 사용자에게 보여지는 영역
class AlbumView extends StatefulWidget {
  const AlbumView({Key? key}) : super(key: key);

  @override
  State<AlbumView> createState() => _AlbumViewState();
}

class _AlbumViewState extends State<AlbumView> {
  @override
  void initState() {
    super.initState();
    // 뷰 모델을 사용하여 앨범 목록을 가져옴.
    // listen: false는 상태 변경을 감지하지 않도록 설정하여
    // AlbumViewModel 내부의 상태가 변경되더라도, 해당 AlbumView 위젯은 다시 빌드되지 않습니다.
    // (initState()는 위젯이 생성될 때 한 번만 호출되어야 한다.)
    final viewModel = Provider.of<AlbumViewModel>(context, listen: false);
    viewModel.getAlbumList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Album List')),
      body: Consumer<AlbumViewModel>(
        builder: (context, viewModel, child) {
          // 앨범 목록을 성공적으로 가져온 경우
          return ListView.builder(
            itemCount: viewModel.albums.length,
            itemBuilder: (context, index) {
              final album = viewModel.albums[index];
              return ListTile(title: Text('${album.id}: ${album.title}'));
            },
          );
        },
      ),
    );
  }
}
