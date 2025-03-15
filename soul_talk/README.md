# soul_talk

A new Flutter project.

AI chatting bot

Gemini AI를 사용한 나만의 채팅봇

![Image](https://github.com/user-attachments/assets/4adee6d5-3109-4655-a36a-f48db7f16239)

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Features

- Gemini API를 사용해서 채팅 메시지를 주고받을 수 있다.
- 채팅 메시지를 Isar NoSQL 데이터베이스에 저장할 수 있다.
- StreamBuilder를 사용해서 메시지가 들어올 때마다 자동으로 화면을 업데이트 할 수 있다.

1. 사용자 채팅 메시지 입력/전송
2. Stream으로 제미나이 응답 실시간으로 받아오기
3. Isar 데이터베이스에 채팅 메시지 저장 및 조회

## Usage

- 채팅 텍스트필드에 메시지를 입력하고 전송

## Skill

Gemini API, Isar Database, StreamBuilder

HTTP request, REST API, JSON

## Plugin(pub.dev)

dependencies:
  isar: ^3.1.0+1
  isar_flutter_libs: ^3.1.0+1
  path_provider: ^2.1.5
  google_generative_ai: ^0.4.6
  get_it: ^8.0.3
  intl: ^0.20.2

dev_dependencies:
  build_runner: ^2.4.15
  isar_generator: ^3.1.0+1

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

![Image](https://github.com/user-attachments/assets/3ec33a59-cfa0-4c03-9f54-82cc6ca6388a)

### JSON

HTTP 요청에서 body를 구성할 때 사용하는 구조는 크게 XML과 JSON으로 나눈다. XML은 구식으로 현대 API에서는 잘 사용하지 않고
대부분 JSON 구조를 사용한다. JSON은 키-값 쌍으로 이루어진 데이터 객체를 전달하는 개방형 표준 포맷이다.
"key":"value"
```json
{  
  "name": "code Factory",
  "languages": ["Javascript", "Dart"],
  "age": 2    
}
```
REST APT 요청할 때 요청 및 응답 Body에 JSON 구조를 자주 사용한다.
Flutter에서 JSON 구조로 된 데이터를 응답받으면 직렬화(serialization)를 통해 클래스의 인스턴스로 변환하여 사용할 수 있다.

### Gemini API

제미나이는 아주 단순한 REST API 형식으로 AI 모델에 응답 생성을 요청할 수 있는 기능을 제공해준다.

[제미나이를 사용한 REST API](https://ai.google.dev/gemini-api/docs/text-generation?lang=rest)
  - 요청 URL: https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$YOUR_API_KEY
  - Qeury: key=$API_KEY
  - Method: POST
  - Data: 
    * 모델에 보낼 데이터를 contents.parts에 입력해주면 된다, 텍스트, 이미지, 오디오 등 다양한 형태를 입력할 수 있으며,
    contents.role에 user, model을 입력해 누가 제공한 데이터 인지 명시할 수 있으며, 
    기존에 대화했던 데이터를 contents로 모델에 다시 제공 해줌으로써 대화의 문맥을 이어갈 수 있다. 
  ```json
        {
          "contents": [{
            "parts":[{"text": "Explain how AI works"}],
            "role": "user"
          }]
        }
  ```

### Isar Database

Isar 데이터베이스는 플러터에서 사용할 수 있는 고성능 NoSQL 데이터베이스이다.  RDB의 SQL과 다른 특성을 갖고 있다.

- SQL 데이터베이스는 항상 테이블의 구조가 무결성을 유지해야 하지만, 
- NoSQL은 구조가 강제되지 않는다. 그렇기 때문에 사용이 자유로운 반면 프로젝트가 커졌을 때 유지보수가 어려워질 수 있다.
- 서버 데이터베이스는 무결성이 매우 중요하기 때문에 SQL 데이터베이스를 많이 사용하는 반면 
- 프론트엔드 데이터베이스는 퍼포먼스와 사용성이 조금 더 중요시 되며, 구조가 복잡하지 않기 때문에 NoSQL 데이터베이스를 사용하는 경우가 많다.

#### 컬렉션 정의하기

Isar 데이터베이스는 데이터를 컬렉션(Collection) 단위로 나누게 된다. 컬렉션은 특정 자료형 객체를 모아 관리하는 개념이다.
예를 들어, 사용자를 하나의 컬렉션으로, 상품을 다른 컬렉션으로 관리할 수 있다.
컬렉션을 정의하는 방법은 클래스를 선언하고 클래스를 @collection으로 어노테이트(Annotate)해 주면 된다.

```dart
import 'package:isar/isar.dart';

// builder_runner에 의해서 생성됨
// terminal-> dart run build_runner build
part 'message_model.g.dart';

@collection
class MessageModel {
  Id id = Isar.autoIncrement;
  bool isMine;
  String message;
  int? point;
  DateTime date;

  MessageModel({
    this.point,
    required this.isMine,
    required this.message,
    required this.date,
  });
}
```

#### 빌드 러너 실행하기

컬렉션을 정의하고 나면 꼭 빌드 러너(Build Runner)를 실행해 줘야 한다. 
Build Runner를 실행하면 @Collection으로 어노테이트된 모는 클래스들의 Isar 보조 파일을 생성하게 된다.
보조 파일들은 어노테이트된 클래스가 존재하는 파일 이름에 .g.dart를 붙여서 생성되며 컬렉션에 실행할 수 있는 기능을 정의하고 있다.
빌드 러너는 컬렉션이 새로 생기거나 변경되면 매번 실행해줘야 한다.

```text
// 터미널에서 현재 프로젝트 위치로 이동한 다음 실행
dart run build_runner build
```

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

HomeScreen

- 앱로고
- 날짜
- 채팅기록
- 포인트 적립 알립
- 채팅 입력창


## Setps

### add plugins and assets in pubspec.yaml, `pub get`

- /assets/images/
```yaml
dependencies:
  cupertino_icon: ^1.0.8
  isar: ^3.1.0+1
  isar_flutter_libs: ^3.1.0+1
  path_provider: ^2.1.5
  google_generative_ai: ^0.4.6
  get_it: ^8.0.3

dev_dependencies:
  flutter_lints: ^4.0.0
  build_runner: ^2.4.13
  isar_generator: ^3.1.0+1
```

### Getting Gemini API Key

구글 딥마인드의 제미나이를 사용하기 때문에 제미나이 API와 통신할 때 인증을 진행할 수 있는 API 키가 필요하다.

1. login [google ai studio](https://aistudio.google.com/settings) 
2. 'Get API Key' click
3. 'Create an API Key'

### configuring native setting

최신 플러터 버전에서는 그래들 8 버전 이상을 사용하고 있기 때문에 최신 플러터 버전을 지원하려면 플러그인들의 대응이 필요하다.
하지만 모든 플러그인들이 최신 업데이트 요구 사항을 반영하지 않기 때문에 이들 플러그인들에 대한 대응 방안이 필요하다.
아래 코드를 추가해서 그래들 8 버전의 요구사항인 namespace를 자동으로 추가하는 기능을 구현한다.

add code in gradle

- /android/build.gradle.kts
```gradle
// 1. comment this block
//subprojects {
//    project.evaluationDependsOn(":app")
//}

// 2. add this block
subprojects {
    afterEvaluate {
        if (project.hasProperty("android")) {
            extensions.findByType<com.android.build.gradle.LibraryExtension>()?.run {
                if (namespace == null || namespace!!.isEmpty()) {
                    namespace = project.group.toString()
                }
            }
        }
    }

    project.evaluationDependsOn(":app")
}
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


### implement Logo widget

new- dart file- widgets/logo 

- /lib/widgets/logo.dart
```dart
import 'package:flutter/material.dart';

/// Logo image and app description text
class Logo extends StatelessWidget {
  // 직접 너비/높이를 정의할 경우를 대비
  final double width;
  final double height;

  const Logo({super.key, this.width = 200, this.height = 200});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // logo image
        Image.asset('assets/images/logo.png', width: width, height: height),
        const SizedBox(height: 32),
        // app description text
        Text(
          'Hi! I am your soul chat bot. How can I help you?',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}

```

### implement PointNotification widget

- /lib/widgets/point_notification.dart
```dart
import 'package:flutter/material.dart';

/// Gemini에게 메시지를 보낼 때마다 몇 포인트가 적립됐는지 표시해 줄 알림 텍스트
///
/// Notification text to show how many points have been earned each time a message is sent to Gemini.
class PointNotification extends StatelessWidget {
  // 포인터
  final int points;

  const PointNotification({super.key, required this.points});

  @override
  Widget build(BuildContext context) {
    return Text(
      '$points points',
      style: const TextStyle(
        color: Colors.blueAccent,
        fontStyle: FontStyle.italic,
      ),
    );
  }
}
```

### implement Message widget

- /lib/widgets/message.dart
```dart
import 'package:flutter/material.dart';
import 'package:soul_talk/widgets/point_notification.dart';

/// 제이나이와 내가 한 채팅 내용을 보여줄 채팅 버블
/// 
/// 왼쪽은 제미나이 메시지, 오른쪽은 내가 보낸 메시지를 위치시킴
class Message extends StatelessWidget {
  // true면 왼쪽 정렬, false면 오른쪽 정렬
  final bool alignLeft;

  // 보여줄 메시지
  final String message;

  // 현재까지 적립된 포인트
  final int? point;

  const Message({
    super.key,
    this.alignLeft = true,
    this.point,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    // alignLeft를 기준으로 Alingment 프로퍼티 생성하기
    final alignment = alignLeft ? Alignment.centerLeft : Alignment.centerRight;

    // 왼쪽 정렬이면 더 어두운 배경 사용
    final backgroundColor = alignLeft ? Color(0xFFF4F4F4) : Colors.white;
    final borderColor = alignLeft ? Color(0xFFE7E7E7) : Colors.black12;

    return Column(
      children: [
        // 메시지 버블 디자인 정의
        Align(
          alignment: alignment,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32.0),
              color: backgroundColor,
              border: Border.all(color: borderColor, width: 1.0),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Text(
                message,
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
            ),
          ),
        ),
        if (point != null)
          Align(alignment: alignment, child: PointNotification(point: point!)),
      ],
    );
  }
}

```

### implement DateDivider widget

- /lib/widgets/date_divider.dart
```dart
import 'package:flutter/material.dart';

/// 날짜를 입력받고 화면에 '2025-03-08' 형식으로 출력하는 위젯
///
/// 이전 채팅 메시지와 현재 채팅 메시지의 생성 날짜가 다를 때 화면에 출력한다.
class DateDivider extends StatelessWidget {
  final DateTime date;

  const DateDivider({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Text(
      '${date.year}-${date.month}-${date.day}',
      style: TextStyle(fontSize: 12, color: Colors.black54),
      textAlign: TextAlign.center,
    );
  }
}

```

### implement ChatTextField widget

- /lib/widgets/chat_text_field.dart
```dart
import 'package:flutter/material.dart';

/// 채팅 입력창
///
/// TextField에 입력된 값을 받아올 수 있도록 controller를 입력받고,
/// 메시지 전송 버튼을 눌렀을 때 함수를 실행할 수 있도록 onSend를 입력받음.
class ChatTextField extends StatelessWidget {
  // 입력값 추출을 위해 외부에서 controller 직접 입력 받기
  final TextEditingController controller;

  // 메시지 전송 버튼을 눌렀을 때 실행할 함수
  final VoidCallback onSend;

  // 에러 메시지 있을 경우 입력 받기
  final String? errorText;

  // 로딩 중일 경우 전송 버튼 디자인을 회색으로 변경 및 비활성화하기 위한 상태값
  final bool loading;

  const ChatTextField({
    super.key,
    required this.controller,
    required this.onSend,
    this.errorText,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: Colors.blueAccent,
      textAlignVertical: TextAlignVertical.center,

      // 입력 필드 최소 1줄
      minLines: 1,

      // 입력 필드 최대 4줄
      maxLines: 4,
      decoration: InputDecoration(
        errorText: errorText,

        // 텍스트 필드 전송 버튼
        // suffixIcon은 UI 디자인에서 입력 필드(Input field) 등에서 끝(오른쪽)에 표시되는 아이콘을 의미
        suffixIcon: IconButton(
          onPressed: loading ? null : onSend,
          icon: Icon(
            Icons.send_outlined,
            color: loading ? Colors.grey : Colors.blueAccent,
          ),
        ),

        // 테두리 둥근 형태
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),

        // 텍스트 필드가 선택되어 있는 경우 파란색 테두리로 변경
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
          borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
        ),
        hintText: 'Input message!',
      ),
    );
  }
}

```

### implement message model

- /lib/models/message_model.dart
```dart
class MessageModel {
  // message ID
  final int id;

  // is user message or AI message?, true: user, false: AI
  final bool isMine;

  // message text
  final String message;

  // message point
  final int? point;

  // message date
  final DateTime date;

  MessageModel({
    required this.id,
    required this.isMine,
    required this.message,
    required this.point,
    required this.date,
  });
}

```

### Layout the UI elements on the home screen(UI 요소 배치하기)

1. Convert a StatelessWidget to a StatefulWidget
2. Add _buildLogo() that return Logo Widget 

- /lib/screens/home_screen.dart
```dart
import 'package:flutter/material.dart';
import 'package:soul_talk/widgets/logo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Hello Flutter!")));
  }

  /// create buildLogo Widget
  Widget _buildLogo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: const Padding(
        padding: EdgeInsets.only(bottom: 60.0),
        child: Logo(),
      ),
    );
  }
}

