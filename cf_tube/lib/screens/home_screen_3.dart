import 'package:cf_tube/models/video_model.dart';
import 'package:cf_tube/repository/youtube_repository.dart';
import 'package:flutter/material.dart';
import 'package:cf_tube/components/custom_youtube_player.dart';

/// ListView로 동영상 리스트를 보여주는 화면 + 새로 고침 기능(화면을 아래로 당기면 새로 고침)
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('CFTube'),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<List<VideoModel>>(
        future: YoutubeRepository.getVideos(),
        builder: (context, snapshot) {
          // 오류가 있을 경우 오류 화면 표시
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          // 로딩 중일 때 로딩 위젯 보여주기
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          // ListView로 동영상을 보여줌
          return RefreshIndicator( // 새로 고침 기능이 있는 위젯
            onRefresh: () async {
              setState(() {});
            },
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: snapshot.data!
                  .map((e) => CustomYoutubePlayer(videoModel: e))
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}
