import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coaching_institude/main.dart';
import 'package:coaching_institude/view/questions_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopicsScreen extends StatefulWidget {
  final String subjectId;

  const TopicsScreen({super.key, required this.subjectId});

  @override
  State<TopicsScreen> createState() => _TopicsScreenState();
}

class _TopicsScreenState extends State<TopicsScreen> {
  List<Map<String,dynamic>> _topics = [];
  bool _isLoading = true;



   @override
  void initState(){
    getMCQTopicData();
    super.initState();
  }

 
   void getMCQTopicData()async {
    //  DocumentSnapshot docs =await FirebaseFirestore.instance.collection('MCQ').doc('zkBlnljsOl4Utc5oIZ2q').get() ;

    // mcqs.add(docs.data() as Map<String,dynamic>);
   await Provider.of<QuizProvider>(context,listen:false).fetchTopics(widget.subjectId);
   _topics =  Provider.of<QuizProvider>(context,listen:false).topics;
   setState(() {
     
   _isLoading = false;
   });
   log("$_topics");

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text("Quiz Test"),
        backgroundColor: Colors.deepPurple,
      ),
      body:
      _isLoading ? Center(child: CircularProgressIndicator()) :
      ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _topics.length,
        itemBuilder: (context, index) {
          final topic = _topics[index];
          return InkWell(
            onTap: ()async {     
              log('${_topics[index]}');

                               Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => QuestionsScreen(subjectId: widget.subjectId, topicId: topic['name']))
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
      // Column(
      //   children: [
      //      Padding(
      //       padding: const EdgeInsets.all(18.0),
      //       child: Row(
      //           children: [
                 
      //             Text("Greate to see you again!!",
      //              style:TextStyle(
      //               fontSize:16,
      //               fontWeight:FontWeight.w500,
      //               color:Color.fromRGBO(131,76,52,1)
      //             )
      //             )
      //           ],
      //       ),
      //     ),

      //      SizedBox(
      //   height: 500,
      //    child: Consumer<QuizProvider>(
      //     builder: (context, quizProvider, _) {    
      //         var topics = quizProvider.topics;



              
      //         log('$topics');
      //         return ListView.builder(
      //           itemCount: topics.length,
      //           itemBuilder: (context ,index){
      //             final topic = topics[index];
      //           return Padding(
      //             padding: const EdgeInsets.only(left:20.0,right:20),
      //             child: GestureDetector(
      //               onTap:(){
      //                 //  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
      //                 //                   // log("$mcqs['Question']");
      //                 //                   return QuestionsScreen(subjectId:widget.subjectId,topicId:topic);
      //                 //                 }));
                      
      //                 Navigator.of(context).pushReplacement(
      //                   MaterialPageRoute(builder: (context) => QuestionsScreen(subjectId: widget.subjectId, topicId: topic['name']))
      //                 );
      //               },
      //               child: Container(
      //                             height: 80,
      //                             width:360,
      //                             decoration: BoxDecoration(
      //               color:Color.fromRGBO(255, 237, 217, 1),
      //               borderRadius: BorderRadius.circular(15)
      //                             ),
      //                             child: Row(
      //               crossAxisAlignment: CrossAxisAlignment.center,
      //               mainAxisAlignment: MainAxisAlignment.start,
      //               children:[
      //                 Padding(
      //                   padding: const EdgeInsets.all(8.0),
      //                   child: Container(
      //                     height:50,
      //                     width:30,
      //                     color:Colors.white,
      //                     child: Center(
      //                       child:Icon(Icons.question_answer_sharp),
      //                     ),
      //                   ),
      //                 ),
      //                 const SizedBox(
      //                   width:20
      //                 ),
      //                     Text("${topic['name']}",
      //                     style:TextStyle(
      //                       fontSize:20,
      //                       fontWeight:FontWeight.w700,
      //                       color:Color.fromRGBO(131,76,52,1)
      //                     )
      //                     ),
      //                     Spacer(),
      //                     IconButton(onPressed: (){
                                 
      //                             // addData();
      //                     },
      //                     color:Colors.red,
      //                   icon: Icon(Icons.arrow_forward_ios),
      //                             )]
      //                             ),
                                 
      //                           ),
      //             ),
      //           );
      //         });
         
         
      //     },
      //    ))
      
      
      //     // Expanded(
      //     //   child: StreamBuilder<QuerySnapshot>(
      //     //     stream:FirebaseFirestore.instance.collection('Subjects').doc(widget.subjectId).collection('topics').snapshots(),
      //     //      builder: (context,snapshot){
      //     //       final topics = snapshot.data!.docs;

      //     //         if(){
      //     //     return CircularProgressIndicator();
      //     //   }    

            
      //     //         return ListView.builder(
      //     //           itemCount: topics.length,
      //     //           itemBuilder: (context,index){
      //     //              if (!snapshot.hasData) return CircularProgressIndicator();
      //     //             final topic = topics[index];
      //     //             return Padding(
      //     //               padding: const EdgeInsets.only(left:20.0,right:20),
      //     //               child: GestureDetector(
      //     //                 onTap:(){
      //     //                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
      //     //                               // log("$mcqs['Question']");
      //     //                               return QuestionsScreen(subjectId:widget.subjectId,topicId:topic.id);
      //     //                             }));
            
      //     //                 },
      //     //                 child: Container(
      //     //                               height: 80,
      //     //                               width:360,
      //     //                               decoration: BoxDecoration(
      //     //                 color:Color.fromRGBO(255, 237, 217, 1),
      //     //                 borderRadius: BorderRadius.circular(15)
      //     //                               ),
      //     //                               child: Row(
      //     //                 crossAxisAlignment: CrossAxisAlignment.center,
      //     //                 mainAxisAlignment: MainAxisAlignment.start,
      //     //                 children:[
      //     //                   Padding(
      //     //                     padding: const EdgeInsets.all(8.0),
      //     //                     child: Container(
      //     //                       height:50,
      //     //                       width:30,
      //     //                       color:Colors.white,
      //     //                       child: Center(
      //     //                         child:Icon(Icons.question_answer_sharp),
      //     //                       ),
      //     //                     ),
      //     //                   ),
      //     //                   const SizedBox(
      //     //                     width:20
      //     //                   ),
      //     //                       Text("${topic['name']}",
      //     //                       style:TextStyle(
      //     //                         fontSize:20,
      //     //                         fontWeight:FontWeight.w700,
      //     //                         color:Color.fromRGBO(131,76,52,1)
      //     //                       )
      //     //                       ),
      //     //                       Spacer(),
      //     //                       IconButton(onPressed: (){
                                       
      //     //                               // addData();
      //     //                       },
      //     //                       color:Colors.red,
      //     //                     icon: Icon(Icons.arrow_forward_ios),
      //     //                               )]
      //     //                               ),
                                       
      //     //                             ),
      //     //               ),
      //     //             );
      //     //           });
      //     //      }),
      //     // ),
      //   ],
      // )
      );
    
  }
}