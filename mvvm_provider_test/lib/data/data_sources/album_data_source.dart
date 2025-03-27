import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mvvm_provider_test/data/models/album.dart';

// 외부 데이터 소스 (예: API) 와 직접 통신하는 역할을 담당합니다.
class AlbumDataSource {
  static const String _baseUrl = 'jsonplaceholder.typicode.com';
  static const String _albumsEndpoint = '/albums';

  // 외부 데이터 소스로부터 앨범 목록을 가져오므로 'fetch'를 사용하였음
  Future<List<Album>> fetchAlbums() async {
    final albumUrl = Uri.https(_baseUrl, _albumsEndpoint);
    try {
      final response = await http.get(albumUrl);

      if (response.statusCode != HttpStatus.ok) {
        throw Exception(
          'Failed to load albums: status code ${response.statusCode}',
        );
      }

      final responseBody = response.body;
      if (responseBody.isEmpty) {
        throw Exception('Response body is empty');
      }

      final List<Album> result =
          (jsonDecode(responseBody) as List)
              .map<Album>((json) => Album.fromJson(json))
              .toList();
      return result;
    } catch (e) {
      throw Exception('Failed to load albums: $e');
    }
  }
}
