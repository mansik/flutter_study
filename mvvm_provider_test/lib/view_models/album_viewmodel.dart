import 'package:flutter/foundation.dart';
import 'package:mvvm_provider_test/data/models/album.dart';
import 'package:mvvm_provider_test/data/repositories/album_repository.dart';

// View의 상태를 관리하고 View의 비즈니스 로직을 담당
class AlbumViewModel extends ChangeNotifier {
  final AlbumRepository _albumRepository;

  // 뷰 모델이 관리하는 상태
  List<Album> _albums = [];

  List<Album> get albums => _albums;

  // 생성자에서 AlbumRepository를 주입 받음: 의존성 주입(Dependency Injection, DI)
  AlbumViewModel({required AlbumRepository albumRepository})
    : _albumRepository = albumRepository;

  // 앨범 목록을 가져오는 메서드
  Future<void> getAlbumList() async {
    try {
      _albums = await _albumRepository.getAlbumList();
    } catch (e) {
      _albums = []; // 에러 발생 시 빈 리스트로 초기화
    } finally {
      notifyListeners(); // 상태가 변경되었음을 알림
    }
  }
}
