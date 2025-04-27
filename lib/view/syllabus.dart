import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';

class Syllabus extends StatelessWidget {
  const Syllabus({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Syllabus Page'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 233,),
            Container(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SyllabusPdfViewer(),
                    ),
                  );
                },
                child: const Text("View Syllabus PDF"),
              ),
            ),


            
          Container(
              child:   Padding(
                padding: EdgeInsets.all(8.0),
                child: OutlinedButton(
                  onPressed: () async {
                  final url='https://www.nielit.gov.in/sites/default/files/Syllabus_Core_Java_and_Advanced_Java%20.pdf';
                   if(await canLaunch(url)){
                    await launch(url,forceWebView: true,enableJavaScript: true);
                  
                  }
            
                  },
                   child: const Text('View Syllabus'),
                ),
              ),
          ),
          ],
        ),
      ),
    );
  }
}

class SyllabusPdfViewer extends StatelessWidget {
  const SyllabusPdfViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Syllabus PDF')),
      body:  SfPdfViewer.asset("lib/syllabus/dummy.pdf"), // Replace with your actual PDF path
    );
  }
}
