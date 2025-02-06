import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_editor/components/emoticon_sticker.dart';
import 'package:image_editor/components/footer.dart';
import 'package:image_editor/components/main_app_bar.dart';
import 'package:image_editor/model/sticker_model.dart';
import 'package:image_picker/image_picker.dart';

/// 각각 StickerModel을 기반으로 화면에 EmoticonSticker 위젯을 렌더링할 수 있게 구현
///
/// 화면에 붙여줄 스티커들을 Set<StickerModel>로 관리해주면 쉽게 상태 관리가 가능하다.
/// 또한 selectedId 변수를 선언해서 선택된 스티커의 id를 저장한다.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? _image; // 이미지 파일을 저장할 변수
  Set<StickerModel> stickers = {}; // 화면에 추가된 스티커를 저장할 변수
  String? selectedId; // 선택된 스티커의 id를 저장할 변수

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
                onEmoticonTap: onEmotionTap,
              ),
            ),
        ],
      ),
    );
  }

  Widget renderBody() {
    if (_image != null) {
      // Stack 크기의 최대 크기만큼 차지하기
      return Positioned.fill(
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
                (sticker) => Center( // 최초 스티커 선택 시 중앙에 배치
                  child: EmoticonSticker(
                    key: ObjectKey(sticker.id),
                    onTransform: onTransform,
                    imagePath: sticker.imagePath,
                    isSelected: sticker.id == selectedId,
                  ),
                ),
              ),
            ],
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

  void onSaveImage() {
    print('onSaveImage');
  }

  void onDeleteItem() {
    print('onDeleteItem');
  }

  void onEmotionTap(int index) {}

  void onTransform() {}
}
