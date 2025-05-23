 import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NotesTopicScreen extends StatefulWidget {
  final String topicId;
  const NotesTopicScreen({super.key,required this.topicId});

  @override
  State<NotesTopicScreen> createState() => _NotesTopicScreenState();
}

class _NotesTopicScreenState extends State<NotesTopicScreen> {
  List<Map<String,dynamic>> _notesTopicList = [];
  List<Map<String,dynamic>> _topicLinks = [];
  bool _isLoading = true;

  @override
  void initState(){

    print(_notesTopicList);

    getNotesTopics();
    super.initState();
  }
  void getTopicsLinks(Map<String, dynamic> item,int index)async{
        log('item id = ${item['id']}');
       final querySnapshot = await FirebaseFirestore.instance
          .collection('Notes')
          .doc(widget.topicId)
          .collection('topics')
          .doc(item['id'])
          
          .get();

          // _topicLinks = querySnapshot.docs.map((doc){
          //   return {'id':doc.id};
          // }).toList();
        String url = querySnapshot.data()!['url'];
        print("Topics Links = $url");
        

             if(await canLaunch(url))
                  await launch(url);


  }
  
  getNotesTopics()async{
    log(widget.topicId);

    // DocumentSnapshot docs = await FirebaseFirestore.instance.collection('Notes').doc(widget.topicId).get();

    // _notesTopicList = docs.docs.map((doc){
    //   return {'id':doc.id};
    // }).toList();

    // _notesTopicList = docs.data() as List<Map<String,dynamic>>;
      final querySnapshot = await FirebaseFirestore.instance
          .collection('Notes')
          .doc(widget.topicId)
          .collection('topics')
          .get();

      _notesTopicList = querySnapshot.docs.map((doc) {
        return {'id': doc.id,};
      }).toList();
    
      
      setState(() {
        _isLoading = false;
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



      body: _isLoading ? Center(child:CircularProgressIndicator()):
      
      ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _notesTopicList.length,
        itemBuilder: (context, index) {
          final notesTopicItem = _notesTopicList[index];
          return InkWell(
            onTap: () async {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (_) => topic['page']),
              // );
                //   final url='https://cetcell.mahacet.org/wp-content/uploads/2023/12/Syllabus.pdf';

            

                      //  Navigator.of(context).push(
                      //   MaterialPageRoute(builder: (context) => WebViewScreen(url:,))
                      // );
    getTopicsLinks(notesTopicItem,index);

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
                        Icons.note,
                        color: Colors.deepPurple,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Text(
                        notesTopicItem['id'],
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

  }
  }