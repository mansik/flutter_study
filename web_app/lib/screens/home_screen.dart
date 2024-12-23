import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreen extends StatelessWidget {
  WebViewController webViewController = WebViewController()
    ..loadRequest(Uri.parse('https://blog.codefactory.ai'))
    ..setJavaScriptMode(JavaScriptMode.unrestricted); // javascript 제한 없이 허용

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("title"),
        centerTitle: true,
        //action 버튼 추가
        actions: [
          IconButton(
            onPressed: () {
              webViewController.loadRequest(
                Uri.parse('https://blog.codefactory.ai'),
              );
            },
            icon: Icon(
              Icons.home,
            ),
          ),
        ],
      ),
      body: WebViewWidget(controller: webViewController),
    );
  }
}