```

3. Add Message Sample Data 

API 연동을 완료하기 전까지 UI가 의도한 대로 출력되는지 확인하는데 필요한 샘플 데이터를 추가한다.

- /lib/screens/home_screen.dart
```dart
import 'package:flutter/material.dart';
import 'package:soul_talk/models/message_model.dart';
import 'package:soul_talk/widgets/logo.dart';

final sampleData = [
  MessageModel(
    id: 1,
    isMine: true,
    message: "Recommend me something to eat for dinner tonight.",
    point: 1,
    date: DateTime(2025,03,05),
  ),
  MessageModel(
    id: 2,
    isMine: false,
    message: "How about kimchi stew?",
    point: null,
    date: DateTime.now(),
  ),
];

class HomeScreen extends StatefulWidget {}
```

4. Add buildMessageItem() that draws messages on the screen

   - 메시지당 buildMessageItem() 함수를 실행하면 화면에 메시지 하나를 그려주거나 날짜와 함께 메시지를 그린다.
   - DateTime을 String으로 변환하는 getStringDate() 추가
   - 두 날짜를 다른 날짜로 인식해야 하는지를 확인 하는 shouldDrawDate() 추가

- /lib/screens/home_screen.dart
```dart
import 'package:flutter/material.dart';
import 'package:soul_talk/models/message_model.dart';
import 'package:soul_talk/widgets/date_divider.dart';
import 'package:soul_talk/widgets/logo.dart';
import 'package:soul_talk/widgets/message.dart';

