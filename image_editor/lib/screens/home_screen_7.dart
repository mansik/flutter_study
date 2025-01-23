import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_editor/components/emoticon_sticker.dart';
import 'package:image_editor/components/footer.dart';
import 'package:image_editor/components/main_app_bar.dart';
import 'package:image_editor/model/sticker_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

/// implement image saving
///
/// RepaintBoundary 위젯을 사용해서 위젯을 이미지로 추출한 후 갤러리에 저장
///
/// RepaintBoundary 위젯은 자식 위젯을 이미지로 추출하는 기능이 있다. 이 기능을 사용하려면
/// RepaintBoundary에 key 매개변수를 입력해주고 이미지를 추출할 때 이 값을 사용한다.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? _image; // 이미지 파일을 저장할 변수
  Set<StickerModel> stickers = {}; // 화면에 추가된 스티커를 저장할 변수
  String? selectedId; // 선택된 스티커의 id를 저장할 변수
  GlobalKey imageKey =
  GlobalKey(); // 이미지로 전환할 위젯에 입력해줄 값, 애플리케이션 전체에서 위젯을 고유하게 식별하는 데 사용되는 특별한 키

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand, // 자식들이 최대한의 크기의 공간을 차지하도록 함. <-> StackFit.loose
        children: [
          renderBody(), // body
          // AppBar
          Positioned(
            top: 0, // 맨 위에 AppBar 위치 시키기
            left: 0, // 좌우 최대 크기
            right: 0,
            child: MainAppBar(
              onPickImage: onPickImage,
              onSaveImage: onSaveImage,
              onDeleteItem: onDeleteItem,
            ),
          ),
          // footer
          if (_image != null)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0, // 맨 아래에 Footer 위치 시키기
              child: Footer(
                onEmotionTap: onEmotionTap,
              ),
            ),
        ],
      ),
    );
  }

  Widget renderBody() {
    if (_image != null) {
      // Stack 크기의 최대 크기만큼 차지하기
      return RepaintBoundary(
        key: imageKey, // 위젯을 이미지로 저장하는 데 사용
        child: Positioned.fill(
          // 위젯 확대 및 좌우 이동을 가능하게 하는 위젯
          child: InteractiveViewer(
            child: Stack(
              fit: StackFit.expand, // 크기를 최대로 늘려주기
              children: [
                Image.file(
                  File(_image!.path),
                  fit: BoxFit.cover, // 이미지가 부모 위젯 크기 최대를 차지하도록 하기
                ),
                // ...stickers.map()은 여러개의 스티커를 children 리스트에 나열한다.
                ...stickers.map(
                      (sticker) =>
                      Center(
                        // 최초 스티커 선택 시 중앙에 배치
                        child: EmoticonSticker(
                          key: ObjectKey(sticker.id),
                          onTransform: () {
                            onTransform(sticker.id);
                          },
                          imagePath: sticker.imagePath,
                          isSelected: sticker.id == selectedId,
                        ),
                      ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Center(
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.grey,
          ),
          onPressed: onPickImage,
          child: Text('select image'),
        ),
      );
    }
  }

  void onPickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    setState(() {
      this._image = image;
    });
  }

  void onSaveImage() async {
    // 실제 화면에 렌더링된 RepatintBoundary 위젯을 찾음
    RenderRepaintBoundary boundary = imageKey.currentContext!
        .findRenderObject() as RenderRepaintBoundary;

    // 바운더리를 이미지로 변경
    ui.Image image = await boundary.toImage(); // dart:ui 패키지의 Image 클래스
    // byte data 형태로 형태 변경, 반환되는 확장자는 png로 지정
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    // Uint8List 형태로 형태 변경, 8비트 정수형으로 변환, image_gallery_saver_plus 패키지의 saveImage 함수에 전달
    Uint8List pngBytes = byteData!.buffer.asUint8List();
  }

  void onDeleteItem() async {
    setState(() {
      // 현재 선택되어 있는 스티커 삭제 후 Set로 변환
      stickers = stickers.where((sticker) => sticker.id != selectedId).toSet();
    });
  }

  void onEmotionTap(int index) async {
    setState(() {
      stickers = {
        ...stickers,
        StickerModel(
          id: Uuid().v4(), // 스티커의 고유 ID, 절대로 겹치지 않는 String 값 생성
          imagePath: 'assets/images/emoticon_$index.png',
        ),
      };
    });
  }

  void onTransform(String id) {
    // 스티커가 변경될 때마다 변형 중인 스티커를 현재 선택한 스티커로 지정
    setState(() {
      selectedId = id;
    });
  }
}
