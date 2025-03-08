# random_dice

A new Flutter project.

디지털 주사위, 가속도계, 자이로스코프, Sendsor_Plus

![Image](https://github.com/user-attachments/assets/0581ed31-ab8b-4545-9780-f7c4c4d22fcd)

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


## Features

핸드폰을 흔틀면 새로운 주사위를 뽑아주는 앱
- BottomNavigation을 이용해서 탭 현태의 UI를 구현
- 가속도계를 사용해서 흔들기 기능을 구현
- Slider를 이용해서 흔들기 민감도를 설정하는 기능 구현

## Usage

에뮬레이터에서는 테스트가 안되며 실제 폰에서 테스트를 해야 한다.
- 첫 번째 탭에서 핸드폰을 흔들면 주사위의 숫자가 랜텀하게 바뀐다.
- 두 번째 탭에서 슬라이더를 움직이면 흔들기의 민감도를 정할 수 있다.

## Skill

Shake, BottomNavigationBar, Slider

## Plugin

- shake: 2.2.0
- sensors_plus: 6.1.1

## prior knowledge

- 가속도계: 특정 물체가 특정 방향으로 이동하는 가속도를 측정하는 기기. 직선 움직임만 측정,  x, y, z축(좌우, 위아래, 앞뒤)
- gyroscope: x, y, z축의 회전을 측정
- Sensor_Plus package: 핸드폰의 가속도계와 gyroscope sensor를 사용할 수 있다. 
핸드폰의 움직임을 측정하려면 정규화(normalization)가 필요하며, x, y, z 각 값을 통합해 전반적인 움직임 수치를 계산해서
핸드폰을 흔든 정도를 수치화해야 한다. 이를 위해 shake package를 이용한다.


## Setps

### screen structure
- root screen: 최상위 위젯, TabBarView widget, BottomNavigationBar widget으로 하위 화면을 전환
  - home screen: 주사위 화면
  - settings screen: 설정 화면

### add a constant(상수 추가하기)

반복적으로 사용하는 상수(글자 크기, 주색상등)를 별도의 파일에 정리: /lib/const/colors.dart

### add images

/assets/images/

### edit pubspec.yaml and execute `put get`

- shake: ^2.2.0 # 흔들림 감지 플러그인
- sensors_plus: ^6.1.1
- assets
```yaml
dependencies:  
  shake: 2.2.0 # 흔들림 감지 플러그인
  
dependency_overrides:
  sensors_plus: 6.1.1 # shake package사용 시 run에서 오류가 발생하는 것을 해결해 줌..
  
flutter:
  assets:
    - assets/images/
```

### add home_screen.dart and modify main.dart

- /lib/screens/home_screen.dart
```dart
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('home screen'),
    );
  }
}
```

- /lib/main.dart
```dart
import 'package:flutter/material.dart';
import 'package:random_dice/screens/home_screen.dart';

void main() {
  runApp(
    MaterialApp(
      home: HomeScreen(),
    ),
  );
}
```

### add a theme to MaterialApp of main.dart

- /lib/main.dart
```dart
import 'package:flutter/material.dart';
import 'package:random_dice/consts/colors.dart';
import 'package:random_dice/screens/home_screen.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: backgroudColor,
        // Slider widget theme
        sliderTheme: SliderThemeData(
          thumbColor: primaryColor, // 노브 색상
          activeTickMarkColor: primaryColor, // 노브가 이동한 트랙 색상
          // 노브가 아직 이동하지 않은 트랙 색상
          inactiveTrackColor: primaryColor.withAlpha((0.3*255).toInt()), 
        ),
        // BottomNavigationBar widget theme
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: primaryColor,
          unselectedItemColor: secondaryColor,
          backgroundColor: backgroudColor,
        ),
      ),
      home: HomeScreen(),
    ),
  );
}
```

### add root_screen.dart

- /lib/screens/root_screen.dart

### add TabBarView widget and BottomNavigationBar widget to root_screen.dart

- /lib/screens/root_screen.dart
```dart
class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(children: renderChildren()),
      bottomNavigationBar: renderBottomNavigation(),      
    );
  }
  
  List<Widget> renderChildren() {
    return [];
  }
  
  BottomNavigationBar renderBottomNavigation(){
    return BottomNavigationBar(items: []);
  }
  
}
```

### modify home: to main.dart

home: RootScreen(),
- lib/main.dart
```dart
import 'package:flutter/material.dart';
import 'package:random_dice/consts/colors.dart';
import 'package:random_dice/screens/root_screen.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: backgroudColor,
        // Slider widget theme
        sliderTheme: SliderThemeData(
          thumbColor: primaryColor, // 노브 색상
          activeTickMarkColor: primaryColor, // 노브가 이동한 트랙 색상
          // 노브가 아직 이동하지 않은 트랙 색상
          inactiveTrackColor: primaryColor.withAlpha((0.3*255).toInt()),
        ),
        // BottomNavigationBar widget theme
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: primaryColor,
          unselectedItemColor: secondaryColor,
          backgroundColor: backgroudColor,
        ),
      ),
      home: RootScreen(),
    ),
  );
}
```

### convert RootScreen from StatelessWidget to StatefulWidget in RootScreen


TabBarView는 TabController이 필수이다. 
TabController을 초기화하려면 vsync 기능이 필요한데 
이는 State widget에 TrickerProviderMixin을 mixin으로 제공해줘야 사용할 수 있다.
그래서 StatelessWidget을 StatefulWidget으로 변경하고,
TabBarView와 bottomNavigationBar을 구현한다.
- /lib/screens/root_screen.dart
```dart
/// RootScreen widget = TabBarView widget + BottomNavigationBar widget
class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView( // 탭 화면을 보여줄 위젯
        children: renderChildren(),
      ),
      // 아래 탭 내비게이션을 구현하는 매개변수
      bottomNavigationBar: renderBottomNavigation(),
    );
  }

  List<Widget> renderChildren() {
    return [];
  }

  BottomNavigationBar renderBottomNavigation() {
    // 탭 내비게이션을 구현하는 위젯
    return BottomNavigationBar(items: []);
  }
}
```

### TabBarView: add TabController to State widget

TabController 사용방법
- StatefulWidget로 변경 후 State Widget에서 아래 작업
1. TickerProviderStateMixin 사용 
2. TabController 선언
3. controller 초기화 
4. controller 등록

- /lib/screens/root_screen.dart
```dart
/// TabBarView는 TabController가 필수이다.
/// TabController를 초기화하려면 vsync 기능이 필요한데
/// 이는 State 위젯에 TickerProviderStateMixin을 mixin으로 제공해줘야 한다.
/// TabController는 위젯이 생성될 때 단 한 한 번만 초기화되어야 하니
/// RootScreen을 StatefulWidget으로 변경하고 initState()에서 초기화 한다.
/// 
/// TabController를 사용하기 위해서는 TickerProvider가 필요하다. 
/// TickerProvider는 Ticker 클래스를 생성하는 클래스로 
/// 애니메이션 프레임당 한 번씩 콜백을 호출할 수 있게 해 준다. 
/// Ticker가 필요한 애니메이션이 한 개라면 SingleTickerProviderStateMixin,
/// 여러 개 라면 TickerProviderStateMixin을 사용한다.
/// TickerProviderStateMixin은 애니메이션 효율을 담당하며, 
/// flutter는 기기가 지원하는 대로 60FPS(초당 60프레임)~ 120FPS를 지원하며
/// TickerProviderStateMixin을 사용하면 정확히 한 틱(1FPS)마다 애니메이션을 실행한다.
class _RootScreenState extends State<RootScreen> with TickerProviderStateMixin {
  // 3.1. TickerProviderStateMixin 사용
  // 3.2. TabController 선언
  TabController? controller; 
  
  @override 
  void initState() {    
    super.initState();
    
    // 3.3 controller 초기화(length = 탭 개수)
    controller = TabController(length: 2, vsync: this); 
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        // 3.4. TabBarView에 controller 등록
        controller: controller,
        // 탭 화면을 보여줄 위젯
        children: renderChildren(),
      ),
      // 아래 탭 내비게이션을 구현하는 매개변수
      bottomNavigationBar: renderBottomNavigation(),
    );
  }

  List<Widget> renderChildren() {
    return [];
  }

  BottomNavigationBar renderBottomNavigation() {
    // 탭 내비게이션을 구현하는 위젯
    return BottomNavigationBar(items: []);
  }
}
```

### implement renderBottomNavigation()

- /lib/screens/root_screen.dart
```dart
  BottomNavigationBar renderBottomNavigation() {
    // 탭 내비게이션을 구현하는 위젯
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.edgesensor_high_outlined,
          ),
          label: 'dice',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.settings,
          ),
          label: 'config',
        ),
      ],
    );
  }
```


### implement renderChildren()

- /lib/screens/root_screen.dart
```dart
  // TabBarView의 children: 각 탭을 표현해줄 위젯
  List<Widget> renderChildren() {
    return [
      Container(
        // 홈 탭
        child: Center(
          child: Text(
            'tab 1',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      Container(
        child: Center(
          child: Text(
            'tab 2',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      )
    ];
  }
```

### Run

앱화면에서 tab 1 화면을 왼쪽으로 스와이프 하면 tab 2로 전환됨
- BottomNavigationBar의 탭을 눌러도 이동되지 않는다. 다음으로 구현

### 각 BottomNavigationBar를 눌러 화면 전환 되도록 TabController를 연동

BottomNavigationBar를 누를 때마다 TabBarVie와 연동하게 하기

- 3.6. 각 BottomNavigationBar를 눌러 화면 전환 되도록 TabController를 연동
- 3.6.1. addListener: 컨트롤러 속성이 변경될 때마다 실핼할 함수 등록
- 3.6.2. 리스너로 사용할 함수. controller 속성이 변경될 때마다 build()를 재실행
- 3.6.3. dispose: addListener를 사용해서 listener를 등록하면 위젯이 삭제될 때 
항상 등록된 listener도 같이 삭제해줘야 한다.
위젯이 삭제될 때 실행되는 dispose()함수를 오버라이드해서 controller에 붙은 리스너를 삭제한다.
- 3.6.4. BottomNavigationBar: 현재 화면에 렌더링되는 탭의 인덱스.  
BottomNavigationBar에서 현재 선택된 상태로 표시해야 하는 BottomNavigationBarItem의 index 설정
=> TabBarView와 같은 탭의 인덱스를 바라보게 한다.
- 3.6.5. BottomNavigationBar: 탭이 선택될 때마다 실행되는 함수.  
BottomNavigationBarItem이 눌릴 때마다 실행되는 함수이며 매개변수로 눌린 탭의 인덱스를 전달한다.
탭을 눌렀을 때 TabBarView와 화면을 동기화해줘야 해서  
animateTo()함수를 사용해서 애니메이션으로 지정한 탭으로 TabBarView를 전환한다.

- /lib/screens/root_screen.dart
```dart
class _RootScreenState extends State<RootScreen> with TickerProviderStateMixin {
  // 3.1. TickerProviderStateMixin 사용
  // 3.2. TabController 선언
  TabController? controller;

  @override
  void initState() {
    super.initState();

    // 3.3. controller 초기화(length = 탭 개수)
    controller = TabController(length: 2, vsync: this);

    // 3.6. 각 BottomNavigationBar를 눌러 화면 전환 되도록 TabController를 연동
    // 3.6.1. 컨트롤러 속성이 변경될 때마다 실핼할 함수 등록
    controller!.addListener(tabListener);
  }

  // 3.6.2. 리스너로 사용할 함수. controller 속성이 변경될 때마다 build()를 재실행
  tabListener() {
    setState(() {
    });
  }

  // 3.6.3. addListener를 사용해서 listener를 등록하면 
  // 위젯이 삭제될 때 항상 등록된 listener도 같이 삭제해줘야 한다.
  // 위젯이 삭제될 때 실행되는 dispose()함수를 오버라이드해서 controller에 붙은 리스너를 삭제한다.
  @override
  void dispose() {
    // TODO: implement dispose
    controller!.removeListener(tabListener); // 3.6.3. 리스너에 등록한 함수 등록 취소
    super.dispose();
  }

  // ...

  // 3.5. renderBottomNavigation 구현
  // bottomNavigationBar: renderBottomNavigation()
  BottomNavigationBar renderBottomNavigation() {
    // 탭 내비게이션을 구현하는 위젯
    return BottomNavigationBar(
            // 3.6.4. 현재 화면에 렌더링되는 탭의 인덱스
            currentIndex: controller!.index,
            // 3.6.5. 탭이 선택될 때마다 실행되는 함수
            onTap: (int index) {
      setState(() {
        controller!.animateTo(index);
      });
    },
    items: [
```

### implement HomeScreen

- /lib/screens/home_screen.dart
```dart
/// 주사위 이미지 + text
///
/// 숫자는 RootScreen 위젯에서 정해서 생성자를 통해 입력받음
class HomeScreen extends StatelessWidget {
  final int number; // 주사위 숫자, RootScreen에서 넘겨 받음

  //const HomeScreen({required this.number, Key? key}) : super(key: key);
  const HomeScreen({required this.number, super.key}); // 동일함

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image.asset('asstes/images/$number.png'),
        ),
        SizedBox(
          height: 32.0,
        ),
        Text(
          'Lucky number',
          style: TextStyle(
            color: secondaryColor,
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: 32.0,
        ),
        Text(
          number.toString(),
          style: TextStyle(
            color: primaryColor,
            fontSize: 60.0,
            fontWeight: FontWeight.w200,
          ),
        )
      ],
    );
  }
}

```


### renderChildren: from a Container widget to a HomeScreen widget

- /lib/screens/root_screen.dart
```dart
List<Widget> renderChildren() {
  return [
    HomeScreen(number:1),
```

### implement SettingsScreen

add Slider widget
- onChanged 매개변수로 입력받은 현잿값을 State에 저장하고: root_screen - onthreshold(double val) 
- 다시 value 매개변수에 같은 값을 입력하는 형태로:  setting_screen - value: threshold
- silder widget이 구현된다.

- /lib/screens/settings_screen.dart
```dart
import 'package:flutter/material.dart';
import 'package:random_dice/consts/colors.dart';

class SettingsScreen extends StatelessWidget {
  final double threshold; // Slider의 현잿값
  final ValueChanged<double> onThresholdChage; // Slider가 변경될 때마다 실행되는 함수

  const SettingsScreen({
    super.key,
    required this.threshold,
    required this.onThresholdChage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              Text(
                'sensibility',
                style: TextStyle(
                  color: secondaryColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
        ),
        Slider(
          min: 0.1,
          max: 10.0,
          divisions: 101, // 최솟값과 최대값 사이의 구간 개수
          value: threshold,
          onChanged: onThresholdChage,
          label: threshold.toStringAsFixed(1), // slicer값을 소수점 1 자리까지 표시
        ),
      ],
    );
  }
}
```


### renderChildren: from a Container widget to a SettingsScreen widget

RootScreen에서 SettingsScreen 호출, 
RootScreen에서 Slider 위젯의 현잿값과 onChanged 매개변수를 입력받음 
- /lib/screens/root_screen.dart
```dart
class _RootScreenState extends State<RootScreen> with TickerProviderStateMixin {  
  double threshold = 2.7; // settings_screen의 민감도의 기본값
  
  // TabBarView의 children: 각 탭을 표현해줄 위젯
  List<Widget> renderChildren() {
    return [
      HomeScreen(number: 1),
      SettingsScreen(threshold: threshold, onThresholdChage: onThresholdChage)
    ];
  }
  
  // 슬라이더값 변경 시 실행 함수
  // 매개변수로 입력받은 현잿값을 State에 저장
  void onThresholdChage(double val) {
    setState(() {
      threshold = val;
    });
  }
```


### Apply shake plugin

핸드폰을 흔들 때마다 매번 새로운 숫자를 생성
- HomeScreen()에 들어갈 number 매개변수를 number 변수로 선언(4.1)
- Shake plugin이 핸드폰 흔들기를 감지할 때마다 실행할 함수를 등록(4.2)
- 

```dart
class _RootScreenState extends State<RootScreen> with TickerProviderStateMixin {
  // 3.1. TickerProviderStateMixin 사용
  // 3.2. TabController 선언
  TabController? controller; //TabBarView에 사용
  double threshold = 2.7; // settings_screen의 민감도의 기본값
  int number = 1; // 주사위 숫자
  ShakeDetector? shakeDetector; // 4.1.1. 핸드폰 흔들기를 감지할 변수

  @override
  void initState() {
    super.initState();

    // 3.3 controller 초기화(length = 탭 개수)
    controller = TabController(length: 2, vsync: this);

    // 3.6. 각 BottomNavigationBar를 눌러 화면 전환 되도록 TabController를 연동
    // 3.6.1. 컨트롤러 속성이 변경될 때마다 실핼할 함수 등록
    controller!.addListener(tabListener);

    // 4.2 Shake 구현
    // 4.2.1. 흔들기 감지를 즉시 시작
    shakeDetector = ShakeDetector.autoStart(
      onPhoneShake: onPhoneShake, // 감지 후 실행할 함수
      shakeThresholdGravity: threshold, // 감지 민감도
      shakeSlopTimeMS: 100, // 감지 주기
    );
  }

  // 4.2.2. 흔들기 감지 후 실행할 함수
  void onPhoneShake() {
    final rand = new Random();

    setState(() {
      number = rand.nextInt(5) + 1; // 0~5 + 1
    });
  }

  // 3.6.3. addListener를 사용해서 listener를 등록하면
  // 위젯이 삭제될 때 항상 등록된 listener도 같이 삭제해줘야 한다.
  // 위젯이 삭제될 때 실행되는 dispose()함수를 오버라이드해서 controller에 붙은 리스너를 삭제한다.
  @override
  void dispose() {
    controller!.removeListener(tabListener); // 3.6.3. 리스너에 등록한 함수 등록 취소
    shakeDetector!.stopListening(); // 4.2.3. 흔들기 감지 중지
    super.dispose();
  }

  // TabBarView의 children: 각 탭을 표현해 줄 위젯
  List<Widget> renderChildren() {
    return [
      HomeScreen(number: number), // 4.1.2. number 사용
      SettingsScreen(threshold: threshold, onThresholdChage: onThresholdChage)
    ];
  }
```