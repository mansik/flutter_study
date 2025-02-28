import 'package:cf_tube_test/components/custom_youtube_player.dart';
import 'package:cf_tube_test/models/video_model.dart';
import 'package:cf_tube_test/repository/youtube_repository.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder<List<VideoModel>>(
        future: YoutubeRepository.getVideos(),
        builder: (context, snapshot) {
          // 오류가 있을 경우 오류 화면 표시
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          // 로딩 중일 때 로딩 위젯 표시
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          // 동영상 플레이어 리턴
          return RefreshIndicator(
            onRefresh: () async {
              setState(() {}); // 새로 고침 될 때마다 build() 함수를 재실행
            },
            child: ListView(
              physics: BouncingScrollPhysics(), // 아래로 당겨서 스크롤 할 때 튕기는 애니메이션
              children:
                  snapshot.data!
                      .map((e) => CustomYoutubePlayer(videoModel: e))
                      .toList(),
            ),
          );
        },
      ),
    );
  }
}
