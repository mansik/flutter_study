import 'package:bloc_test/models/albums_model.dart';
import 'package:bloc_test/repositories/album_repository.dart';
import 'package:rxdart/rxdart.dart';

/// AlbumBloc은 AlbumRepository를 사용하여 데이터를 가져옵니다.
///
/// AlbumRepository를 생성자를 통해 주입받습니다.
/// _albumRepository.fetchAllAlbums()를 호출하여 데이터를 가져옵니다.
class AlbumBloc {
  final AlbumRepository _albumRepository;
  final PublishSubject<Albums> _albumsSubject = PublishSubject<Albums>();

  AlbumBloc(this._albumRepository);

  Stream<Albums> get allAlbumsStream => _albumsSubject.stream;

  Future<void> fetchAllAlbums() async {
    try {
      final albums = await _albumRepository.fetchAllAlbums();
      _albumsSubject.sink.add(albums);
    } catch (e) {
      _albumsSubject.addError(e);
    }
  }

  void dispose() {
    _albumsSubject.close();
  }
}