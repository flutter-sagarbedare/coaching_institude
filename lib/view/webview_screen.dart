import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget{
  final String url;
  
  const WebViewScreen({
    super.key, required this.url
  });

  @override
  State createState(){
    return _WebViewScreenState();
  }
}

class _WebViewScreenState extends State<WebViewScreen>{
   late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    WebViewPlatform.instance;
    _controller = WebViewController()
      ..loadRequest(Uri.parse(widget.url))
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("MCQ"),
      ),
      body:
      WebViewWidget(controller: _controller)
    );
  }
}