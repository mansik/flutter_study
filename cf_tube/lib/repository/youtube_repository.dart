import 'package:cf_tube/consts/api.dart';
import 'package:cf_tube/models/video_model.dart';
import 'package:dio/dio.dart';

/// dio 패키지를 사용해서 HTTP 요청을 한다.
///
/// HTTP 요청에 대한 응답을 받아서 그 결과값을 List<VideoModel>로 전환한다.
/// items의 리스트값 중에 videoId나 title값이 존재하지 않는 경우를 제외시키고 나머지를 List<VideoModel>로 전환한다.
class YoutubeRepository {
  static Future<List<VideoModel>> getVideos() async {
    final dio = Dio();
    // GET 메서드 보내기
    final response = await dio.get(
      YOUTUBE_API_BASE_URL,
      queryParameters: {
        'channelId': CF_CHANNEL_ID,
        'maxResults': 10,
        'key': API_KEY,
        'part': 'snippet',
        'order': 'date',
      },
    );

    // videoId와 title이 null이 아닌 값들만 필터링
    final listWithData = response.data['items'].where(
      (item) =>
          item?['id']?['videoId'] != null && item?['snippet']?['title'] != null,
    );

    // List<VideoModel>로 변환
    return listWithData
        .map<VideoModel>(
          (item) => VideoModel(
            id: item['id']['videoId'],
            title: item['snippet']['title'],
          ),
        )
        .toList();
  }
}
