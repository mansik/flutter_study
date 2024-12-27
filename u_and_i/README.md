# u_and_i

A new Flutter project.

만난 지 며칠 U&I

상태관리, CupertinoWidget , CupertinoDatePicker, Dialog, DateTime

Flutter의 2가지 디자인 시스템: 
- 구글의 머티리얼 디자인을 기반으로 하는 Material Widget 
- iOS 스타일의 디자인인 Cupertino Widget

[StatefulWidget, StatelessWidget LifeCytle](https://parkjh7764.tistory.com/185)

## Features

- 사용자가 직접 원하는 날짜 선택
- 날짜 선택시 실시간으로 화면의 D-Day 및 만난 날 업데이트

## Usage

1. 가운데 하트 클릭해서 날짜 선택 기능 실행
2. 년, 월, 일을 스크롤해서 원하는 날짜 선택
3. 배경을 눌러서 날짜 저장하기 및 되돌아오기

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Steps

### fonts, images fold 생성

- /assets/images
- /fonts
image 및 폰트를 위에 만든 폴더에 넣기

### modify pubspec.yaml to add assets, fonts keys

add assets, fonts keys and execute `pub get`

- pubspec.yaml
```yaml
flutter:
  uses-material-design: true

  assets:
    - assets/images/

  fonts:
    - family: parisienne
      fonts:
        - asset: fonts/Parisienne-Regular.ttf
    - family: sunflower
      fonts:
        - asset: fonts/Sunflower-Light.ttf
        - asset: fonts/Sunflower-Medium.ttf
          weight: 500
        - asset: fonts/Sunflower-Bold.ttf
          weight: 700
```

### create a home screen with StatelessWidget

먼저 StatelessWidget으로 생성해서 작업 후 StatefulWidget로 변경한다.
- /lib/screens/home_screen.dart
```dart
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

### modify main.dart

- /lib/main.dart
```dart
void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}

```

### add _DDay widget and _CoupleImage to the HomeScreen widget

- /lib/screens/home_screen.dart
```dart
class _DDay extends StatelessWidget {  
  @override
  Widget build(BuildContext context) {
    return Text('DDay widget');
  }
}

class _CoupleImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Couple image widget');
  }
}
```

### change background color

- /lib/screens/home_screen.dart
```dart
  @override
    Widget build(BuildContext context) {
      return Scaffold(
          backgroundColor: Colors.pink[100], // 100% opacity(불투명)
```

### implement the _CoupleImage widget(구현), add Image

이미지 중앙 정렬 및 화면의 반만큼 높이 구현

|.of 생성자
|| MediaQuery.of(context)는 현재 위젯 트리에서 가장 가까이에 있는 MedisQuery값을 찾아낸다. 
|| 여기서는 MaterialApp에 있는 MediaQuery값이므로 
|| MediaQuery.of(context).size.height는 MaterialApp의 높이를 의미한다.

- /lib/screens/home_screen.dart
```dart
class _CoupleImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/images/middle_image.png',
        height: MediaQuery.of(context).size.height / 2, // 이미지 높이를 화면의 반으로 설정
      ),
    );
  }
}
```

### implement the _DDay widget(구현), add text, icon

- /lib/screens/home_screen.dart
```dart
class _DDay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16.0), // 공백
        Text(
          'U&I',
        ),
        const SizedBox(height: 16.0),
        Text(
          '우리 처음 만난 날',
        ),
        const SizedBox(height: 16.0),
        Text(
          '2024.12.25',
        ),
        const SizedBox(height: 16.0),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.favorite,
          ),
        ),
        const SizedBox(height: 16.0),
        Text(
          'D+365',
        ),
      ],
    );
  }
}
```

### add theme in MaterialApp to main.dart

text widget의 기본 스타일을 변경하기 위해서 theme를 사용

main.dart에서 MaterialApp에 theme 매개변수를 사용하여, fontFamily, textTheme 정의
- ThemeData의 매개변수:
  - fontFamily
  - textTheme
  - tabBarTheme
  - appBarTheme
  - floatingActionButtonTheme
  - ...
- /lib/main.dart
```dart

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      fontFamily: 'sunflower',
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          color: Colors.white,
          fontSize: 80.0,
          fontWeight: FontWeight.w700, // 두께
          fontFamily: 'parisienne',
        ),
        headlineMedium: TextStyle(
          color: Colors.white,
          fontSize: 50.0,
          fontWeight: FontWeight.w700,
        ),
        bodyLarge: TextStyle(
          color: Colors.white,
          fontSize: 30.0,
        ),
        bodyMedium: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),
      ),
    ),
    home: HomeScreen(),
  ));
}
```

### add style to Text widget in _DDay widget

1. 테마 불러오기
2. text widget에 style 적용하기
3. Icon에 색상 적용하기

- /lib/screens/home_screen.dart
```dart
class _DDay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 1. 테마 불러오기
    final textTheme = Theme.of(context).textTheme;
    
    return Column(
      children: [
        const SizedBox(height: 16.0), // 공백
        Text(
          'U&I',
          style: textTheme.headlineLarge, // 2. 스타일 적용
        ),
        const SizedBox(height: 16.0),
        Text(
          '우리 처음 만난 날',
          style: textTheme.bodyLarge,
        ),
        const SizedBox(height: 16.0),
        Text(
          '2024.12.25',
          style: textTheme.bodyMedium,
        ),
        const SizedBox(height: 16.0),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.favorite,
            color: Colors.red, // 3. 색상 변경
          ),
        ),
        const SizedBox(height: 16.0),
        Text(
          'D+365',
          style: textTheme.headlineLarge,
        ),
      ],
    );
  }
}
```

### add Expanded to _CoupleImage widget

핸드폰의 화면 크기가 작을 경우 오버플로가 발생하지 않게 하기 위해서 Expanded 사용

Expanded: 이미지를 남는 공간 만큼만 차지하도록 한다.

- /lib/screens/home_screen.dart
```dart
class _CoupleImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 핸드폰의 화면 크기가 작을 경우 오버플로가 발생하지 않게 하기 위해서 Expanded 사용
    // Expanded: 이미지를 남는 공간 만큼만 차지하도록 한다.
    return Expanded(
      child: Center(
        child: Image.asset(
          'assets/images/middle_image.png',
          height: MediaQuery.of(context).size.height / 2, // 이미지 높이를 화면의 반으로 설정
        ),
      ),
    );
  }
}
```

### convert HomeScreen from a StatelessWidget to a State

### add onPress function to Heart button

하트 버튼 눌렀을 때 실행할 함수 구현(4.1~)
- HomeScreen은 StatefulWidget로 상태관리가 가능하지만, _DDay는 StatelessWidget로 상태 관리가 불가능하다.
하트 버튼의 onPressed 매개변수가 _DDay 위젯에 위치해 있어서 _HomeScreenState에서 버튼이 눌렀을 때 콜백을 받을 수 없다.
_DDay 위젯에 하트 아이콘을 눌렀을 때 실행되는 콜백 함수를 매개변수로 노출해서 _HomeScreenState에서 상태 관리를 하도록 한다.

- /lib/screens/home_screen.dart
```dart
class _HomeScreenState extends State<HomeScreen> {
  DateTime firstDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100], // 100% opacity(불투명)
      body: SafeArea(
        // 시스템 UI 피해서 UI 그리기
        top: true,
        bottom: false,

        // 위아래 배치
        child: Column(
          // 위아래 끝에 위젯 배치하고 처음과 마지막 위젯 사이는 균일하게 배치
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // 반대축 최대 크기로 늘리기
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _DDay(
              // 4.5. 하트 눌렀을 때 실행할 함수 전달
              onHeartPressed: onHeartPressed, 
            ),
            _CoupleImage(),
          ],
        ),
      ),
    );
  }
  // 4.4. Heart button 을 눌렀을 때 실행할 함수
  void onHeartPressed() {
    print('clicked');
  }
}

