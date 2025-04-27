import 'package:coaching_institude/view/webview_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  // @override
  // void initState(){
    

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Page'),
        backgroundColor: Colors.blue, // Optional: set the background color
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: OutlinedButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute (
                      builder:
                          (context) =>  WebViewScreen(
                            url:
                                'https://docs.google.com/forms/d/e/1FAIpQLSdt4b4dL-pM0RkF1yS2DPEkrS2X27W_R-wNZFdH5O8nDVGUQg/viewform?usp=header',
                          ),
                    ),
                  );
                  //  final url='https://docs.google.com/forms/d/e/1FAIpQLSdt4b4dL-pM0RkF1yS2DPEkrS2X27W_R-wNZFdH5O8nDVGUQg/viewform?usp=header';
                  //    if(await canLaunch(url))
                  //     await launch(url);
                },
                child: Text('Practice Set 1'),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(8.0),
              child: OutlinedButton(
                onPressed: () async {
                   Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => WebViewScreen(
                            url:
                                'https://docs.google.com/forms/d/e/1FAIpQLSdt4b4dL-pM0RkF1yS2DPEkrS2X27W_R-wNZFdH5O8nDVGUQg/viewform?usp=header',
                          ),
                    ),
                  );
                },
                child: Text('Practice Set 2'),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(8.0),
              child: OutlinedButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => WebViewScreen(
                            url:
                                'https://docs.google.com/forms/d/e/1FAIpQLSdt4b4dL-pM0RkF1yS2DPEkrS2X27W_R-wNZFdH5O8nDVGUQg/viewform?usp=header',
                          ),
                    ),
                  );
                },
                child: Text('Practice Set 3'),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(8.0),
              child: OutlinedButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => WebViewScreen(
                            url:
                                'https://docs.google.com/forms/d/e/1FAIpQLSdt4b4dL-pM0RkF1yS2DPEkrS2X27W_R-wNZFdH5O8nDVGUQg/viewform?usp=header',
                          ),
                    ),
                  );
                },
                child: Text('Practice Set 4'),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(8.0),
              child: OutlinedButton(
                onPressed: () async {
                   Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => WebViewScreen(
                            url:
                                'https://docs.google.com/forms/d/e/1FAIpQLSdt4b4dL-pM0RkF1yS2DPEkrS2X27W_R-wNZFdH5O8nDVGUQg/viewform?usp=header',
                          ),
                    ),
                  );
                },
                child: Text('Practice Set 5'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
