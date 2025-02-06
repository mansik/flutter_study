/// 여러개의 스티커를 한꺼번에 관리, 각 스티커에 필요한 정보를 저장
///
/// Map을 사용해도 되나, Map을 사용할 경우 데이터 구조가 강제되지 않아서
/// 상태 관리를 할 때는 꼭 클래스를 사용해서 데이터를 구조화하는게 좋다.
class StickerModel {
  final String id;
  final String imagePath;

  StickerModel({required this.id, required this.imagePath});

  /// 하나의 인스턴스가 다른 인스턴스와 같은지 비교
  @override
  bool operator ==(Object other) {
    return (other as StickerModel).id == id;
  }

  /// Set에서 중복 여부를 결정하는 속성
  /// ID 값이 같으면 Set 안에서 같은 인스턴스로 인식
  @override
  int get hashCode => id.hashCode;
}
