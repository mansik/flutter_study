import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vid_player/component/custom_icon_button.dart';
import 'package:video_player/video_player.dart';

/// implement new video button
///
/// 영상 선택 버튼의 기능을 정의,
/// HomeScreen에 이미 정의를 해뒀기 때문에 단순히 onNewVideoPressed() 함수를 전달하는 방식으로 작업한다.
/// 1. HomeScreen에서 CustomVideoPlayer 위젯 생성시 onNewVideoPressed 함수를 매개변수로 준다.(6.1~):home_screen_6.dart
/// 2. onNewVideoPresse 함수를 받을 수 있도록 생성자 구현(8.1~)
/// 3. 새 동영상 아이콘을 눌렀을 때 실행할 함수 연결(8.1~)
class CustomVideoPlayer extends StatefulWidget {
  final XFile video; // 선택한 동영상을 저장
  final GestureTapCallback onNewVideoPressed; // 8.1 새로운 동영상을 선택하면 실행되는 함수

  const CustomVideoPlayer(
      {required this.video, required this.onNewVideoPressed, super.key});

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

    // 7.1 컨트롤러의 속성이 변경될 때마다 실행할 함수 등록
    videoController.addListener(videoControllerListener);

    // 2.3.3 초기화 후 클래스 변수에 저장
    setState(() {
      this.videoController = videoController;
    });
  }

  // 7.2 동영상의 재생 상태가 변경될 때마다
  // setState()를 실행해서 build()를 재실행한다.
  void videoControllerListener() {
    setState(() {});
  }

  // 7.3 listener 삭제
  @override
  void dispose() {
    videoController!.removeListener(videoControllerListener);
    super.dispose();
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
            // 3.3 Slider 위젯
            child: Slider(
              // 4.1 슬라이더가 이동할 때마다 실행할 함수
              onChanged: (double val) {
                // seekTo: 동영상의 재생위치를 특정 위치로 이동
                videoController!.seekTo(
                  Duration(seconds: val.toInt()),
                );
              },
              // 4.2 현재 재생 위치를 초 단위로 표현
              value: videoController!.value.position.inSeconds.toDouble(),
              min: 0,
              max: videoController!.value.duration.inSeconds
                  .toDouble(), // max값은 현재 동영상의 전체 재생 길이를 초 단위로 표현
            ),
          ),
          // 5.1 새 동영상 아이콘: 오른쪽 위에 위치
          Align(
            alignment: Alignment.topRight,
            child: CustomIconButton(
                onPressed: widget.onNewVideoPressed, // 8.2 새로운 동영상을 선택할 함수 실행
                iconData: Icons.photo_camera_back),
          ),
          // 5.2 동영상 재생 관련 아이콘: 가운데 위치
          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // 되감기 버튼
                CustomIconButton(
                  onPressed: onReversePressed,
                  iconData: Icons.rotate_left,
                ),
                // 재생 버튼
                CustomIconButton(
                  onPressed: onPlayPressed,
                  iconData: videoController!.value.isPlaying
                      ? Icons.pause
                      : Icons.play_arrow,
                ),
                // 앞으로 감기 버튼
                CustomIconButton(
                  onPressed: onForwardPressed,
                  iconData: Icons.rotate_right,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // 6.1 3초 되감기
  void onReversePressed() {
    final currentPosition = videoController!.value.position;

    Duration position = Duration(); // 0초로 실행 위치 초기화

    if (currentPosition.inSeconds > 3) {
      position = currentPosition - Duration(seconds: 3);
    }

    videoController!.seekTo(position);
  }

  // 6.2 재생, 일시정지
  void onPlayPressed() {
    if (videoController!.value.isPlaying) {
      videoController!.pause();
    } else {
      videoController!.play();
    }
  }

  // 6.3 3초 앞으로 감기
  void onForwardPressed() {
    final maxPosition = videoController!.value.duration; // 동영상 길이
    final currentPosition = videoController!.value.position;

    Duration position = maxPosition; // 동영상 길이로 실행 위치 초기화

    if ((maxPosition - Duration(seconds: 3)).inSeconds >
        currentPosition.inSeconds) {
      position = currentPosition + Duration(seconds: 3);
    }

    videoController!.seekTo(position);
  }
}
