import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider_test/models/album_model.dart';

/// 상태를 관리하는 클래스
///
/// ChangeNotifier를 상속받아 상태 관리를 위한 클래스를 만든다.
class AlbumProvider with ChangeNotifier {
  final List<Album> _albums = [];
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';
  static const String _albumsEndpoint = '/albums';

  List<Album> getAlbums() {
    _fetchAlbums();
    return _albums;
  }

  Future<void> _fetchAlbums() async {
    final url = '$_baseUrl$_albumsEndpoint';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) {
      throw Exception('Failed to load albums: status code ${response.statusCode}');
    }

    final List<Album> result =
        jsonDecode(
          response.body,
        ).map<Album>((json) => Album.fromJson(json)).toList();

    _albums.clear();
    _albums.addAll(result);
    notifyListeners(); // UI 업데이트
  }
}
