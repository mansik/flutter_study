import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_riverpot_test/data/data_sources/album_data_source.dart';
import 'package:mvvm_riverpot_test/data/models/album.dart';

// 데이터 저장소라는 뜻으로 DataLayer인 DataSource에 접근
class AlbumRepository {
  final AlbumDataSource _albumDataSource;

  AlbumRepository({required AlbumDataSource albumDataSource})
      : _albumDataSource = albumDataSource;

  // "앨범 목록을 얻는다"라는 추상적인 행위를 나타내므로 'fetch'가 아닌 'get'을 사용하였음
  Future<List<Album>> getAlbumList() async {
    return await _albumDataSource.fetchAlbums();
  }
}

// AlbumRepository를 제공하기 위한 provider
final albumRepositoryProvider = Provider<AlbumRepository>((ref) {
  final albumDataSource = ref.watch(albumDataSourceProvider);
  return AlbumRepository(albumDataSource: albumDataSource);
});