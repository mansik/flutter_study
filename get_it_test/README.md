# get_it_test

A new Flutter project.

출처: https://youtu.be/SN85Vf2eoGY


## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


## Features

https://jsonplaceholder.typicode.com/albums
이 예제 json url를 사용하여 데이터를 불러오고 화면에 출력한다.

## Skill

get_it, http, ListView, ListTile, FutureBuilder

## Plugin(pub.dev)

- http: ^1.3.0
- get_it: ^8.0.3

## prior knowledge

### get_it이란?

#### 1. get_it이란?

get_it은 Flutter 및 Dart에서 사용되는 의존성 주입(Dependency Injection, DI) 라이브러리입니다.
즉, 앱의 여러 위치에서 객체 인스턴스를 쉽게 관리하고 접근할 수 있도록 도와주는 도구입니다.

📌 get_it의 주요 역할
- 전역적으로 객체를 관리 (예: ViewModel, Service, Repository 등)
- 싱글톤(Singleton) 패턴을 쉽게 구현
- Provider와 함께 사용하여 상태 관리 최적화
- UI와 비즈니스 로직을 분리하여 코드 유지보수성을 향상

💡 쉽게 말하면, get_it은 "전역 변수보다 더 안전하고 효율적인 방법"으로 객체를 관리하는 도구입니다.

#### 2. get_it을 사용하는 이유

Flutter에서는 일반적으로 Provider 같은 상태 관리 라이브러리를 많이 사용하지만,
Provider는 위젯 트리에 종속되므로 비즈니스 로직(Service, Repository)과 분리하기 어려운 경우가 있습니다.

🔥 get_it은 이런 문제를 해결해주는 라이브러리입니다.

- 위젯 트리와 무관하게 객체를 관리할 수 있음
- 객체를 **한 번만 생성(Singleton)**하여 어디서든 쉽게 접근 가능
- **DI(의존성 주입)**을 통해 코드의 가독성과 유지보수성을 높일 수 있음

#### 3. get_it 설치 및 설정

📌 1) pubspec.yaml에 의존성 추가   
📌 2) get_it 인스턴스 생성

- get_it을 사용하기 위해 전역 인스턴스를 생성해야 합니다.

```dart
import 'package:get_it/get_it.dart';

// GetIt 인스턴스 생성
final GetIt getIt = GetIt.instance;
```

- GetIt.instance를 사용하여 전역적으로 접근 가능한 객체를 만듭니다.

#### 4. get_it의 다양한 등록 방식 

- get_it에서는 객체를 등록하는 여러 가지 방법이 있습니다.

✅ 1) registerSingleton **(항상 같은 인스턴스 사용)**

```dart
getIt.registerSingleton<CounterService>(CounterService());
```

- 앱이 실행될 때 한 번만 생성되며, 이후 계속 동일한 객체를 반환합니다.

✅ 2) registerLazySingleton **(처음 사용할 때 한 번만 생성)**

```dart
getIt.registerLazySingleton<CounterService>(() => CounterService());
```

- 첫 번째 호출 시에만 객체를 생성하며, 이후에는 재사용합니다.
- 일반적으로 registerSingleton보다 메모리 절약이 가능하므로 권장됩니다.

✅ 3) registerFactory **(매번 새로운 객체 생성)**

```dart
getIt.registerFactory<CounterService>(() => CounterService());
```

- 매번 새로운 인스턴스를 생성합니다.
- 단점: 매번 새로운 객체가 생성되므로, 상태를 유지할 수 없음.

🔥 👉 싱글톤이 필요한 경우 registerLazySingleton 또는 registerSingleton을 사용하세요!

#### 5. get_it의 장점과 단점

✅ 장점
    ✔ 전역 객체 관리 가능 (싱글톤 관리 최적화)
    ✔ 위젯 트리에 종속되지 않음
    ✔ 비즈니스 로직과 UI 분리 가능
    ✔ 객체를 한 번만 생성하여 메모리 절약 가능

❌ 단점
    ✖ 위젯에서 UI 업데이트 자동화가 불가능 (setState() 필요)
    ✖ Provider 없이 사용하면 상태 변경 감지가 어려움
    ✖ 의존성 주입 패턴을 이해해야 효과적으로 사용 가능
    ✖ 런타임에 오류가 발생할 수 있음. 컴파일 타임에 의존성 오류를 감지할 수 없음
    ✖ 네임스페이스 충돌: registerSingleton을 과도하게 사용할 경우, 네임스페이스 충돌이 발생할 수 있음

#### 6. 결론

   get_it은 객체를 전역적으로 관리하는 강력한 라이브러리입니다.
   Provider 없이도 싱글톤 객체를 쉽게 사용할 수 있으며, 비즈니스 로직을 분리할 때 유용합니다.
   하지만 UI 업데이트가 자동으로 되지 않기 때문에, Provider와 함께 사용하는 것이 가장 효과적입니다.

### 의존성 주입(Dependency Injection)이란?

의존성 주입은 객체가 필요한 의존성(다른 객체)을 직접 생성하는 대신, 외부에서 주입받는 디자인 패턴입니다. 
이를 통해 다음과 같은 이점을 얻을 수 있습니다.

