import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// 앱의 기본 홈 화면으로 사용
class HomeScreen extends StatelessWidget {
  // 2. WebViewController 선언
  // JavaScriptMode.unrestricted: JavaScript가 제한 없이 실행 된다.
  WebViewController webViewController = WebViewController()
    ..loadRequest(Uri.parse('https://google.com/'))
    ..setJavaScriptMode(JavaScriptMode.unrestricted);

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. 앱바 위젯 추가, Scaffold에 추가한다.
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Title"),
        centerTitle: true, // 가운데 정렬

        // 4. appbar에 액션 버튼을 추가할 수 있는 매개변수
        // actions: 우측끝에 위젯이 생성됨
        actions: [
          IconButton(
            onPressed: () {
              webViewController.loadRequest(Uri.parse('https://google.com/'));
            },
            icon: Icon(Icons.home),
          ),
        ],
      ),
      // 3. 웹뷰 위젯 생성
      body: WebViewWidget(controller: webViewController),
    );
  }
}