// ... 

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Hello Flutter!")));
  }

  /// create buildLogo Widget
  Widget buildLogo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: const Padding(
        padding: EdgeInsets.only(bottom: 60.0),
        child: Logo(),
      ),
    );
  }

  Widget buildMessageItem({
    MessageModel? prevMessage,
    required MessageModel message,
    required int index,
  }) {
    final isMine = message.isMine!;
    // DataDivider 위젯을 그려야 하는지 판단하기
    final shouldDrawDateDivider =
        prevMessage == null || shouldDrawDate(prevMessage.date!, message.date!);

    return Column(
      children: [
        // DateDivider 위젯을 그려야 하는지 판단하기
        if (shouldDrawDateDivider)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: DateDivider(date: message.date),
          ),

        // 정렬 위치에 따라 패팅 다르게 제공해주기
        Padding(
          padding: EdgeInsets.only(
            left: isMine ? 64.0 : 16.0,
            right: isMine ? 16.0 : 64.0,
          ),
          child: Message(
            alignLeft: !isMine,
            message: message.message.trim(),
            point: message.point,
          ),
        ),
      ],
    );
  }

  // String으로 반환된 날짜가 다를 경우 true 반환
  bool shouldDrawDate(DateTime dateTime1, DateTime dateTime2) {
    return getStringDate(dateTime1) != getStringDate(dateTime2);
  }

  // DateTime을 '2025-11-12'의 String으로 변환
  String getStringDate(DateTime dateTime1) {
    return '${dateTime1.year}-${dateTime1.month}-${dateTime1.day}';
  }
}
```

5. Show UI elements on the screen

buildMessageList()를 만들어서 화면에 로고와 메시지를 보여줄 ListView를 추가

- /lib/screens/home_screen.dart
```dart
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: buidMessageList());
  }

  // 화면에 보여줄 메시지 리스트
  Widget buidMessageList() {
    return ListView.separated(
      itemCount: sampleData.length + 1,
      itemBuilder: (context, index) =>
      index == 0 ? buildLogo() : buildMessageItem(
          prevMessage: index > 1 ? sampleData[index - 2] : null,
          message: sampleData[index - 1],
          index: index - 1),
      separatorBuilder: (_, _) => const Divider(height: 16.0),
    );
  }
}
```

6. Add ChatTextField widget on the screen

   - Vertically arrange a ListView widget and a TextField widget using a Column widget.
   - Defind an empty handleSendMessage() method.

- /lib/screens/home_screen.dart
```dart
import 'package:flutter/material.dart';
import 'package:soul_talk/models/message_model.dart';
import 'package:soul_talk/widgets/chat_text_field.dart';
import 'package:soul_talk/widgets/date_divider.dart';
import 'package:soul_talk/widgets/logo.dart';
import 'package:soul_talk/widgets/message.dart';

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _textController = TextEditingController();

  // 로딩여부를 확인하는 변수
  bool isRunning = false;

  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: buidMessageList()),
            ChatTextField(
              controller: _textController,
              onSend: handleSendMessage,
              errorText: errorMessage,
              loading: isRunning,
            ),
          ],
        ),
      ),
    );
  }

  // 메시지 보내기 버튼을 누르면 실행할 함수
  handleSendMessage() {}
}
```


### Setting Isar

1. Refactor message_model

- /lib/models/message_model.dart
```dart
import 'package:isar/isar.dart';

