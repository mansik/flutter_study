import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

/// link Slider widget with video playback(비디오 재생과 연결)
///
/// Slider 위젯을 스크롤하면 동영상이 해당되는 위치로 이동하기
class CustomVideoPlayer extends StatefulWidget {
  final XFile video; // 선택한 동영상을 저장

  const CustomVideoPlayer({required this.video, super.key});

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  // 2.1 동영상을 조작하는 컨트롤러
  VideoPlayerController? videoController;

  // 2.2 컨트롤러 초기화
  // VideoPlayerController는
  // State가 생성되는 순간 한 번만 생성되어야 하므로 initState() 함수에서 초기화
  @override
  void initState() {
    super.initState();

    initializeController(); // 2.2 컨트롤러 초기화
  }

  // 2.3 선택한 동영상으로 컨트롤러 초기화
  initializeController() async {
    // 2.3.1 파일로부터 VideoPlayerController 생성
    final videoController = VideoPlayerController.file(
      File(widget.video.path),
    );

    // 2.3.2 생성 후 VideoPlayerController 초기화
    await videoController.initialize();

    // 2.3.3 초기화 후 클래스 변수에 저장
    setState(() {
      this.videoController = videoController;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 2.4 동영상 컨트롤러가 준비 중일 때 로딩 표시
    if (videoController == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    // 2.5 동영상 비율에 따른 화면 렌더링
    // AspectRatio(종횡비): child 매개변수에 입력되는 위젯의 비율을 정할 수 있는 위젯
    // videoController!.value.aspectRatio: 입력된 동영상의 비율
    return AspectRatio(
      aspectRatio: videoController!.value.aspectRatio, // 16/9,...
      // 3.1 Stack 위젯을 사용해서 VideoPlayer 위젯 위에 Slider 위젯을 올림
      child: Stack(
        children: [
          VideoPlayer(
            videoController!,
          ),
          Positioned(
            // 3.2 child 위젯의 위치를 정할 수 있는 위젯
            left: 0, // right: 0 과 함께 사용하여 좌우측 Slider 위젯을 끝까지 늘림
            right: 0,
            bottom: 0, // Stack 위젯의 가장 아래에(아래에서 0픽셀 떨어진 위치) Slider 위젯을 위치시킴
            child: Slider(
              // 3.3 Slider 위젯
              onChanged: (double val) {},
              value: 0,
              min: 0,
              max: videoController!.value.duration.inSeconds
                  .toDouble(), // max값은 현재 동영상의 전체 재생 길이를 초 단위로 변환
            ),
          ),
        ],
      ),
    );
  }
}
