import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vid_player_test/component/custom_icon_button.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  final XFile video;
  final GestureTapCallback onNewVideoPressed;

  const CustomVideoPlayer(
      {required this.video, required this.onNewVideoPressed, super.key});

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  VideoPlayerController? videoController;
  bool showControls = false;

  // 새로운 동영상이 선택되었을 때 videoController를 새로 생성하도록 한다.
  // didUpdateWidget()는 setState()와 같이 build()가 호출된다.
  // StatefulWidget의 생명주기에서 위젯은 매개변수 값이 변경될 때 폐기되고 새로 생성된다.
  @override
  void didUpdateWidget(covariant CustomVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);

    // 새로 선택한 동영상이 같은 동영상인지 확인
    if (oldWidget.video.path != widget.video.path) {
      initializeController();
    }
  }

  @override
  void initState() {
    super.initState();

    initializeController();
  }

  void initializeController() async {
    final videoController = VideoPlayerController.file(
      File(widget.video.path),
    );

    await videoController.initialize();

    // 컨트롤러의 상태가 변경될 때마다 실행할 함수 등록
    videoController.addListener(videoControllerListener);

    setState(() {
      this.videoController = videoController;
    });

    // 열면 바로 플레이
    this.videoController!.play();
  }

  // 동영상 재생 상태가 변경될 때마다
  // setState()를 실행해서 build()를 재실행한다.
  // slider의 위치정보 갱신됨.
  void videoControllerListener() {
    setState(() {});
  }

  @override
  void dispose() {
    videoController!.removeListener(videoControllerListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (videoController == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          showControls = !showControls;
        });
      },
      child: AspectRatio(
        aspectRatio: videoController!.value.aspectRatio,
        child: Stack(
          children: [
            // 동영상 플레이어
            VideoPlayer(
              videoController!,
            ),
            // 아이콘 버튼이 보일 때 화면을 어둡게 변경
            if (showControls)
              Container(
                color: Colors.black.withAlpha((0.5 * 255).toInt()),
              ),
            // Slider
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    // 현재 재생 위치
                    renderTimeTextFromDuration(videoController!.value.position),
                    Expanded( // Row에 남아 있는 공간을 최대한 차지
                      // Slider
                      child: Slider(
                        value: videoController!.value.position.inSeconds
                            .toDouble(),
                        min: 0,
                        max: videoController!.value.duration.inSeconds
                            .toDouble(),
                        onChanged: (double value) {
                          videoController!.seekTo(
                            Duration(seconds: value.toInt()),
                          );
                        },
                      ),
                    ),
                    // 동영상 총 길이
                    renderTimeTextFromDuration(videoController!.value.duration),
                  ],
                ),
              ),
            ),
            // 새 동영상 아이콘
            if (showControls)
              Align(
                alignment: Alignment.topRight,
                child: CustomIconButton(
                    onPressed: widget.onNewVideoPressed,
                    iconData: Icons.photo_camera_back),
              ),

            // 동영상 재생 관련 아이콘
            if (showControls)
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // 3초 되감기
                    CustomIconButton(
                      onPressed: onReversePressed,
                      iconData: Icons.rotate_left,
                    ),
                    // 재생, 일시정지
                    CustomIconButton(
                      onPressed: onPlayPressed,
                      iconData: videoController!.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                    ),
                    // 3초 앞으로 감기
                    CustomIconButton(
                      onPressed: onForwardPressed,
                      iconData: Icons.rotate_right,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  // 현재 재생 위치와 동영상 길이를 Text로 표시할 위젯
  Widget renderTimeTextFromDuration(Duration duration) {
    return Text(
      '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}',
      style: TextStyle(
        color: Colors.white,
      ),
    );
  }

  // 3초 되감기
  void onReversePressed() {
    final currentPosition = videoController!.value.position;

    Duration position = Duration(); // 0초로 실행 위치 초기화

    if (currentPosition.inSeconds > 3) {
      position = currentPosition - Duration(seconds: 3);
    }

    videoController!.seekTo(position);
  }

  // 3초 앞으로 감기
  void onForwardPressed() {
    final currentPosition = videoController!.value.position;
    final maxPosition = videoController!.value.duration;

    Duration position = maxPosition; // 동영상 길이로 실행 위치 초기화

    if ((maxPosition - Duration(seconds: 3)).inSeconds >
        currentPosition.inSeconds) {
      position = currentPosition + Duration(seconds: 3);
    }

    videoController!.seekTo(position);
  }

// 재생, 일시정지
  void onPlayPressed() {
    if (videoController!.value.isPlaying) {
      videoController!.pause();
    } else {
      videoController!.play();
    }
  }
}
