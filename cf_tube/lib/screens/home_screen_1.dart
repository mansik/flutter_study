import 'package:cf_tube/models/video_model.dart';
import 'package:flutter/material.dart';
import 'package:cf_tube/components/custom_youtube_player.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomYoutubePlayer(
        videoModel: VideoModel(
          id: '3Ck42C2ZCb8', // Url의 끝부분
          title: '다트 언어 기본기 1시간만에 끝내기',
        ),
      ),
    );
  }
}
