import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coaching_institude/view/notes_topic_screen.dart';
import 'package:coaching_institude/view/webview_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  List<Map<String,dynamic>> _notesList = [];
  bool _isLoading = true;

    @override
  void initState(){
    getNotes();

    super.initState();
  }

  Future<void> getNotes() async {
    log('in get notes ');
    QuerySnapshot docs = await FirebaseFirestore.instance.collection('Notes').get();
    _notesList = docs.docs.map((doc){
      return {'id':doc.id};
    }).toList();
    setState((){
      _isLoading= false;
    });
  }



  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
       appBar: AppBar(
        title: const Text(
    'Notes',
    style: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),
        backgroundColor: Colors.deepPurple,
      ),



      body:
      _isLoading ? Center(child: CircularProgressIndicator()) :
       ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _notesList.length,
        itemBuilder: (context, index) {
          final topic = _notesList[index];
          return InkWell(
            onTap: () async {
              // final topic = _notesList[index];        

                       Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => NotesTopicScreen(topicId:topic['id']))
                      );

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
                       Icons.subject,
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
      backgroundColor: const Color(0xFFF1F2F7),
    );

    
    // Scaffold(
  //     appBar: AppBar(
  //       title: Text("Notes Page"),
  //       backgroundColor: Colors.blue,
  //     ),
  //     body: Column(
  //       children: [
  //         Center(
  //           child: Container(
  //             child: Container(
  //               padding: const EdgeInsets.all(16.0),
  //               child: OutlinedButton(
  //                 style: OutlinedButton.styleFrom(
  //                   side: BorderSide(color: Colors.deepPurple, width: 2),
  //                   padding: EdgeInsets.symmetric(horizontal: 40, vertical: 18),
  //                   shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(30),
  //                   ),
  //                   textStyle: TextStyle(
  //                     fontSize: 20,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                   foregroundColor: Colors.deepPurple, // Text and splash color
  //                 ),
  //                 onPressed: () async{
  //                 final url='https://cetcell.mahacet.org/wp-content/uploads/2023/12/Syllabus.pdf';
  //                if(await canLaunch(url))
  //                 await launch(url);
                    
  //                 },
  //                 child: Text("English Notes"),
  //               ),
  //             ),
  //           ),
  //         ),

  // Container(
  //           child: Container(
  //             padding: const EdgeInsets.all(16.0),
  //             child: OutlinedButton(
  //               style: OutlinedButton.styleFrom(
  //                 side: BorderSide(color: Colors.deepPurple, width: 2),
  //                 padding: EdgeInsets.symmetric(horizontal: 40, vertical: 18),
  //                 shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(30),
  //                 ),
  //                 textStyle: TextStyle(
  //                   fontSize: 20,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //                 foregroundColor: Colors.deepPurple, // Text and splash color
  //               ),
  //               onPressed: () {
  //                 ScaffoldMessenger.of(context).showSnackBar(
  //                   SnackBar(content: Text("Button Clicked!")),
  //                 );
  //               },
  //               child: Text("English Notes"),
  //             ),
  //           ),
  //         ),

  //           Container(
  //           child: Container(
  //             padding: const EdgeInsets.all(16.0),
  //             child: OutlinedButton(
  //               style: OutlinedButton.styleFrom(
  //                 side: BorderSide(color: Colors.deepPurple, width: 2),
  //                 padding: EdgeInsets.symmetric(horizontal: 40, vertical: 18),
  //                 shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(30),
  //                 ),
  //                 textStyle: TextStyle(
  //                   fontSize: 20,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //                 foregroundColor: Colors.deepPurple, // Text and splash color
  //               ),
  //               onPressed: () {
  //                 ScaffoldMessenger.of(context).showSnackBar(
  //                   SnackBar(content: Text("Button Clicked!")),
  //                 );
  //               },
  //               child: Text("Marathi Notes"),
  //             ),
  //           ),
  //         ),

  //           Container(
  //           child: Container(
  //             padding: const EdgeInsets.all(16.0),
  //             child: OutlinedButton(
  //               style: OutlinedButton.styleFrom(
  //                 side: BorderSide(color: Colors.deepPurple, width: 2),
  //                 padding: EdgeInsets.symmetric(horizontal: 40, vertical: 18),
  //                 shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(30),
  //                 ),
  //                 textStyle: TextStyle(
  //                   fontSize: 20,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //                 foregroundColor: Colors.deepPurple, // Text and splash color
  //               ),
  //               onPressed: () {
  //                 ScaffoldMessenger.of(context).showSnackBar(
  //                   SnackBar(content: Text("Button Clicked!")),
  //                 );
  //               },
  //               child: Text("Hindi Notes"),
  //             ),
  //           ),
  //         ),


  //       ],
  //     ),
    // );
 
 
    
 
  }
}