// builder_runner에 의해서 생성됨
// terminal-> dart run build_runner build
part 'message_model.g.dart';

@collection
class MessageModel {
  // message ID
  Id id = Isar.autoIncrement;

  // is user message or AI message?, true: user, false: AI
  bool isMine;

  // message text
  String message;

  // message point
  int? point;

  // message date
  DateTime date;

  MessageModel({
    required this.isMine,
    required this.message,
    required this.date,
    this.id = Isar.autoIncrement,
    this.point,
  });
}

```

2. terminal-> dart run build_runner build
3. initialize the Isar in main.dart

- /lib/main.dart
```dart
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:soul_talk/models/message_model.dart';
import 'package:soul_talk/screens/home_screen.dart';

void main() async {
  // 플러터 프레임워크가 실행 준비될 때까지 기다리기
  WidgetsFlutterBinding.ensureInitialized();

  // 앱에 배정된 폴더 경로 가져오기
  final dir = await getApplicationDocumentsDirectory();

  // Isar 데이터베이스 초기화
  final isar = await Isar.open([MessageModelSchema], directory: dir.path);

  // GetIt에 Isar 주입해서 프로젝트 어디에서든 사용하기
  GetIt.I.registerSingleton<Isar>(isar);

  runApp(MaterialApp(home: HomeScreen()));
}
```

### Linking Gemini(제미나이 연동하기)

REST API를 사용하는 것이 아닌 플러터 SDK를 사용하여 연동

- /lib/screens/home_screen.dart

1. 내가 제미나이에 보낸 메시지를 Isar에 저장: handleSendMessage()
[get_it](https://pub.dev/packages/get_it)
[Isar](https://pub.dev/packages/isar)

```dart
import 'package:get_it/get_it.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:isar/isar.dart';

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {

    /// ...생략...

    /// 1. 내가 제미나이에 보낸 메시지를 Isar에 저장    
    ///
    // 메시지 보내기 버튼을 누르면 실행할 함수
    handleSendMessage() async {
      // TextField에 입력된 메시지가 없으면 에러 보여주기
      if (textController.text.isEmpty) {
        setState(() => errorMessage = 'please enter a message!');
        return;
      }

      // 현재 응답받고 있는 메시지 ID(스트림으로 지속적으로 업데이트하기)
      int? currentModelMessageId;

      // 내가 보낸 메시지에 배정된 ID(에러가 발생하면 삭제)
      int? currentUserMessageId;

      // Isar 인스턴스 가져오기
      final isar = GetIt.I<Isar>();

      // TextField에 입력된 값 가져오기
      final currentPrompt = textController.text;

      try {
        // 로딩 중으로 상태 변경
        setState(() {
          isRunning = true;
        });

        // TextField에 입력된 값 모두 삭제
        textController.clear();

        // 현재 데이터베이스에 저장되어 있는 내가 보낸 메시지 숫자 세기(포인터용)
        final currentUserMessageCount = await isar.messageModels.filter().isMineEqualTo(true).count();

        // 내가 보낸 메시지 Isar에 저장하기
        currentUserMessageId = await isar.writeTxn(() async {
          return await isar.messageModels.put(
            MessageModel(
              isMine: true,
              message: currentPrompt,
              point: currentUserMessageCount + 1,
              date: DateTime.now(),
            ),
          );
        });
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }

    /// ...생략...
  }
}
```

2. 제미나이에 보낼 데이터를 만들기

[Gemini Developer API](https://ai.google.dev/gemini-api/docs)
[google_generative_ai](ttps://pub.dev/packages/google_generative_ai)

```dart
import 'package:soul_talk/consts/gemini_api.dart';

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {

    /// ...생략...

    /// 1. 내가 제미나이에 보낸 메시지를 Isar에 저장
    /// 2. 제미나이에 보낼 데이터를 만들기
    /// 
    // 메시지 보내기 버튼을 누르면 실행할 함수
    handleSendMessage() async {
      /// ...생략...
      try {
        /// ...생략...

        // 최근 5개의 메시지만 불러오기
        final recentMessages =
        await isar.messageModels.where().limit(5).findAll();
        
        // 최근 메시지를 Content로 변환하기
        final List<Content> promptContext =
        recentMessages
            .map(
              (e) =>
              Content(
                // Role 지정하기
                e.isMine ? 'user' : 'model',
                // 문자 메시지를 제공하려면 TextPart 클래스를 사용
                [TextPart(e.message!)],
              ),
        ).toList();

        // https://ai.google.dev/gemini-api/docs
        // https://pub.dev/packages/google_generative_ai
        final model = GenerativeModel(
          // 사용하려는 모델을 정의
          model: 'gemini-2.0-flash',
          apiKey: GeminiApi.geminiApiKey,
          // 제미나이가 어떤 역할을 해야 하는지 정의
          systemInstruction: Content.system(
            "From now on, you'll be a kind and friendly friend.",
          ),
        );
      }
      catch (e) {
        /// ...생략...
      }
    }
  }
}
```

- /lib/consts/gemini_api.dart
```dart
abstract class GeminiApi {
  // private constructor로 개발자가 실수로 인스턴스화 하는 코드를 작성하는 것을 방지한다.
  GeminiApi._();

