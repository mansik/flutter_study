# cf_tube_test

A new Flutter project.

use youtube api

유튜브 API를 이용해서 코드팩토리 채널의 동영상을 가져올 수 있는 앱

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Features

- 유튜브 API를 이용해서 특정 채널의 동영상을 불러올 수 있다.
- 새로고침으로 동영상 리스트를 초기화할 수 있다.
- 동영상을 눌러서 실행할 수 있다.

유튜브 API로 동영상 정보 요청 -> JSON 데이터를 Dart 클래스 인스턴스로 변환 -> 각 인스턴스를 위젯으로 매핑 후 리스트로 렌더링

## Usage

- 리스트를 아래로 당겨서 최신 코드팩토리 동영상 리스트를 가져올 수 있다.
- 동영상을 눌러서 실행할 수 있다.

## Skill

REST API, JSON, youtube API

Dio, ListView, youtebe player

## Plugin(pub.dev)

- youtube_player_flutter: ^9.1.1
- dio: ^5.8.0+1 : HTTP 요청을 위한 패키지

## prior knowledge

#### HTTP 요청

- HTTP: request(요청), response(응답)
- HTTP 통신: GET, POST, PUT, DELETE등 메서드
    - GET 메서드: 서버에 데이터를 요청, 쿼리 매개변수를 사용, body 사용안함
    - POST 메서드: 서버에 데이터를 추가, body를 자주 사용
    - PUT 메서드: 서버에 데이터를 수정, 쿼리 매개변수와 body 사용
    - DELETE 메서드: 서버에 데이터를 삭제, 쿼리 매개변수와 body 사용
- <client> -> request -> <server>
- <client> <- response <- <server>
- URL: http://www.domwin.com:1234/path/to/resource?a=b&x=y
    - http or https: protocol
    - www.domwin.com: host
    - 1234: port
    - path/to/resource:resource path
    - a=b&x=y: query
- HTTP 기반 API 종류
    - REST API: HTTP의 GET, POST, PUT, DELETE등의 메서드를 사용해서 통신하는 가장 대중적인 API
    - GraphQL: Graph 구조를 띄고 있으며 클라이언트에서 직접 필요한 데이터를 명시할 수 있는 형태의 통신 방식, 필요한 데이터만 가져올 수 있다는 장점
    - gRPC: HTTP/2를 사용하는 통신 방식, Protocol Buffers라는 방식을 사용하며 레이턴시를 최소화할 목적으로 설계

### REST API: Respresentation State Transfer API

- REST 기준을 따르는 HTTP API
- REST API는 HTTP의 GET, POST, PUT, DELETE등의 메서드를 사용해서 통신하는 가장 대중적인 API
- REST API는 균일한 인터페이스, 무상태, 계층화, 캐시 원칙을 준수하는 HTTP API이며, 이를 RESTful API라고 한다.
- RESTful API 통신
    - <client> -> GET, POST, PUT, DELETE -> <REST API> -> HTTP request -> <server>
    - <client> <-   JSON, XML, HTML      <- <REST API> -> HTTP response -> <server>
- Flutter framework에서 HTTP 요청을 하는 데 일반적으로 http plugin이나 Dio plugin을 사용한다.

```dart
import 'package:dio/dio.dart';

void main() async {
  final getResponse = await Dio().get('http://test.codefactory.ai'); // 1. HTTP Get 요청
  final postResponse = await Dio().post('http://test.codefactory.ai'); // 2. HTTP Post 요청
  final putResponse = await Dio().put('http://test.codefactory.ai'); // 3. HTTP Put 요청
  final deleteResponse = await Dio().delete('http://test.codefactory.ai'); // 4. HTTP Delete 요청
}
```

### JSON

HTTP 요청에서 body를 구성할 때 사용하는 구조는 크게 XML과 JSON으로 나눈다. XML은 구식으로 현대 API에서는 잘 사용하지 않고
대부분 JSON 구조를 사용한다. JSON은 키-값 쌍으로 이루어진 데이터 객체를 전달하는 개방형 표준 포맷이다.
```json
{
  // 'key': 'value'
  'name': 'code Factory',
  'languages': ['Javascript', 'Dart'],
  'age': 2    
}
```
REST APT 요청할 때 요청 및 응답 Body에 JSON 구조를 자주 사용한다.
Flutter에서 JSON 구조로 된 데이터를 응답받으면 직렬화(serialization)를 통해 클래스의 인스턴스로 변환하여 사용할 수 있다.


### late 키워드

널이 될 수 없는(non-nullable) 변수가 선언 시점에 초기화되지 않더라도,
사용되기 전에 반드시 초기화될 것임을 컴파일러에게 약속하는 것입니다.
즉, "이 변수는 나중에 초기화될 것이니, 사용하기 전에 값이 있을 거라고 믿어줘"  

* 선언 방법(late 키워드 사용)
```dart
late String myString;
``` 

* 초기화 방법(2 가지)
1. Initializing in initState()  
```dart
     @override
     void initState() {
       super.initState();
       myString = "initState에서 가져온 데이터"; // 여기서 초기화
     } 
```