- 결합도(Coupling) 감소: 객체 간의 결합도를 낮춰, 코드를 더 유연하고 재사용 가능하게 만듭니다.
- 테스트 용이성: 의존성을 주입받기 때문에, 테스트 시에 Mock 객체를 쉽게 주입하여 단위 테스트를 용이하게 수행할 수 있습니다.
- 코드 재사용성: 의존성을 외부에서 주입받기 때문에, 여러 곳에서 동일한 의존성을 재사용할 수 있습니다.
- 유지보수성 향상: 결합도가 낮고 테스트가 용이하기 때문에, 코드를 수정하거나 확장하기가 더 쉬워집니다. 

### 서비스 로케이터 패턴(Service Locator Pattern)이란? 

서비스 로케이터 패턴은 의존성을 중앙에서 관리하는 패턴입니다. 
서비스 로케이터 객체는 애플리케이션 전체에서 접근 가능하며, 필요한 의존성을 요청하면 해당 의존성의 인스턴스를 반환합니다. 
get_it은 서비스 로케이터 패턴을 구현한 라이브러리입니다. 


## Steps

album_model -> album_service -> locator -> main

### modify pubspec.yaml
```
dependencies:
  provider: ^6.1.2
  http: ^1.3.0
  get_it: ^8.0.3
```

### json data
https://jsonplaceholder.typicode.com/albums
```json
[
  {
    "userId": 1,
    "id": 1,
    "title": "quidem molestiae enim"
  },
  {
    "userId": 1,
    "id": 2,
    "title": "sunt qui excepturi placeat culpa"
  }
]
```

### implement album_model

- /lib/models/album.dart
```dart
class Album {
  int? userId;
  int? id;
  String? title;

  Album({this.userId, this.id, this.title});

  factory Album.fromJson(Map<String, dynamic> json) =>
      Album(userId: json['userId'], id: json['id'], title: json['title']);
}
```

### implement album_service

- http를 사용하여 json파일을 가져와서 List<Album>로 만들기

- /lib/views/album_service.dart
```dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get_it_test/models/album_model.dart';

abstract class AlbumService {
  Future<List<Album>> fetchAlbums();
}

class AlbumServiceImplementation implements AlbumService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';
  static const String _albumsEndpoint = '/albums';

  @override
  Future<List<Album>> fetchAlbums() async {
    final url = '$_baseUrl$_albumsEndpoint';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to load albums: status code ${response.statusCode}',
      );
    }

    final List<Album> result =
    jsonDecode(
      response.body,
    ).map<Album>((json) => Album.fromJson(json)).toList();
    return result;
  }
}
```


### implement locator

- GetIt 라이브러리를 사용하여 AlbumService의 인스턴스를 DI(의존성 주입) 컨테이너에 등록합니다.
- [main.dart에서 구현해도 됨](https://pub.dev/packages/get_it/example) 

- /lib/locators/locator.dart
```dart
import 'package:get_it/get_it.dart';
import 'package:get_it_test/services/album_service.dart';

// GetIt 라이브러리를 사용하여 AlbumService의 인스턴스를 DI(의존성 주입) 컨테이너에 등록합니다.

// GetIt 인스턴스 생성
final getIt = GetIt.instance;

void setupLocator() {
  // 처음으로 요청할 때 (예: 앱의 다른 부분에서 getIt.get<AlbumService>()를 요청할 때)
  // 비로소 AlbumServiceImplementation 인스턴스를 생성합니다. 이를 지연 초기화라고 합니다.
  // 지연 초기화는 특히 서비스의 설정이 리소스를 많이 소모하거나, 모든 경우에 필요하지 않을 때 더 효율적입니다.
  getIt.registerLazySingleton<AlbumService>(() => AlbumServiceImplementation());
}
```


### implement main

1. getIt 초기화
2. getIt을 사용하여 AlbumService 인스턴스를 가져오기
3. getit 사용


- /lib/main.dart
```dart
import 'package:flutter/material.dart';
import 'package:get_it_test/locators/locator.dart';
import 'package:get_it_test/models/album_model.dart';
import 'package:get_it_test/services/album_service.dart';

void main() {
  setupLocator(); // 1. getIt 초기화
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'GetIt Test', home: const MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // 2.  GetIt을 사용하여 AlbumService 인스턴스를 가져온다.
  final AlbumService _albumService = getIt<AlbumService>();

  late Future<List<Album>> _albumsFuture;

  @override
  void initState() {
    super.initState();
    // 3. getit 사용
    _albumsFuture = _albumService.fetchAlbums();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GetIt Test')),
      body: FutureBuilder(
        future: _albumsFuture, // future: _albumService.fetchAlbums(); // _albumsFuture를 사용하여 데이터 가져오기를 분리
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // 데이터 로딩 중
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // 에러 발생
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // 데이터가 없거나 비어있음
            return const Center(child: Text('No data available.'));
          } else {
            // 데이터 있음
            final albums = snapshot.data!;
            return ListView.builder(
              itemCount: albums.length,
              itemBuilder: (context, index) {
                final album = albums[index];
                return ListTile(
                  title: Text('${album.id}: ${album.title}'),
                  // subtitle: Text('ID: ${album.id}'),
                );

                // Container를 사용하는 대신에 ListTile을 사용하여, 코드를 명료하게 합니다.
                // return Container(
                //   padding: const EdgeInsets.all(16.0),
                //   child: Text('${albums[index].id}:${albums[index].title}'),
                // );
              },
            );
          }
        },
      ),
    );
  }
}
```
