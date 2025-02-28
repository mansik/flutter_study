import 'package:cf_tube_test/models/video_model.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CustomYoutubePlayer extends StatefulWidget {
  final VideoModel videoModel; // 상위 위젯에서 입력받을 동영상 정보

  const CustomYoutubePlayer({required this.videoModel, super.key});

  @override
  State<CustomYoutubePlayer> createState() => _CustomYoutubePlayerState();
}

class _CustomYoutubePlayerState extends State<CustomYoutubePlayer> {
  late YoutubePlayerController? _controller;

  /// late 키워드
  ///
  /// 널이 될 수 없는(non-nullable) 변수가 선언 시점에 초기화되지 않더라도,
  /// 사용되기 전에 반드시 초기화될 것임을 컴파일러에게 약속하는 것입니다.
  /// 즉, "이 변수는 나중에 초기화될 것이니, 사용하기 전에 값이 있을 거라고 믿어줘"
  ///
  /// - 선언 방법(late 키워드 사용)
  /// ```dart
  /// late String myString;
  /// ```
  /// - 초기화 방법(2 가지)
  /// 1. Initializing in initState()
  /// ```dart
  /// @override
  /// void initState() {
  ///   super.initState();
  ///   myString = "initState에서 가져온 데이터"; // 여기서 초기화
  /// }
  ///
  /// 2. Lazy Initialization(지연 초기화)
  /// ```dart
  /// myString = "안녕하세요!";
  /// ```

  @override
  void initState() {
    super.initState();

    // 1. YoutubePlayerController 생성, 초기화
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoModel.id,
      flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 2. YoutubePlayer 생성
        YoutubePlayer(
          controller: _controller!,
          showVideoProgressIndicator: true,
        ),
        const SizedBox(height: 16.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            widget.videoModel.title,
            style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }

  @override
  void dispose() {
    // 3. YoutubePlayerController 해제
    _controller?.dispose();
    super.dispose();
  }
}