class _DDay extends StatelessWidget {
  // 4.1. Heart button 눌렀을 때 실행항 함수(GestureTapCallback는 typedef
  final GestureTapCallback onHeartPressed;

  // 4.2 생성자에 상위에서 함수를 입력받도록 매개변수 구현
  const _DDay({required this.onHeartPressed});

  @override
  Widget build(BuildContext context) {
    // 1. 테마 불러오기
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        const SizedBox(height: 16.0), // 공백
        Text(
          'U&I',
          style: textTheme.headlineLarge, // 2. 스타일 적용
        ),
        const SizedBox(height: 16.0),
        Text(
          '우리 처음 만난 날',
          style: textTheme.bodyLarge,
        ),
        const SizedBox(height: 16.0),
        Text(
          '2024.12.25',
          style: textTheme.bodyMedium,
        ),
        const SizedBox(height: 16.0),
        IconButton(
          iconSize: 60.0,
          onPressed: onHeartPressed, // 4.3. 아이콘 눌렀을 때 실행할 함수
          icon: Icon(
            Icons.favorite,
            color: Colors.red,
          ),
        ),
        const SizedBox(height: 16.0),
        Text(
          'D+365',
          style: textTheme.headlineMedium,
        ),
      ],
    );
  }
}
```

### implement first Day text and DDay

5.1~

- /lib/screens/home_screen.dart
```dart
class _HomeScreenState extends State<HomeScreen> {
  DateTime firstDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100], // 100% opacity(불투명)
      body: SafeArea(
        // 시스템 UI 피해서 UI 그리기
        top: true,
        bottom: false,

        // 위아래 배치
        child: Column(
          // 위아래 끝에 위젯 배치하고 처음과 마지막 위젯 사이는 균일하게 배치
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // 반대축 최대 크기로 늘리기
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _DDay(
              // 4.5. 하트 눌렀을 때 실행할 함수 전달
              onHeartPressed: onHeartPressed,
              firstDay: firstDay,
            ),
            _CoupleImage(),
          ],
        ),
      ),
    );
  }
  // 4.4. Heart button 을 눌렀을 때 실행할 함수
  void onHeartPressed() {
    print('clicked');
  }
}

