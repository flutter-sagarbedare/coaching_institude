// LecturePage.dart
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coaching_institude/view/video_home.dart';
import 'package:coaching_institude/view/yt_api_services.dart';
import 'package:flutter/material.dart';



class LecturePage extends StatefulWidget {
   LecturePage({super.key});

  @override
  State<LecturePage> createState() => _LecturePageState();
}

class _LecturePageState extends State<LecturePage> {
  bool _isLoading = false;
  String url = "";
List<Map<String, dynamic>> _lecturesList = [];

  @override
  void initState(){

    getTopics();


    super.initState();
  }
  getTopics()async{
      // QuerySnapshot docs = await FirebaseFirestore.instance.collection('Lectures').;
      
       final querySnapshot = await FirebaseFirestore.instance
          .collection('Lectures')
          .get();
      _lecturesList = querySnapshot.docs.map((doc) {
        return {'id': doc.id, 'url': doc['url']};
      }).toList();
      // List<Map<String,dynamic>> data = docs as  List<Map<String,dynamic>>;
      // log("${data[0]}");

      // log("lectures list ${_lecturesList[0]}");
      setState((){});
      
  }

  // final List<Map<String, dynamic>> topics = const [
  //   {'title': 'MS-CIT', 'icon': Icons.computer, },
  //   {'title': 'Tally', 'icon': Icons.calculate, },
  //    {'title': 'C', 'icon': Icons.computer, },
  //   {'title': 'JAVA', 'icon': Icons.javascript,},
   
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: const Text(
    'Lecture',
    style: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),
        backgroundColor: Colors.deepPurple,
      ),



      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _lecturesList.length,
        itemBuilder: (context, index) {
          final topic = _lecturesList[index];
          return InkWell(
            onTap: ()async {     
              log('${_lecturesList[index]}');

                var videos = await YtApiServices().getAllVideosFromPlaylist(_lecturesList[index]['url']);
                setState((){});
                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                  return YoutubeHomePage(videos: videos) ;
                }));
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
      backgroundColor: const Color(0xFFF1F2F7),
    );
  }
}