2. Lazy Initialization(지연 초기화)
```dart
     myString = "안녕하세요!";
```

## Layout

- HomeScreen, AppBar, ListView

## Setps

### 구현 순서

1. Http 요청의 응답을 담을 모델 클래스를 구현하고,
2. UI를 작성한 다음,
3. Dio를 사용해서 API 요청을 진행하고,
4. 마지막으로 요청을 다시 실행하고 리스트를 갱신할 수 있는 새로고침 기능을 구현


### add plugins and assets in pubspec.yaml, `pub get`

- /assets/images/
```yaml
dependencies:
  youtube_player_flutter: ^9.1.1
  dio: ^5.8.0+1
```

### youtube API setting

we need token of google cloud platform,

이전 chool_check app 에서 발행한 토큰을 활용하면 되며, 이 토큰으로 유튜브 API까지 사용하려면 추가 설정이 필요하다.
1. connect console.cloud.google.com - searching YouTube Data API V3
2. YouTube Data API V3-> 'use' click
3. Apis & Services -> Credentials -> Api Keys -> Edit Api Keys click
4. Selected APIs -> 'YouTube Data API V3' check (important!!)

### configuring native setting

youtube_player_flutter's Requirements

####  on flutter version < 3.29

- /android/app/build.gradle
```gradle
  minSdk = 19 //flutter.minSdkVersion
```

#### > on flutter version >= 3.29
- /android/app/build.gradle.kts
```gradle.kts
    ndkVersion = "27.0.12077973"
    //ndkVersion = flutter.ndkVersion
```

### initialize project

- /lib/main.dart
```dart
void main() {
  runApp(
    MaterialApp(
      home: HomeScreen(),
    ),
  );
}
```

- lib/screens/home_screen.dart
```dart
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text('home'));
  }
}
```

### implement VideoModel

- 동영상  ID와 제목만 활용
- lib folder -> create dart file -> /model/video_model.dart
- lib/models/video_model.dart
```dart
/// movie ID and title of youtube api
class VideoModel {
  final String id;
  final String title;

  VideoModel({
    required this.id,
    required this.title,
  });
}
```

### implement CustomYoutubePlayer widget

#### create /lib/component/custom_youtube_player.dart
- lib folder -> create dart file -> /components/custom_youtube_player.dart
- /lib/components/custom_youtube_player.dart
```dart
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
```

#### implement YoutubePlayerController, YoutubePlayer and Column Widget

- /lib/components/custom_youtube_player.dart
```dart
import 'package:cf_tube_test/models/video_model.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CustomVideoPlayer extends StatefulWidget {
  final VideoModel videoModel; // 상위 위젯에서 입력받을 동영상 정보

  const CustomVideoPlayer({required this.videoModel, super.key});

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
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
      flags: const YoutubePlayerFlags(autoPlay: true, mute: false),
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
```

### implement Home Screen

- /lib/screens/home_screen.dart
```dart
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
```

### run

### implement YoutubeRepository

#### create /lib/consts/api.dart
```dart
// https://console.cloud.google.com/google/maps-apis
// chool_check app에서 발급받은 api
const API_KEY = 'cloud.google.com/google/maps-apis에서 발급받은 api key 입력';
// Youtube DATA API V3
const YOUTUBE_API_BASE_URL = 'https://youtube.googleapis.com/youtube/v3/search';
const CF_CHANNEL_ID = 'UCxZ2AlaT0hOmxzZVbF_j_Sw'; // 코드팩토리 채널 ID, 채널 페이지에 들어 갔을 때 URL의 마지막 부분에서 가져옴
```

#### youtube response result json

youtube  결과값이 json으로 아래와 같이 온다.

