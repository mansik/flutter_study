import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vid_player/component/custom_video_player.dart';

/// implement new video button
///
/// 영상 선택 버튼의 기능을 정의,
/// HomeScreen에 이미 정의를 해뒀기 때문에 단순히 onNewVideoPressed() 함수를 전달하는 방식으로 작업한다.
///
/// 1. HomeScreen에서 CustomVideoPlayer 위젯 생성시 onNewVideoPressed 함수를 매개변수로 준다.(6.1~)
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
      body: video == null ? renderEmpty() : renderVideo(),
    );
  }

  // 동영상 선택 전 보여줄 위젯
  Widget renderEmpty() {
    return Container(
      width: MediaQuery.of(context).size.width, // 너비를 MaterialApp 위젯의 크기로 늘려주기
      decoration: getBoxDecoration(), // 배경색 gradient 적용
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 30.0, // 아래 SizedBox 대신 사용 가능
        children: [
          _Logo(
            onTap: onNewVideoPressed, // 4.1 로고를 탭하면 실행하는 함수
          ), // 로고 이미지
          // SizedBox(height: 30.0), // flutter 3.27에서 row, column에서 spacing 사용
          _AppName(), // 앱이름
        ],
      ),
    );
  }

  // 4.2 imagePicker를 통해서 동영상을 선택
  void onNewVideoPressed() async {
    final video = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );

    if (video != null) {
      setState(() {
        this.video = video;
      });
    }
  }

  // Container 위젯의 배경색 gradient 적용
  BoxDecoration getBoxDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF2A3A7C),
          Color(0xFF000118),
        ],
      ),
    );
  }

  // 동영상 선택 후 보여줄 위젯
  Widget renderVideo() {
    return Center(
      child: CustomVideoPlayer(
        video: video!,
        onNewVideoPressed: onNewVideoPressed, // 6.1 onNewVideoPressed 함수를 전달
      ),
    );
  }
}

/// widget to display the logo
class _Logo extends StatelessWidget {
  final GestureTapCallback onTap; // 탭했을 때 실행할 함수

  const _Logo({required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // 4.3 상위 위젯으로부터 탭 콜백 받기
      child: Image.asset(
        'assets/images/logo.png',
      ),
    );
  }
}

/// widget to display the app title
class _AppName extends StatelessWidget {
  const _AppName({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: 30.0,
      fontWeight: FontWeight.w300,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 10.0,
      children: [
        Text(
          'VIDEO',
          style: textStyle,
        ),
        Text(
          'PLAYER',
          style: textStyle.copyWith(
            // textStyle에서 두께만 700으로 변경
            fontWeight: FontWeight.w700,
          ),
        )
      ],
    );
  }
}
