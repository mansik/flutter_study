# image_carousel

A new Flutter project.

p. 220 
전자 액자: 좌, 우로 스와이프해서 이미지 슬라이딩  
앱 로딩되면 주기적으로 이미지 슬라이딩

StatefulWidget, Timer.periodic, PageView, SystemChrome, 위젯 생명주기 

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Setps

p. 220
- StatelessWidget: 상태가 없는 위젯, 생성자 -> build() 후 build()는 재실행되지 않음.
- StatefulWidget: 생성자의 매개변수를 변경해주면 위젯이 새롭게 생성, build() 함수 재실행
  - StatefulWidget (constructor -> createState()) -> State(initState() -> ...-> build() -> ... -> dispose())
  - StatefulWidget의 3가지 생명 주기
    - 상태 변경이 없는 생명주기
    - StatefulWidget 생성자의 매개변수가 변경됐을 때의 생명주기
    - State 자체적으로 build()를 재실행할 때의 생명주기

### create asset - images fold

asset: 프로젝트에 사용되는 동영상, 이미지, 음악등의 파일을 의미
- asset
  - images

### add assets: on pubspec.yaml

```yaml
  assets:
  #   - images/a_dot_burr.jpeg
  #   - images/a_dot_ham.jpeg
    - asset/images/
```

### add pageview

pageview 위젯은 children 매개변수에 페이지로 생성하고픈 위젯을 넣어주면 된다.
- /screens/home_screen.dart
```dart
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [1, 2, 3, 4, 5].map(
          (number) => Image.asset('asset/images/image_$number.jpeg',
            fit: BoxFit.cover // 부모 위젯 전체를 덮는 선에서 최소한 크기로 조절한다. 여백은 생기지 않지만 가로 또는 세로로 이미지가 잘릴 수 있다.
          ),
        ).toList(),// 이미지 위젯 리스트
      ),
    );
  }
}
```

### 상태바 색상 변경

- SystemChrome: 시스템 UI의 그래픽 설정을 변경하는 기능
  - SystemChrome.setSystemUIOverlayStyle(): 시스템 UI의 색상을 변경
  - SystemChrome.setEnabledSystemUIMode(): 앱의 풀스크린 모드를 지정, 상단의 상태바를 가릴 수 있다.
  - SystemChrome.setPreferredOrientations(): 앱을 실행하는 방향을 지정, 가로, 가로 좌우 반전, 세로, 세로 좌우 반전 옵션
  - SystemChrome.setSystemUIChangeCallback(): 시스템 UI가 변경되면 콜백 함수 실행

- /screens/home_screen.dart
```dart
  @override
  Widget build(BuildContext context) {
  // 상태바 색상 변경
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

  return Scaffold();
}
```

### StatefulWidget 추가

- /screens/home_screen.dart
```dart
/// Timer를 추가해서 액자가 자동으로 변경되게 하기 위해서 StatefulWidget로 변경
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // 상태바 색상 변경
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return Scaffold(
      body: PageView(
        children: [1, 2, 3, 4, 5]
            .map(
              (number) => Image.asset(
                'asset/images/image_$number.jpeg',
                fit: BoxFit.cover, // 부모 위젯 전체를 덮는 선에서 최소한 크기로 조절한다. 여백은 생기지 않지만 가로 또는 세로로 이미지가 잘릴 수 있다.
              ),
            )
            .toList(),
      ),
    );
  }
}
```

### initState(), Timer.periodic() 추가

- /screens/home_screen.dart
```dart
class _HomeScreenState extends State<HomeScreen> {
  // initState() 함수에서 Timer.periodic(); 함수 실행해서 주기적으로 콜백 함수 호출한다.
  // 마우스 우측 -> Generate..(Alter + Insert) -> initState  클릭
  // initState()는 핫 리로드로 반영이 안된다.
  // 이유는 initState()는 State가 생성될 때 딱 한번만 실행된다.
  @override
  void initState() {
    super.initState(); // 부모 initState() 실행

    // async 패키지 사용: import 필요
    Timer.periodic(
      Duration(seconds: 3),
              (timer) {
        print('timer');
      },
    );
  }

  @override
  Widget build(BuildContext context) {}
```

### PageController 추가

1. PageController 생성
2. PageView에 PageController 등록

- /screens/home_screen.dart
```dart
class _HomeScreenState extends State<HomeScreen> {
  // 1. PageView를 조작하기 위해서 PageController 사용
  final PageController pageController = PageController();
  
  // initState() 함수에서 Timer.periodic(); 함수 실행해서 주기적으로 콜백 함수 호출한다.
  // 마우스 우측 -> Generate..(Alter + Insert) -> override Methods.. - initState  클릭
  // initState()는 핫 리로드로 반영이 안된다.
  // 이유는 initState()는 State가 생성될 때 딱 한번만 실행된다.
  @override
  void initState() {
    super.initState(); // 부모 initState() 실행

    // async 패키지 사용: import 필요
    Timer.periodic(
      Duration(seconds: 3),
      (timer) {
        print('timer');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // 상태바 색상 변경
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return Scaffold(
      body: PageView(
        controller: pageController, // 2. PageController 등록
        children: [1, 2, 3, 4, 5]
```


### PageController 사용하여 주기적으로 페이지 자동으로 변경

1. PageController 생성
2. PageView에 PageController 등록
3. intState()에서 PageController 사용하여 주기적으로 페이지 자동으로 변경

- /screens/home_screen.dart
```dart
class _HomeScreenState extends State<HomeScreen> {
  // 1. PageView를 조작하기 위해서 PageController 사용
  final PageController pageController = PageController();

  // initState() 함수에서 Timer.periodic(); 함수 실행해서 주기적으로 콜백 함수 호출한다.
  // 마우스 우측 -> Generate..(Alter + Insert) -> initState  클릭
  // initState()는 핫 리로드로 반영이 안된다.
  // 이유는 initState()는 State가 생성될 때 딱 한번만 실행된다.
  @override
  void initState() {
    super.initState(); // 부모 initState() 실행

    // async 패키지 사용: import 필요
    Timer.periodic(
      Duration(seconds: 3),
          (timer) {
        // print('timer');

        // 3. PageController 사용하여 페이지 변경하기
        // pageController.page 게터를 사용해서 PageView의 현재 페이지를 가져오며,
        // 페이지가 변경 중인 경우 소수점으로 표현되어 double값이 반환된다.
        // 하지만 페이지 증가 및 animateToPage()에서 정수값을 필요로 하므로 정수로 변환하였음.
        int? nextPage = pageController.page?.toInt(); // 현재 페이지 가져오기

        // 페이지가 없을 때 예외 처리
        if (nextPage == null) {
          return;
        }

        // 첫 페이지와 마지막 페이지 분기 처리 및 다음 페이지 셋팅
        if (nextPage == 4) {
          nextPage = 0;
        } else {
          nextPage++;
        }

        // 페이지 변경
        pageController.animateToPage(
          nextPage,
          duration: Duration(milliseconds: 500), // 이동시 소요 시간
          curve: Curves
              .ease, // 페이지가 변경되는 애니메이션 작동 방식(https://api.flutter.dev/flutter/animation/Curves-class.html)
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // 상태바 색상 변경
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return Scaffold(
      body: PageView(
        // 2. PageController 등록
        controller: pageController,
      ),
    );
  }
}
```