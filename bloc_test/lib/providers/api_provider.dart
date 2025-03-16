import 'dart:convert';

import 'package:bloc_test/models/albums_model.dart';
import 'package:http/http.dart' show Client;

/// AlbumsModel을 사용하여 데이터를 가져옵니다.
class AlbumApiProvider {
  // static 변수로 선언하여 한 번만 생성
  static final Client _client = Client();
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';
  static const String _albumsEndpoint = '/albums';

  // static을 사용하는 경우
  // static Future<Albums> fetchAlbums() async {
  //   return await _fetchAlbums(_client);
  // }

  // static을 사용하지 않는 경우
  // AlbumApiProvider를 사용하는 측에서 Client 객체를 생성해야 합니다.
  Future<Albums> fetchAlbums(Client client) async {
    return await _fetchAlbums(client);
  }

  Future<Albums> _fetchAlbums(Client client) async {
    final url = '$_baseUrl$_albumsEndpoint';
    final uri = Uri.parse(url);

    final response = await client.get(uri);
    // 요청 실패하는 경우
    if (response.statusCode != 200) {
      // 서버에서 발생한 에러
      if (response.statusCode >= 500) {
        throw Exception('Failed to load albums: Server Error');
      }
      // 클라이언트에서 발생한 에러
      else if (response.statusCode >= 400) {
        throw Exception('Failed to load albums: Client Error');
      }
      // 그외 에러
      else {
        throw Exception(
          'Failed to load albums: status code ${response.statusCode}',
        );
      }
    }

    // jsonDecode에 문제가 발생하는 경우
    try {
      final data = jsonDecode(response.body) as List<dynamic>;
      return Albums.fromJson(data);
    } on FormatException catch (e) {
      throw Exception('Invalid data format: $e');
    }
  }
}
