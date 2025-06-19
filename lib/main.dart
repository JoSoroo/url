import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WebViewExample(),
    );
  }
}

class WebViewExample extends StatefulWidget {
  @override
  _WebViewExampleState createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<WebViewExample> {
  late final WebViewController _controller;
  String currentUrl = '';
  
  // URL харуулахын тулд тоо бүрт тохирох URL-ийг хадгална.
  final Map<int, String> urlMap = {
    1: 'http://192.168.51.35:8088/display',
    2: '',
    3: 'http://192.168.53.35:8088/display',
    4: 'http://192.168.54.35:8088/display',
    5: 'http://192.168.55.35:8088/display',
    6: 'http://192.168.56.35:8088/display',
    7: 'http://192.168.57.35:8088/display',
    8: 'http://192.168.58.35:8088/display',
    9: 'http://192.168.59.35:8088/display',
    10: 'http://192.168.50.35:8088/display',
    11: '',
    12: 'http://192.168.49.35:8088/display',
  };

  bool _showAppBar = true;  // AppBar-ийг харуулах эсэхийг хянах хувьсагч

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              currentUrl = url;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              currentUrl = url;
            });
          },
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _showAppBar
          ? AppBar(
              title: Text('Шөлөндөө салбар сонгох'),
              actions: [
                // Тоо сонгох хэсэг
                PopupMenuButton<int>(
                  onSelected: (int value) {
                    setState(() {
                      currentUrl = urlMap[value]!;
                      _controller.loadRequest(Uri.parse(currentUrl)); // WebView-аар тухайн URL-ийг ачаалах
                      _showAppBar = false;  // URL сонгогдсоны дараа AppBar-г нууцлах
                    });
                  },
                  itemBuilder: (BuildContext context) {
                    return List.generate(12, (index) {
                      int number = index + 1;
                      return PopupMenuItem<int>(
                        value: number,
                        child: Text('Салбар $number'),
                      );
                    });
                  },
                ),
              ],
            )
          : null,  // AppBar-ийг харахгүй болгох
      body: Column(
        children: [
          // WebView хэсэг
          Expanded(
            child: WebViewWidget(controller: _controller),
          ),
        ],
      ),
    );
  }
} 