https://www.googleapis.com/youtube/v3/videos?part=snippet&order=date&maxResults=2&channelId=UCxZ2AlaT0hOmxzZVbF_j_Sw&key=your api key
```json
{
  "kind": "youtube#activityListResponse",
  "etag": "RyxIqE1_TvHwAwSm7d-MeHhTAbE",
  "items": [
    {
      "kind": "youtube#activity",
      "etag": "3hl1NtFCTuFmPnpQYcLRiIxc48c",
      "id": "MTUxNzQwMjAyNjIzMTc0MDIwMjYyMzAwMDQ2OQ",
      "snippet": {
        "publishedAt": "2025-02-22T05:37:03+00:00",
        "channelId": "UCxZ2AlaT0hOmxzZVbF_j_Sw",
        "title": "제 M1 Max를 희생 하겠습니다",
        "description": "#개발자 #deepseek #ai \n\n⭐️ 코드팩토리 통합링크 (모든 강의 및 서적) ⭐️\nhttps://links.codefactory.ai\n\n👉 NestJS 마스터클래스\nhttps://bit.ly/fcnestjs\n\n👉 플터터 초급\nhttps://inf.run/Sjuw\n\n👉 플터터 중급\nhttps://inf.run/hf1E\n\n👉 Typescript 마스터 클래스\nhttps://inf.run/3r8Jd\n\n👉 플러터 서적 (3판)\nhttps://bit.ly/4gXg1li",
        "thumbnails": {
          "default": {
            "url": "https://i.ytimg.com/vi/r0mM9DLriZE/default.jpg",
            "width": 120,
            "height": 90
          },
          "medium": {
            "url": "https://i.ytimg.com/vi/r0mM9DLriZE/mqdefault.jpg",
            "width": 320,
            "height": 180
          },
          "high": {
            "url": "https://i.ytimg.com/vi/r0mM9DLriZE/hqdefault.jpg",
            "width": 480,
            "height": 360
          },
          "standard": {
            "url": "https://i.ytimg.com/vi/r0mM9DLriZE/sddefault.jpg",
            "width": 640,
            "height": 480
          },
          "maxres": {
            "url": "https://i.ytimg.com/vi/r0mM9DLriZE/maxresdefault.jpg",
            "width": 1280,
            "height": 720
          }
        },
        "channelTitle": "코드팩토리",
        "type": "upload"
      }
    },
    {
      "kind": "youtube#activity",
      "etag": "PVM_4_bqlBIvjWhB3BnVtLrKazY",
      "id": "MTE3NDAyMDIyMDYxNzQwMjAyMjA2MDAwMDk2",
      "snippet": {
        "publishedAt": "2025-02-22T05:30:06+00:00",
        "channelId": "UCxZ2AlaT0hOmxzZVbF_j_Sw",
        "title": "제 M1 Max를 희생 하겠습니다",
        "description": "#개발자 #deepseek #ai \n\n⭐️ 코드팩토리 통합링크 (모든 강의 및 서적) ⭐️\nhttps://links.codefactory.ai\n\n👉 NestJS 마스터클래스\nhttps://bit.ly/fcnestjs\n\n👉 플터터 초급\nhttps://inf.run/Sjuw\n\n👉 플터터 중급\nhttps://inf.run/hf1E\n\n👉 Typescript 마스터 클래스\nhttps://inf.run/3r8Jd\n\n👉 플러터 서적 (3판)\nhttps://bit.ly/4gXg1li",
        "thumbnails": {
          "default": {
            "url": "https://i.ytimg.com/vi/r0mM9DLriZE/default.jpg",
            "width": 120,
            "height": 90
          },
          "medium": {
            "url": "https://i.ytimg.com/vi/r0mM9DLriZE/mqdefault.jpg",
            "width": 320,
            "height": 180
          },
          "high": {
            "url": "https://i.ytimg.com/vi/r0mM9DLriZE/hqdefault.jpg",
            "width": 480,
            "height": 360
          },
          "standard": {
            "url": "https://i.ytimg.com/vi/r0mM9DLriZE/sddefault.jpg",
            "width": 640,
            "height": 480
          },
          "maxres": {
            "url": "https://i.ytimg.com/vi/r0mM9DLriZE/maxresdefault.jpg",
            "width": 1280,
            "height": 720
          }
        },
        "channelTitle": "코드팩토리",
        "type": "playlistItem"
      }
    }
  ],
  "nextPageToken": "CAMQAA",
  "pageInfo": {
    "totalResults": 16,
    "resultsPerPage": 3
  }
}
```

#### implement YoutubeRepository

add YoutubeRepository

dio 패키지를 사용해서 HTTP 요청을 한다.

HTTP 요청에 대한 응답을 받아서 그 결과값을 List<VideoModel>로 전환한다.
items의 리스트값 중에 videoId나 title값이 존재하지 않는 경우를 제외시키고 나머지를 List<VideoModel>로 전환한다.

- /lib/repository/youtobe_repository.dart
```dart
import 'package:cf_tube/consts/api.dart';
import 'package:cf_tube/models/video_model.dart';
import 'package:dio/dio.dart';

/// dio 패키지를 사용해서 HTTP 요청을 한다.
///
/// HTTP 요청에 대한 응답을 받아서 그 결과값을 List<VideoModel>로 전환한다.
/// items의 리스트값 중에 videoId나 title값이 존재하지 않는 경우를 제외시키고 나머지를 List<VideoModel>로 전환한다.
class YoutubeRepository {
  static Future<List<VideoModel>> getVideos() async {
    // GET 메서드 보내기
    final response = await Dio().get(
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
```

### implement ListView in HomeScreen

add appBar, ListView widget

- /lib/screens/home_screen.dart
```dart
import 'package:cf_tube_test/components/custom_youtube_player.dart';
import 'package:cf_tube_test/models/video_model.dart';
import 'package:cf_tube_test/repository/youtube_repository.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
          return ListView(
            physics: BouncingScrollPhysics(), // 아래로 당겨서 스크롤 할 때 튕기는 애니메이션
            children:
                snapshot.data!
                    .map((e) => CustomYoutubePlayer(videoModel: e))
                    .toList(),
          );
        },
      ),
    );
  }
}

```

### implement Refresh function in HomeScreen

add RefreshIndicator widget

- /lib/screens/home_screen.dart
```dart
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
              setState(() {}); // 새로 고침 될 때마다 build() 함수를 재실행
            },
            child: ListView(
              physics: BouncingScrollPhysics(),  // 아래로 당겨서 스크롤할 때 튕기는 애니메이션
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

```
