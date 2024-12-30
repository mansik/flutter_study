import 'package:flutter/material.dart';

/// 각 BottomNavigationBar를 눌러 화면 전환 되도록 TabController를 연동
///
/// RootScreen widget = TabBarView widget + BottomNavigationBar widget
class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

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

  // 3.5. renderBottomNavigation 구현
  // bottomNavigationBar: renderBottomNavigation()
  BottomNavigationBar renderBottomNavigation() {
    // 탭 내비게이션을 구현하는 위젯
    return BottomNavigationBar(
      // 3.6.3. 현재 화면에 렌더링되는 탭의 인덱스
      currentIndex: controller!.index,
      // 3.6.4. 탭이 선택될 때마다 실행되는 함수
      onTap: (int index) {
        setState(() {
          controller!.animateTo(index);
        });
      },
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
}
