 import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coaching_institude/view/webview_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MoskTestTopicScreen extends StatefulWidget {
  final String topicId;
  const MoskTestTopicScreen({super.key,required this.topicId});

  @override
  State<MoskTestTopicScreen> createState() => _MoskTestTopicScreenState();
}

class _MoskTestTopicScreenState extends State<MoskTestTopicScreen> {
  List<Map<String,dynamic>> _mocktestTopicList = [];
  List<Map<String,dynamic>> _topicLinks = [];
  bool _isLoading = true;

  @override
  void initState(){

    // print(_mocktestTopicList);

    getMockTestTopics();
    super.initState();
  }
  void getTopicsLinks(Map<String, dynamic> item,int index)async{
       final  topicLink = _mocktestTopicList[index]['id'];
         final querySnapshot = await FirebaseFirestore.instance
          .collection('MockTest')
          .doc(widget.topicId)
          .collection('topics').
          doc(topicLink)
          .get();

        // _topicLinks =  querySnapshot as List<Map<String,dynamic>>;
        String myFieldValue = querySnapshot.get('url') as String;


        // if(await canLaunch(myFieldValue))
        //           await launch(myFieldValue);

         Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => WebViewScreen(url: myFieldValue)),
              );



      // print("mock topics list = $_mocktestTopicList");

      //  final querySnapshot = await FirebaseFirestore.instance
      //     .collection('MockTest')
      //     .doc(widget.topicId)
      //     .collection('topics')
      //     .doc(item['id'])
      //     .collection(item['id'])
      //     .get();

          // _topicLinks = await querySnapshot.docs.map((doc){
          //   return {'id':doc.id};
          // }).toList();
          
        print("Topics Links = $_topicLinks");
        



  }
  
 void getMockTestTopics()async{
    log(widget.topicId);

    // DocumentSnapshot docs = await FirebaseFirestore.instance.collection('Notes').doc(widget.topicId).get();

    // _mocktestTopicList = docs.docs.map((doc){
    //   return {'id':doc.id};
    // }).toList();

    // _mocktestTopicList = docs.data() as List<Map<String,dynamic>>;
      final querySnapshot = await FirebaseFirestore.instance
          .collection('MockTest')
          .doc(widget.topicId)
          .collection('topics')
          .get();

        

      _mocktestTopicList = querySnapshot.docs.map((doc) {
        log("doc.id = ${doc.id}");
        return {'id': doc.id,};
      }).toList();
      print("mock topics list = $_mocktestTopicList");
    
      
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
        itemCount: _mocktestTopicList.length,
        itemBuilder: (context, index) {
          final notesTopicItem = _mocktestTopicList[index];
          return InkWell(
            onTap: () async {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (_) => topic['page']),
              // );
                //   final url='https://cetcell.mahacet.org/wp-content/uploads/2023/12/Syllabus.pdf';

                //  if(await canLaunch(url))
                //   await launch(url);

                       
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
                        Icons.circle,
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