  static const geminiModel = 'gemini-2.0-flash';
  static const geminiApiKey = 'your gemini api key';
}

```

3. 제미나이에게 메시지를 보내고 응답을 Isar에 저장
전체 응답이 올 때까지 기다리지 않고 
부분 부분 응답이 올 때마다 메시지를 즉각적으로 화면에 보여줄 수 있도록 메시지를 스트림으로 받음

```dart
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {

    /// ...생략...

    /// 1. 내가 제미나이에 보낸 메시지를 Isar에 저장
    /// 2. 제미나이에 보낼 데이터를 만들기
    /// 
    // 메시지 보내기 버튼을 누르면 실행할 함수
    handleSendMessage() async {
      /// ...생략...
      try {
        /// ...생략...

        final model = GenerativeModel(

          /// ...생략...
          ///           
          // 제미나이가 어떤 역할을 해야 하는지 정의
          systemInstruction: Content.system(
            "From now on, you'll be a kind and friendly friend.",
          ),
        );

        /// 3. 제미나이에게 메시지를 보내고 응답을 Isar에 저장
        ///
        // Stream으로 받아지는 메시지를 지속적으로 추가할 문자열
        String message = '';

        // generateContentStream을 실행하면 Stream으로 응답을 받을 수 있다.
        model
            .generateContentStream(promptContext)
            .listen(
              (event) async {
                // 응답 메시지가 있다면 message 변수를 추가한다.
                if (event.text != null) {
                  message += event.text!;
                }
    
                // message 변수를 기반으로 MessageModel을 생성한다.
                final model = MessageModel(
                  isMine: false,
                  message: message,
                  point: null,
                  date: DateTime.now(),
                );

                /// Stream으로 데이터를 받아오면 한 번에 응답이 오지 않고 부분 부분으로 나워서 응답을 받는다.
                /// Isar 데이터베이스의 put() 함수는 id를 제공하지 않을 경우 새로운 데이터를 생성하고 
                /// id를 제공할 경우 기존 Irar 데이터를 업데이트 한다. 
                /// 응답이 부분 부분 올 때마다 새로운 Isar 데이터를 매번 생성하면 안 되니 처음 데이터를 생성한 후에는 
                /// 존재하는 데이터에 메시지를 업데이트 한다.
                ///  
                // 이미 메시지를 생성한 적이 있다면 model 변수에 id 퍼로퍼티를 추가한다.
                if (currentModelMessageId != null) {
                  model.id = currentModelMessageId!;
                }
    
                // 메시지를 저장하고 반환받은 ID값을 currentModelMessageId에 할당한다.
                currentModelMessageId = await isar.writeTxn<int>(
                      () => isar.messageModels.put(model),
                );
              },
    
              // Stream이 끝나면 로딩 상태를 변경한다.
              onDone:
                  () =>
                  setState(() {
                    isRunning = false;
                  }),
    
              // Stream이 끝나면 로딩 상태를 변경한다.
              onError: (e) async {
                await isar.writeTxn(() async {
                  return isar.messageModels.delete(currentUserMessageId!);
                });
                setState(() {
                  isRunning = false;
                  errorMessage = e.toString();
                });
              },
            );
      } catch (e) {
        /// ...생략...
      }
    }
  }
}
```

4. Isar 데이터베이스로부터 메시지 데이터를 Stream으로 받아와서 UI에 반영한다.

refact build(), buidMessageList()

> Gemini에 질의:
> 'stream: GetIt.I<Isar>().messageModels.where().watch(fireImmediately: true)' 에 대해 설명해줘

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white,
    body: SafeArea(
      child: Column(
        children: [
          // MessageModel 컬렉션에 업데이트가 있을 때마다
          // ListView를 다시 그리기 위해서 StreamBuilder를 사용한다.
          Expanded(
            child: StreamBuilder<List<MessageModel>>(
              // 모든 데이터를 가져오는 쿼리에 대해(where()), 스트림을 만들고(watch()),
              // 스트림이 시작되는 즉시 현재 데이터 스냅샷을 방출하고(fireImmediately: true),
              // 이후에는 데이터가 변경될 때마다 변경된 데이터를 스트림을 통해 방출한다(fireImmediately: true).
              stream: GetIt
                  .I<Isar>()
                  .messageModels
                  .where()
                  .watch(
                fireImmediately: true,
              ),
              builder: (context, snapshot) {
                final messages = snapshot.data ?? [];
                return buidMessageList(messages);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 32.0,
            ),
            child: ChatTextField(
              controller: textController,
              onSend: handleSendMessage,
              errorText: errorMessage,
              loading: isRunning,
            ),
          ),
        ],
      ),
    ),
  );
}

///...생략...

// 화면에 보여줄 메시지 리스트
Widget buidMessageList(List<MessageModel> messages) {
  return ListView.separated(
    itemCount: messages.length + 1,
    itemBuilder:
        (context, index) =>
    index == 0
        ? buildLogo()
        : buildMessageItem(
      prevMessage: index > 1 ? messages[index - 2] : null,
      message: messages[index - 1],
      index: index - 1,
    ),
    separatorBuilder: (_, _) => const Divider(height: 16.0),
  );
}
```

