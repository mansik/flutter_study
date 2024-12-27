import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// CupertinoDatePicker의 날짜 값이 변경될 때마다 firstDay값을 변경하기
///
/// setState() 함수 구현
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

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

        // 날짜 선택하는 다이얼로그
        // return CupertinoDatePicker(
        //   mode: CupertinoDatePickerMode.date, // 시간을 제회한 날짜만 선택하기
        //   onDateTimeChanged: (DateTime date) {},
        // );
      },
      barrierDismissible: true, // 외부(배경) 탭할 경우 다이얼로그 닫기
    );

    // // 6.1 상태 변경시 setState() 함수 실행
    // // 매개변수에 함수를 입력하고 함수에 변경하고 싶은 변숫값을 지정한다.
    // setState(() {
    //   firstDay = firstDay.subtract(Duration(days: 1)); // firstDay 변수에서 하루 빼기
    // });
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
          '${firstDay.year}.${firstDay.month}.${firstDay.day}',
          // 5.4. firstday 입력
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
          'D+${DateTime(now.year, now.month, now.day).difference(firstDay).inDays + 1}', // 5.5. DDay 계산
          style: textTheme.headlineMedium,
        ),
      ],
    );
  }
}

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
