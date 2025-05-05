import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coaching_institude/view/webview_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {

  List<Map<String,dynamic>> _mockTests = [];
  bool _isLoading = true;

  @override
  void initState(){
    getMockTests();

    super.initState();
  }

  Future<void> getMockTests() async {
    QuerySnapshot docs = await FirebaseFirestore.instance.collection('MockTest').get();
    _mockTests = docs.docs.map((doc){
      return {'id':doc.id,'url':doc['url']};
    }).toList();
    setState((){
      _isLoading= false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mock Test'),
        backgroundColor: Colors.deepPurple, // Optional: set the background color
      ),
      body:
       _isLoading ? Center(child: CircularProgressIndicator()) :
      ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _mockTests.length,
        itemBuilder: (context, index) {
          final topic = _mockTests[index];
          return InkWell(
            onTap: ()async {     
              log('${_mockTests[index]}');

                               Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => WebViewScreen(url: topic['url'],))
                      );
                        
                    
                  
                  //  final url='https://docs.google.com/forms/d/e/1FAIpQLSdt4b4dL-pM0RkF1yS2DPEkrS2X27W_R-wNZFdH5O8nDVGUQg/viewform?usp=header';
                  //    if(await canLaunch(url))
                  // 
                  //    await launch(url);

            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              elevation: 6,
              margin: const EdgeInsets.only(bottom: 18),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  children: [
                    
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.deepPurple.shade100,
                      child: Icon(
                        Icons.circle,
                        color: Colors.deepPurple,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Text(
                        topic['id'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      
      
      //  Center(
      //   child: Column(
      //     children: [
      //       Padding(
      //         padding: EdgeInsets.all(8.0),
      //         child: OutlinedButton(
      //           onPressed: () async {
      //             Navigator.push(
      //               context,
      //               MaterialPageRoute (
      //                 builder:
      //                     (context) =>  WebViewScreen(
      //                       url:
      //                           'https://docs.google.com/forms/d/e/1FAIpQLSdt4b4dL-pM0RkF1yS2DPEkrS2X27W_R-wNZFdH5O8nDVGUQg/viewform?usp=header',
      //                     ),
      //               ),
      //             );
      //             //  final url='https://docs.google.com/forms/d/e/1FAIpQLSdt4b4dL-pM0RkF1yS2DPEkrS2X27W_R-wNZFdH5O8nDVGUQg/viewform?usp=header';
      //             //    if(await canLaunch(url))
      //             //     await launch(url);
      //           },
      //           child: Text('Practice Set 1'),
      //         ),
      //       ),

      //       Padding(
      //         padding: EdgeInsets.all(8.0),
      //         child: OutlinedButton(
      //           onPressed: () async {
      //              Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                 builder:
      //                     (context) => WebViewScreen(
      //                       url:
      //                           'https://docs.google.com/forms/d/e/1FAIpQLSdt4b4dL-pM0RkF1yS2DPEkrS2X27W_R-wNZFdH5O8nDVGUQg/viewform?usp=header',
      //                     ),
      //               ),
      //             );
      //           },
      //           child: Text('Practice Set 2'),
      //         ),
      //       ),

      //       Padding(
      //         padding: EdgeInsets.all(8.0),
      //         child: OutlinedButton(
      //           onPressed: () async {
      //             Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                 builder:
      //                     (context) => WebViewScreen(
      //                       url:
      //                           'https://docs.google.com/forms/d/e/1FAIpQLSdt4b4dL-pM0RkF1yS2DPEkrS2X27W_R-wNZFdH5O8nDVGUQg/viewform?usp=header',
      //                     ),
      //               ),
      //             );
      //           },
      //           child: Text('Practice Set 3'),
      //         ),
      //       ),

      //       Padding(
      //         padding: EdgeInsets.all(8.0),
      //         child: OutlinedButton(
      //           onPressed: () async {
      //             Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                 builder:
      //                     (context) => WebViewScreen(
      //                       url:
      //                           'https://docs.google.com/forms/d/e/1FAIpQLSdt4b4dL-pM0RkF1yS2DPEkrS2X27W_R-wNZFdH5O8nDVGUQg/viewform?usp=header',
      //                     ),
      //               ),
      //             );
      //           },
      //           child: Text('Practice Set 4'),
      //         ),
      //       ),

      //       Padding(
      //         padding: EdgeInsets.all(8.0),
      //         child: OutlinedButton(
      //           onPressed: () async {
      //              Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                 builder:
      //                     (context) => WebViewScreen(
      //                       url:
      //                           'https://docs.google.com/forms/d/e/1FAIpQLSdt4b4dL-pM0RkF1yS2DPEkrS2X27W_R-wNZFdH5O8nDVGUQg/viewform?usp=header',
      //                     ),
      //               ),
      //             );
      //           },
      //           child: Text('Practice Set 5'),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
