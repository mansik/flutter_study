import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_editor_test/components/emoticon_sticker.dart';
import 'package:image_editor_test/components/footer.dart';
import 'package:image_editor_test/components/main_app_bar.dart';
import 'package:image_editor_test/models/sticker_model.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? _image; // 이미지 파일을 저장할 변수
  Set<StickerModel> _stickerSet = {}; // 화면에 추가된 스티커를 저장할 Set
  String? _selectedStickerId; // 선택된 스티커의 ID를 저장할 변수
  GlobalKey imageKey =
      GlobalKey(); // 이미지로 전환할 위젯에 입력해줄 값, 애플리케이션 전체에서 위젯을 고유하게 식별하는데 사용되는 키

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand, // 자식들이 최대 크기의 공간을 차지
        children: [
          renderBody(),
          // appBar
          Positioned(
            top: 0, // 맨 위에 AppBar 위치
            left: 0, // 좌우 최대
            right: 0,
            child: MainAppBar(
                onPickImage: onPickImage,
                onSaveImage: onSaveImage,
                onDeleteItem: onDeleteItem),
          ),
          // footer
          if (_image != null)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Footer(
                onEmoticonTap: onEmoticonTap,
              ),
            ),
        ],
      ),
    );
  }

  Widget renderBody() {
    if (_image != null) {
      return RepaintBoundary(
        // RepaintBoundary 위젯을 사용해서 위젯을 이미지로 추출
        key: imageKey,
        child: Positioned.fill(
          child: InteractiveViewer(
            child: Stack(
              fit: StackFit.expand, // 자식들의 크기를 최대로 늘려주기
              children: [
                Image.file(
                  File(_image!.path),
                  fit: BoxFit.cover, // 이미지가 부모 위젯(Image)의 크기를 최대로 차지하도록 하기
                ),
                // ..._stickerSet.map()은 여러개의 스티커를 children 리스트에 나열한다.
                ..._stickerSet.map(
                  (sticker) => Center(
                    child: EmoticonSticker(
                      key: ObjectKey(sticker.id),
                      onTransform: () {
                        onTransform(sticker.id);
                      },
                      imagePath: sticker.imagePath,
                      isSelected: sticker.id == _selectedStickerId,
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
          style: TextButton.styleFrom(backgroundColor: Colors.grey),
          onPressed: onPickImage,
          child: Text(
            'select image',
          ),
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

  /// RepaintBoundary 위젯을 사용해서 위젯을 이미지로 추출한 후 갤러리에 저장
  /// image_gallery_saver_plus 패키지의 saveImage 함수를 사용해서 이미지를 갤러리에 저장
  void onSaveImage() async {
    // 실제 화면에 렌더링된 RepaintBoundary 위젯을 찾음
    RenderRepaintBoundary boundary =
        imageKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

    ui.Image image = await boundary.toImage(); // 이미지로 변환, ui = dart:ui 패키지
    ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png); // 이미지를 바이트 데이터로 변환
    Uint8List pngBytes =
        byteData!.buffer.asUint8List(); // 바이트 데이터를 Uint8List로 변환, 8비트 정수형으로 변환

    /// image_gallery_saver_plus 패키지의 saveImage 함수를 사용해서 이미지를 갤러리에 저장
    await ImageGallerySaverPlus.saveImage(pngBytes, quality: 100);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('image saved!'),
      ),
    );
  }

  void onDeleteItem() async {
    setState(() {
      _stickerSet.removeWhere((sticker) => sticker.id == _selectedStickerId);
      _selectedStickerId = null;
    });
  }

  /// footer 위젯에서 각 스티커를 누를 때마다 _stickerSet 변수를 업데이트
  void onEmoticonTap(int index) async {
    setState(() {
      // 기존 _stickerSet에 새로운 스티커를 추가
      _stickerSet = {
        ..._stickerSet,
        StickerModel(
          id: Uuid().v4(),
          imagePath: 'assets/images/emoticon_$index.png',
        ),
      };
    });
  }

  /// 스티커가 변경될 때마다 변형 중인 스티커를 현재 선택한 스티커로 지정
  void onTransform(String id) {
    setState(() {
      _selectedStickerId = id;
    });
  }
}