5. run 후 확인


### implement auto scroll animation

새로운 메시지가 화면을 넘어갈 때 자동으로 리스트의 끝까지 스크롤이 안되고 있어서,
메시지가 새로 들어올 때마다 화면 끝으로 자동으로 스크롤을 이동한다.

add scrollController, scrollToBottom()   

- /lib/screens/home_screen.dart
```dart
class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController textController = TextEditingController();

  // 코드로 자동으로 스크롤하기 위해 scrollController 선언한다.
  final ScrollController scrollController = ScrollController();

  ///...생략...

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
            children: [
              // MessageModel 컬렉션에 업데이트가 있을 때마다
              // ListView를 다시 그리기 위해서 StreamBuilder를 사용한다.
              Expanded(
                child: StreamBuilder<List<MessageModel>>(
                  // 모든 데이터를 가져오는 쿼리에 대해(where()), 스트림을 만들고(watch()),
                  // 스트림이 시작되는 즉시 현재 데이터 스냅샷을 방출하고(fireImmediately: true),
                  // 이후에는 데이터가 변경될 때마다 변경된 데이터를 스트림을 통해 방출한다(fireImmediately: true).
                  stream: GetIt
                      .I<Isar>()
                      .messageModels
                      .where()
                      .watch(
                    fireImmediately: true,
                  ),
                  builder: (context, snapshot) {
                    final messages = snapshot.data ?? [];

                    // WidgetsBinding.instance.addPostFrameCallback() 함수를 사용하여 
                    // 현재 build()가 끝나고 딱 한 번만 콜백 함수를 실행한다.
                    WidgetsBinding.instance.addPostFrameCallback((_) async => scrollToBottom());

                    return buidMessageList(messages);
                  },
                ),
              ),
            ]
        ),
      ),
    );
  }
  
  /// ListView의 가장 아래로 이동하는 함수
  void scrollToBottom() {
    // 현재 위치가 최대 스크롤 가능 위치가 아닐 때만 실행한다.
    if (scrollController.position.pixels !=
        scrollController.position.maxScrollExtent) {

      // 원하는 위치까지 스크롤을 가능하도록 하는 함수
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300), // 300ms에 걸쳐서 스크롤 애니메이션을 실행한다.
        curve: Curves.easeOut, // 애니메이션이 끝날수록 느려지는 유형으로 실행한다.
      );
    }
  }
  
  ///...생략...
  
  // 화면에 보여줄 메시지 리스트
  Widget buidMessageList(List<MessageModel> messages) {
    return ListView.separated(
      controller: scrollController, // ListView의 스크롤을 제어하는 컨트롤러
      ///...생략...
    );
  }
}
```

### run