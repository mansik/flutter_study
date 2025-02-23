import 'package:cf_tube/models/video_model.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CustomYoutubePlayer extends StatefulWidget {
  final VideoModel videoModel; // 상위 위젯에서 입력받을 동영상 정보

  const CustomYoutubePlayer({required this.videoModel, super.key});

  @override
  State<CustomYoutubePlayer> createState() => _CustomYoutubePlayerState();
}

class _CustomYoutubePlayerState extends State<CustomYoutubePlayer> {
  YoutubePlayerController? controller;

  @override
  void initState() {
    super.initState();

    // 1. YoutubePlayerController 생성
    controller = YoutubePlayerController(
      initialVideoId: widget.videoModel.id,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 2. YoutubePlayer 생성
        YoutubePlayer(
          controller: controller!,
          showVideoProgressIndicator: true,
        ),
        const SizedBox(height: 16.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            widget.videoModel.title,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }

  @override
  void dispose() {
    // 3. YoutubePlayerController 해제
    controller!.dispose();

    super.dispose();
  }
}
