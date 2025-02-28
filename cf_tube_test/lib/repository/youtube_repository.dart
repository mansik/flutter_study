import 'package:cf_tube_test/consts/api.dart';
import 'package:cf_tube_test/models/video_model.dart';
import 'package:dio/dio.dart';

class YoutubeRepository {
  static Future<List<VideoModel>> getVideos() async {
    // GET 메서드 보내기
    final response = await Dio().get(
      YOUTUBE_API_BASE_URL,
      queryParameters: {
        'channelId': CF_CHANNEL_ID,
        'maxResults': 10,
        'key': YOUTUBE_API_KEY,
        'part': 'snippet',
        'order': 'date',
      },
    );

    /// videoId와 title이 있는 값들만 필터링
    final listWithData = response.data['items'].where(
      (item) =>
          item?['id']?['videoId'] != null && item?['snippet']?['title'] != null,
    );

    /// List<VideoModel>로 변환
    return listWithData
        .map(
          (item) => VideoModel(
            id: item['id']['videoId'],
            title: item['snippet']['title'],
          ),
        )
        .toList();
  }
}
