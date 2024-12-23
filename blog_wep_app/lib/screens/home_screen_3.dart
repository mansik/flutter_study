import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// 웹뷰 구현하기
class HomeScreen extends StatelessWidget {
  // 2. WebViewController 선언
  // JavaScriptMode.unrestricted: JavaScript가 제한 없이 실행 된다.
  WebViewController webViewController = WebViewController()
    ..loadRequest(Uri.parse('https://blog.codefactory.ai'))
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
      ),
      // 3. 웹뷰 위젯 생성
      body: WebViewWidget(controller: webViewController),
    );
  }
}
