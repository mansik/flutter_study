import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_riverpot_test/data/models/album.dart';
import 'package:mvvm_riverpot_test/data/repositories/album_repository.dart';

// View의 상태를 관리하고 View의 비즈니스 로직을 담당
class AlbumViewModel extends AsyncNotifier<List<Album>> {
  //AsyncNotifier 클래스 이므로 더이상 AlbumRepository 클래스를 주입받을 필요가 없음
  @override
  Future<List<Album>> build() async {
    //초기 데이터가 필요할 경우 이곳에서 데이터를 호출하면 됨
    return await _getAlbumList();
  }

  //앨범 목록을 가져오는 메서드
  Future<List<Album>> _getAlbumList() async {
    try {
      //ref.watch가 아닌 ref.read를 사용하였음.
      //ref.watch는 값이 변경될 시 마다 위젯을 다시 빌드하지만 ref.read는 한번만 실행됨
      final albumRepository = ref.read(albumRepositoryProvider);
      return await albumRepository.getAlbumList();
    } catch (e) {
      return []; // 에러 발생 시 빈 리스트로 초기화
    }
  }

  Future<void> refreshAlbumList() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(_getAlbumList);
  }
}

// AlbumViewModel을 제공하기 위한 provider
final albumViewModelProvider =
    AsyncNotifierProvider<AlbumViewModel, List<Album>>(() => AlbumViewModel());
