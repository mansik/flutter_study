import 'package:flutter/material.dart';

/// TabBarView: add TabController to State widget
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

  @override void initState() {
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
