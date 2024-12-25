import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// AppBar에 홈 버튼 추가
class HomeScreen extends StatelessWidget {
  // 2. WebViewController 선언
  // JavaScriptMode.unrestricted: JavaScript가 제한 없이 실행 된다.
  WebViewController webViewController = WebViewController()
    ..loadRequest(Uri.parse('https://google.com/'))
    ..setJavaScriptMode(JavaScriptMode.unrestricted);

  HomeScreen({super.key}); // const 인스턴스를 생성, 리소스를 적게 사용

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. 앱바 위젯 추가, Scaffold에 추가한다.
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Title"),
        centerTitle: true, // 가운데 정렬

        // 4. appbar에 액션 버튼을 추가할 수 있는 매개변수
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
