import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coaching_institude/main.dart';
import 'package:coaching_institude/view/questions_screen.dart';
import 'package:coaching_institude/view/topics_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuizTestScreen extends StatefulWidget{
  const QuizTestScreen({super.key});

  @override
  State<QuizTestScreen> createState() => _QuizTestScreenState();
}

class _QuizTestScreenState extends State<QuizTestScreen> {
  List<Map<String,dynamic>> subjects = [];

  @override
  void initState(){
    getMCQData();
    super.initState();
  }

  void getMCQData()async {
    //  DocumentSnapshot docs =await FirebaseFirestore.instance.collection('MCQ').doc('zkBlnljsOl4Utc5oIZ2q').get() ;

    // mcqs.add(docs.data() as Map<String,dynamic>);
   await Provider.of<QuizProvider>(context,listen:false).fetchSubjects();

  }

  void addData()async{
    log('in add data');
    dynamic data = {
      'Question':'Who is Founder of C language??',
      'option1':'Steve Jovs',
      'option2':'Denis Ritchie',
      'option3':'Sagar Bedare',
      'option4':'Ganesh',
      'answer':2      
    };
    await FirebaseFirestore.instance.collection('MCQ').add(data);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar:AppBar(
        title:Text("Quiz Test")
      ),
      body:
      Column(
        crossAxisAlignment:CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Text("Hii Sagar",
                         style:TextStyle(
                          fontSize:27,
                          fontWeight:FontWeight.w700,
                          color:Color.fromRGBO(131,76,52,1)
                        )
                        ),
                        Text("Greate to see you again!!",
                         style:TextStyle(
                          fontSize:16,
                          fontWeight:FontWeight.w500,
                          color:Color.fromRGBO(131,76,52,1)
                        )
                        ),                       
            
                    ],
                  )
                ],
            ),
          ),
      
      
       SizedBox(
        height: 500,
         child: Consumer<QuizProvider>(
          builder: (context, quizProvider, _) {        

            log('in consumer');
              subjects = quizProvider.subjects;
              log('$subjects');
              return ListView.builder(
                itemCount: subjects.length,
                itemBuilder: (context ,index){
                  final subject = subjects[index];
                return Padding(
                  padding: const EdgeInsets.only(left:20.0,right:20),
                  child: Container(
                                height: 80,
                                width:360,
                                decoration: BoxDecoration(
                  color:Color.fromRGBO(255, 237, 217, 1),
                  borderRadius: BorderRadius.circular(15)
                                ),
                                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height:50,
                        width:30,
                        color:Colors.white,
                        child: Center(
                          child:Icon(Icons.question_answer_sharp),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width:20
                    ),
                        Text("${subject['name']}",
                        style:TextStyle(
                          fontSize:20,
                          fontWeight:FontWeight.w700,
                          color:Color.fromRGBO(131,76,52,1)
                        )
                        ),
                        Spacer(),
                        IconButton(onPressed: (){
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                                  
                                  return TopicsScreen(subjectId:subject['name']);
                                }));

                                // addData();
                        },
                        color:Colors.red,
                      icon: Icon(Icons.arrow_forward_ios),
                                )]
                                ),
                               
                              ),
                );
              });
         
         
          },
         ),
       )
       
       ]
      ),
    );
  }

}
/*
  @override
  Widget build(BuildContext context){
    return Scaffold(
        //  backgroundColor: const Color.fromRGBO(35, 40, 61, 1),

      appBar:AppBar(
        title:Text("Quiz Test")
      ),
      body:Column(
        crossAxisAlignment:CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Text("Hii Sagar",
                         style:TextStyle(
                          fontSize:27,
                          fontWeight:FontWeight.w700,
                          color:Color.fromRGBO(131,76,52,1)
                        )
                        ),
                        Text("Greate to see you again!!",
                         style:TextStyle(
                          fontSize:16,
                          fontWeight:FontWeight.w500,
                          color:Color.fromRGBO(131,76,52,1)
                        )
                        ),                       
            
                    ],
                  )
                ],
            ),
          ),
          // Expanded(
          //   child: ListView.separated(
          //     itemCount:6,
          //     separatorBuilder: (context,index){
          //       return SizedBox(height:20);
          //     },
          //     itemBuilder: (context,index){
          //       return Padding(
          //         padding: const EdgeInsets.only(left:20.0,right:20),
          //         child: Container(
          //                       height: 80,
          //                       width:360,
          //                       decoration: BoxDecoration(
          //         color:Color.fromRGBO(255, 237, 217, 1),
          //         borderRadius: BorderRadius.circular(15)
          //                       ),
          //                       child: Row(
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         children:[
          //           Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: Container(
          //               height:50,
          //               width:30,
          //               color:Colors.white,
          //               child: Center(
          //                 child:Icon(Icons.question_answer_sharp),
          //               ),
          //             ),
          //           ),
          //           const SizedBox(
          //             width:20
          //           ),
          //               Text("Maths",
          //               style:TextStyle(
          //                 fontSize:20,
          //                 fontWeight:FontWeight.w700,
          //                 color:Color.fromRGBO(131,76,52,1)
          //               )
          //               ),
          //               Spacer(),
          //               IconButton(onPressed: (){
          //                       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
          //                         log("$mcqs['Question']");
          //                         return QuestionScreen(mcqs:mcqs);
          //                       }));

          //                       // addData();
          //               },
          //               color:Colors.red,
          //             icon: Icon(Icons.arrow_forward_ios),
          //                       )]
          //                       ),
                               
          //                     ),
          //       );
          //     },
          //   ),
          // ),

        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Subjects').snapshots(),
          builder: (context,snapshot){

            if(!snapshot.hasData) return CircularProgressIndicator();

            final subjects = snapshot.data!.docs;

              return    Expanded(
            child: ListView.separated(
              itemCount:subjects.length,
              separatorBuilder: (context,index){
                return SizedBox(height:20);
              },
              itemBuilder: (context,index){
                final subject = subjects[index];

                return Padding(
                  padding: const EdgeInsets.only(left:20.0,right:20),
                  child: Container(
                                height: 80,
                                width:360,
                                decoration: BoxDecoration(
                  color:Color.fromRGBO(255, 237, 217, 1),
                  borderRadius: BorderRadius.circular(15)
                                ),
                                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height:50,
                        width:30,
                        color:Colors.white,
                        child: Center(
                          child:Icon(Icons.question_answer_sharp),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width:20
                    ),
                        Text("${subject['name']}",
                        style:TextStyle(
                          fontSize:20,
                          fontWeight:FontWeight.w700,
                          color:Color.fromRGBO(131,76,52,1)
                        )
                        ),
                        Spacer(),
                        IconButton(onPressed: (){
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                                  // log("$mcqs['Question']");
                                  return TopicsScreen(subId:subject.id);
                                }));

                                // addData();
                        },
                        color:Colors.red,
                      icon: Icon(Icons.arrow_forward_ios),
                                )]
                                ),
                               
                              ),
                );
              },
            ),
          );
          },

        )
          
        ],
      )
    );
  }
}

*/