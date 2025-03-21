import 'package:get_it/get_it.dart';
import 'package:get_it_test/services/album_service.dart';

// GetIt 라이브러리를 사용하여 AlbumService의 인스턴스를 DI(의존성 주입) 컨테이너에 등록합니다.

// GetIt 인스턴스 생성
final getIt = GetIt.instance;

void setupLocator() {
  // 처음으로 요청할 때 (예: 앱의 다른 부분에서 getIt.get<AlbumService>()를 요청할 때)
  // 비로소 AlbumServiceImplementation 인스턴스를 생성합니다. 이를 지연 초기화라고 합니다.
  // 지연 초기화는 특히 서비스의 설정이 리소스를 많이 소모하거나, 모든 경우에 필요하지 않을 때 더 효율적입니다.
  getIt.registerLazySingleton<AlbumService>(() => AlbumServiceImplementation());
}
