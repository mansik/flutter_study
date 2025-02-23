import 'package:cf_tube/models/video_model.dart';
import 'package:flutter/material.dart';

class CustomYoutubePlayer extends StatefulWidget {
  final VideoModel videoModel; // 상위 위젯에서 입력받을 동영상 정보

  const CustomYoutubePlayer({required this.videoModel,super.key});

  @override
  State<CustomYoutubePlayer> createState() => _CustomYoutubePlayerState();
}

class _CustomYoutubePlayerState extends State<CustomYoutubePlayer> {
  @override
  Widget build(BuildContext context) {
    // 임시로 기본 컨테이너 반환
    return Container();
  }
}
