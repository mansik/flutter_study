import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

/// 동영상을 선택할 때 사용할 image_picker 플러그인은
/// 이미지나 동영상을 선택했을 때 XFile이라는 클래스 형태로 선택된 값을 반환한다.
class _HomeScreenState extends State<HomeScreen> {
  XFile? video; // 이미지나 동영상을 선택했을 때 저장할 변수(image_picker plugin)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: video == null ? renderEmpty(): renderVideo(),
    );
  }

  // 동영상 선택 전 보여줄 위젯
  Widget renderEmpty(){
    return Container();
  }

  // 동영상 선택 후 보여줄 위젯
  Widget renderVideo(){
    return Container();
  }
}

