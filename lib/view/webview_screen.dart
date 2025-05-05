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
  
  Future<bool> _onWillPop(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure?'),
        content: Text('Do you want to exit this screen?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false), // Stay
            child: Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true), // Exit
            child: Text('Yes'),
          ),
        ],
      ),
    ) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:()=> _onWillPop(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Test"),
          backgroundColor:Colors.deepPurple
        ),
        body:
        // Padding(
        //   padding: const EdgeInsets.only(bottom:8.0),
        //   child: Column(children: [
        //     Container(
        //       height: 50,
        //       color:Colors.deepPurple,
        //       child: Row(
        //         children: [
        //           const SizedBox(width:10),
                  
      
        //           IconButton(onPressed: (){
                      
      
        //           }, icon: Icon(Icons.arrow_back_ios,color:Colors.white)),
        //           const SizedBox(width:20),
        //           Text("Test",
        //           style:TextStyle(
        //             fontSize: 20,
        //             fontWeight: FontWeight.bold,
        //             color:Colors.white
        //           ))
        //         ],
        //       ),
        //     ),
        //   SizedBox(
        //     height: MediaQuery.sizeOf(context).height-100,
            // child:
             WebViewWidget(controller: _controller))
      //             ],
      //     ),
      //   )
      // ),
    );
  }
}