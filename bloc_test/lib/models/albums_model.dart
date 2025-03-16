import 'package:bloc_test/models/album_model.dart';

class Albums {
  late List<Album> albums;

  Albums({required this.albums});

  Albums.fromJson(List<dynamic> json)
      : albums = json.map((item) => Album.fromJson(item)).toList();
}
