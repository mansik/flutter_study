import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get_it_test/models/album_model.dart';

abstract class AlbumService {
  Future<List<Album>> fetchAlbums();
}

class AlbumServiceImplementation implements AlbumService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';
  static const String _albumsEndpoint = '/albums';

  @override
  Future<List<Album>> fetchAlbums() async {
    final url = '$_baseUrl$_albumsEndpoint';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to load albums: status code ${response.statusCode}',
      );
    }

    final responseBody = response.body;
    if (responseBody.isEmpty) {
      throw Exception('Response body is empty');
    }

    final List<Album> result =
        jsonDecode(
          responseBody,
        ).map<Album>((json) => Album.fromJson(json)).toList();
    return result;
  }
}