class _DDay extends StatelessWidget {
  // 4.1. Heart button 눌렀을 때 실행할 함수(GestureTapCallback는 typedef
  final GestureTapCallback onHeartPressed;

  // 5.1. 사귀기 시작한 날
  final DateTime firstDay;

  // 4.2 생성자에 상위에서 함수를 입력받도록 매개변수 구현
  const _DDay({
    required this.onHeartPressed,
    required this.firstDay, // 5.2 매개변수로 입력 받기
  });

  @override
  Widget build(BuildContext context) {
    // 1. 테마 불러오기
    final textTheme = Theme.of(context).textTheme;
    final now = DateTime.now(); // 5.3 현재 날짜시간

    return Column(
      children: [
        const SizedBox(height: 16.0), // 공백
        Text(
          'U&I',
          style: textTheme.headlineLarge, // 2. 스타일 적용
        ),
        const SizedBox(height: 16.0),
        Text(
          '우리 처음 만난 날',
          style: textTheme.bodyLarge,
        ),
        const SizedBox(height: 16.0),
        Text(
          '${firstDay.year}.${firstDay.month}.${firstDay.day}', // 5.4. firstday 입력
          style: textTheme.bodyMedium,
        ),
        const SizedBox(height: 16.0),
        IconButton(
          iconSize: 60.0,
          onPressed: onHeartPressed, // 4.3. 아이콘 눌렀을 때 실행할 함수
          icon: Icon(
            Icons.favorite,
            color: Colors.red,
          ),
        ),
        const SizedBox(height: 16.0),
        Text(
          'D+${DateTime(now.year,now.month, now.day).difference(firstDay).inDays + 1}', // 5.5. DDay 계산
          style: textTheme.headlineMedium,
        ),
      ],
    );
  }
}
```

### add setState()

(6.1~)
setState()를 이용해서 StatefulWidget의 상태관리를 하며, build()가 재실행 된다.
- setState(): 매개변수에 함수를 입력하고, 함수에 변경하고 싶은 변숫값을 지정해서 사용한다.
- /lib/screens/home_screen.dart
```dart
  void onHeartPressed() {
    // 6.1 상태 변경시 setState() 함수 실행
    // 매개변수에 함수를 입력하고 함수에 변경하고 싶은 변숫값을 지정한다.
    setState(() {
      firstDay = firstDay.subtract(Duration(days: 1)); // firstDay 변수에서 하루 빼기
    });
  }
```

### add show CupertinoDialog

(7.1~)
- /lib/screens/home_screen.dart
```dart
  void onHeartPressed() {
    // 7.1 CupertinoDialog 열기
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        // 날짜 선택하는 다이얼로그
        return CupertinoDatePicker(
          mode: CupertinoDatePickerMode.date, // 시간을 제회한 날짜만 선택하기
          onDateTimeChanged: (DateTime date) {},
        );
      },
    );
    // // 6.1 상태 변경시 setState() 함수 실행
    // // 매개변수에 함수를 입력하고 함수에 변경하고 싶은 변숫값을 지정한다.
    // setState(() {
    //   firstDay = firstDay.subtract(Duration(days: 1)); // firstDay 변수에서 하루 빼기
    // });
  }
```

### 화면 아래에서 300pixel만 CupertinoDatePicker가 차지하게 하고, CupertinoDatePicker 배경을 흰색으로 변경

(8.1~)
- Align widget: 자식 위젯을 어떻게 위치시킬지 정할 수 있다.
- showCupertinoDialog의 barrierDismissible: true (배경을 눌렀을 때 다이얼로그 닫기)
- /lib/screens/home_screen.dart
```dart
  void onHeartPressed() {
    // 7.1 CupertinoDialog 열기
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        // 8.1 화면 아래에서 300pixel만 CupertinoDatePicker가 차지하게 하고
        // CupertinoDatePicker 배경을 흰색으로 변경
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.white,
            height: 300,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date, // 시간을 제회한 날짜만 선택하기
              onDateTimeChanged: (DateTime date) {},
            ),
          ),
        );  
      },
      barrierDismissible: true, // 외부(배경) 탭할 경우 다이얼로그 닫기
    );
  }
```

### CupertinoDatePicker의 날짜 값이 변경될 때마다 firstDay값을 변경하기

(9.1~)
setState() 함구 구현
```dart
  void onHeartPressed() {
    // 7.1 CupertinoDialog 열기
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        // 8.1 화면 아래에서 300pixel만 CupertinoDatePicker가 차지하게 하고
        // CupertinoDatePicker 배경을 흰색으로 변경
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.white,
            height: 300,
            // 날짜 선택하는 다이얼로그
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date, // 시간을 제회한 날짜만 선택하기
              onDateTimeChanged: (DateTime date) {
                // 9.1 상태 변경시 setState() 함수 실행
                // 매개변수에 함수를 입력하고 함수에 변경하고 싶은 변숫값을 지정한다.
                setState(() {
                  firstDay = date;
                });
              }, // 날짜가 변경되면 실행되는 함수
            ),
          ),
        );

      },
      barrierDismissible: true, // 외부(배경) 탭할 경우 다이얼로그 닫기
    );
  }
```
