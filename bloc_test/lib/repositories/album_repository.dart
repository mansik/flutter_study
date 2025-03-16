import 'package:bloc_test/models/albums_model.dart';
import 'package:bloc_test/providers/api_provider.dart';
import 'package:http/http.dart' show Client;

/// AlbumApiProvider를 사용하여 데이터를 가져옵니다.
class AlbumRepository {
  final AlbumApiProvider _apiProvider;

  AlbumRepository(this._apiProvider);

  Future<Albums> fetchAllAlbums() async {
    // static을 사용하지 않기 때문에 Client를 넘겨주어야 합니다.
    final client = Client();
    try {
      return await _apiProvider.fetchAlbums(client);
    } finally {
      client.close();
    }
  }
}
