import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vid_player/component/custom_icon_button.dart';
import 'package:video_player/video_player.dart';

/// add time stamp
///
/// 현재 실행 중인 위치와 동영상 길이를 Slider의 좌우에 배치
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

  // 10.1 동영상을 조작하는 아이콘을 보일지 여부
  bool showControls = false;

  // 9.1 didUpdateWidget() 함수를 사용해서 새로운 동영상이 선택되었을 때 videoController를
  // 새로 생성하도록 한다.
  // StatefulWidget의 생명주기에서 위젯은 매개변수 값이 변경될 때 폐기되고 새로 생성된다.
  @override
  void didUpdateWidget(covariant CustomVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);

    // 새로 선택한 동영상이 같은 동영상인지 확인
    if (oldWidget.video.path != widget.video.path) {
      initializeController();
    }
  }

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
    return GestureDetector(
      // 10.2 화면 전체의 탭을 인식하기 위해서 사용
      onTap: () {
        setState(() {
          showControls = !showControls;
        });
      },
      child: AspectRatio(
        aspectRatio: videoController!.value.aspectRatio, // 16/9,...
        // 3.1 Stack 위젯을 사용해서 VideoPlayer 위젯 위에 Slider 위젯을 올림
        child: Stack(
          children: [
            VideoPlayer(
              videoController!,
            ),
            // 10.3 아이콘 버튼을 보일 때 화면을 어둡게 변경
            if (showControls)
              Container(
                color: Colors.black.withAlpha((0.5 * 255).toInt()),
              ),
            Positioned(
              // 3.2 child 위젯의 위치를 정할 수 있는 위젯
              left: 0,
              // right: 0 과 함께 사용하여 좌우측 Slider 위젯을 끝까지 늘림
              right: 0,
              bottom: 0,
              // Stack 위젯의 가장 아래에(아래에서 0픽셀 떨어진 위치) Slider 위젯을 위치시킴
              // 11.1 Slider 위젯 양쪽에 현재 재생 위치와 동영상 길이를 배치하기 위해서 Padding, Row 위젯 사용
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    // 11.2 현재 재생 위치
                    renderTimeTextFromDuration(videoController!.value.position),
                    Expanded(
                      // 11.2
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
                        value: videoController!.value.position.inSeconds
                            .toDouble(),
                        min: 0,
                        max: videoController!.value.duration.inSeconds
                            .toDouble(), // max값은 현재 동영상의 전체 재생 길이를 초 단위로 표현
                      ),
                    ),
                    // 11.3 동영상 총 길이
                    renderTimeTextFromDuration(videoController!.value.duration),
                  ],
                ),
              ),
            ),
            // 5.1 새 동영상 아이콘: 오른쪽 위에 위치
            if (showControls) //10.4 showControls가 true일 때만 아이콘 보여주기
              Align(
                alignment: Alignment.topRight,
                child: CustomIconButton(
                    onPressed: widget.onNewVideoPressed,
                    // 8.2 새로운 동영상을 선택할 함수 실행
                    iconData: Icons.photo_camera_back),
              ),
            // 5.2 동영상 재생 관련 아이콘: 가운데 위치
            if (showControls) // 10.5 showControls가 true일 때만 아이콘 보여주기
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
      ),
    );
  }

  // 11.4 현재 재생 위치와 동영상 길이를 Text로 표시할 위젯
  Widget renderTimeTextFromDuration(Duration duration) {
    return Text(
      '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}',
      style: TextStyle(
        color: Colors.white,
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
