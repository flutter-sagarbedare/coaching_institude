import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coaching_institude/main.dart';
import 'package:coaching_institude/view/quiz_result.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuestionsScreen extends StatefulWidget {
  final String subjectId;
  final String topicId;
  const QuestionsScreen({
    super.key,
    required this.subjectId,
    required this.topicId,
  });

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  late final dynamic questions;
  // @override
  // void initState() {
  //   getMCQData();
  //   super.initState();
  // }

  // void getMCQData() async {
  //   //  DocumentSnapshot docs =await FirebaseFirestore.instance.collection('MCQ').doc('zkBlnljsOl4Utc5oIZ2q').get() ;

  //   // mcqs.add(docs.data() as Map<String,dynamic>);
  //   await Provider.of<QuizProvider>(
  //     context,
  //     listen: false,
  //   ).fetchQuestions(widget.subjectId, widget.topicId);

  //   questions =
  //       await Provider.of<QuizProvider>(context, listen: false).questions;
  // }

  int queIndex = 1;
  late int questionCount = 0;

  void validateSelectedAnswer(bool isTrue) {
    log("validate ans ");
    if (isTrue) {
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.white,
            child: SizedBox(
              height: 200,
              width: 200,
              child: Padding(
                padding: const EdgeInsets.all(26.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "You Answer is Correct",
                      style: TextStyle(fontSize: 20),
                    ),

                    ElevatedButton(
                      onPressed: () async {
                        // Navigator.of(context).pushReplacement(
                        //   MaterialPageRoute(builder: (context) => QuizResult()),
                        // );
                        // setState(() {
                        // queIndex++;
                          
                        // });
                        _nextQuestion();
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.green),
                      ),
                      child: SizedBox(
                        height: 50,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Next",
                                style: TextStyle(color: Colors.white),
                              ),
                              const SizedBox(width: 20),
                              Icon(
                                Icons.navigate_next_sharp,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.white,
            child: SizedBox(
              height: 200,
              width: 200,
              child: Padding(
                padding: const EdgeInsets.all(26.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("You Answer is Wrong", style: TextStyle(fontSize: 20)),

                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(() {});
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.red),
                      ),
                      child: SizedBox(
                        height: 50,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Try Again",
                                style: TextStyle(color: Colors.white),
                              ),
                              const SizedBox(width: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }
   int _currentQuestionIndex = 0;

  @override
  void initState() {
    super.initState();
    final quizProvider = Provider.of<QuizProvider>(context, listen: false)
        .fetchQuestions(widget.subjectId, widget.topicId);
         questionCount = Provider.of<QuizProvider>(context, listen: false).questions.length;
    
  }

  void _nextQuestion() {
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);
   

    if (_currentQuestionIndex < quizProvider.questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      // Optionally handle quiz end
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You have completed the quiz!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Questions')),
      body: Consumer<QuizProvider>(
        builder: (context, quizProvider, _) {
          if (quizProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (quizProvider.questions.isEmpty) {
            return Center(child: Text('No questions available'));
          }

          final currentQuestion = quizProvider.questions[_currentQuestionIndex];

          return Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Math Quiz",
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(131, 76, 52, 1),
                  ),
                ),
              ],
            ),
            Row(children: [
              Text('${_currentQuestionIndex} / ${questionCount}')]),
            SizedBox(
              height: 500,
              width: 500,
              child: Consumer<QuizProvider>(
                builder: (context, quizProvider, _) {
                  if (quizProvider.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (quizProvider.questions.isEmpty) {
                    return Center(child: Text('No questions available'));
                  }
                  final questions = quizProvider.questions;

                  final question = questions[queIndex];

                  return ListView(
                    children: [
                      Column(
                        children: [
                          Wrap(
                            children: [
                              Text(
                                "Q${_currentQuestionIndex + 1}: ${currentQuestion['question']}",
                                style: TextStyle(
                                  fontSize: 27,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromRGBO(131, 76, 52, 1),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 500,
                            child: ListView.separated(
                              itemCount: (currentQuestion['options'] as List<dynamic>).length,
                              separatorBuilder: (context, index) {
                                return const SizedBox(height: 50);
                              },
                              itemBuilder: (context, index) {
                                 final option = (currentQuestion['options'] as List<dynamic>)[index];
                                return GestureDetector(
                                  onTap:(){
                                   if( question['options'][index] == question['answer']){
                                      validateSelectedAnswer(true);
                                      queIndex++;
                                   }else{
                                      validateSelectedAnswer(false);
                                    
                                   }
                                  },
                                  child: Container(
                                    height: 80,
                                    width: 360,
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(255, 237, 217, 1),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(width: 20),
                                        SizedBox(height: 20),

                                        Spacer(),
                                        Icon(Icons.arrow_forward_ios),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                  // return ListView.builder(
                  //   itemCount: queIndex,
                  //   itemBuilder: (context, index) {
                  //     final q = quizProvider.questions[index];
                  //     return Card(
                  //       margin: EdgeInsets.all(8),
                  //       child: ListTile(
                  //         title: Text(q['question']),
                  //         subtitle: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: (q['options'] as List<String>).map((opt) {
                  //             return Text("- $opt");
                  //           }).toList(),
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // );
                },
              ),
            ),
          ],
        ));
      
    
        },
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     //  backgroundColor: const Color.fromRGBO(35, 40, 61, 1),
  //     appBar: AppBar(
  //       // backgroundColor:const Color.fromRGBO(255, 255, 255, 0) ,
  //       title: Text("Quiz"),
  //     ),
  //     body: Padding(
  //       padding: const EdgeInsets.all(18.0),
  //       child: Column(
  //         children: [
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Text(
  //                 "Math Quiz",
  //                 style: TextStyle(
  //                   fontSize: 27,
  //                   fontWeight: FontWeight.w700,
  //                   color: Color.fromRGBO(131, 76, 52, 1),
  //                 ),
  //               ),
  //             ],
  //           ),
  //           Row(children: [Text("12/"), Text("20")]),
  //           SizedBox(
  //             height: 500,
  //             width: 500,
  //             child: Consumer<QuizProvider>(
  //               builder: (context, quizProvider, _) {
  //                 if (quizProvider.isLoading) {
  //                   return Center(child: CircularProgressIndicator());
  //                 }

  //                 if (quizProvider.questions.isEmpty) {
  //                   return Center(child: Text('No questions available'));
  //                 }
  //                 final questions = quizProvider.questions;

  //                 final question = questions[queIndex];

  //                 return ListView(
  //                   children: [
  //                     Column(
  //                       children: [
  //                         Wrap(
  //                           children: [
  //                             Text(
  //                               "${question['question']}",
  //                               style: TextStyle(
  //                                 fontSize: 27,
  //                                 fontWeight: FontWeight.w700,
  //                                 color: Color.fromRGBO(131, 76, 52, 1),
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                         const SizedBox(height: 20),
  //                         SizedBox(
  //                           height: 500,
  //                           child: ListView.separated(
  //                             itemCount: 4,
  //                             separatorBuilder: (context, index) {
  //                               return const SizedBox(height: 50);
  //                             },
  //                             itemBuilder: (context, index) {
  //                               return GestureDetector(
  //                                 onTap:(){
  //                                  if( question['options'][index] == question['answer']){
  //                                     validateSelectedAnswer(true);
  //                                     queIndex++;
  //                                  }else{
  //                                     validateSelectedAnswer(false);
                                    
  //                                  }
  //                                 },
  //                                 child: Container(
  //                                   height: 80,
  //                                   width: 360,
  //                                   decoration: BoxDecoration(
  //                                     color: Color.fromRGBO(255, 237, 217, 1),
  //                                     borderRadius: BorderRadius.circular(15),
  //                                   ),
  //                                   child: Row(
  //                                     crossAxisAlignment:
  //                                         CrossAxisAlignment.center,
  //                                     mainAxisAlignment:
  //                                         MainAxisAlignment.start,
  //                                     children: [
  //                                       const SizedBox(width: 20),
  //                                       Text(
  //                                         "${question['options'][index]}",
  //                                         style: TextStyle(
  //                                           fontSize: 20,
  //                                           fontWeight: FontWeight.w700,
  //                                           color: Color.fromRGBO(
  //                                             131,
  //                                             76,
  //                                             52,
  //                                             1,
  //                                           ),
  //                                         ),
  //                                       ),
  //                                       Spacer(),
  //                                       Icon(Icons.arrow_forward_ios),
  //                                     ],
  //                                   ),
  //                                 ),
  //                               );
  //                             },
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 );
  //                 // return ListView.builder(
  //                 //   itemCount: queIndex,
  //                 //   itemBuilder: (context, index) {
  //                 //     final q = quizProvider.questions[index];
  //                 //     return Card(
  //                 //       margin: EdgeInsets.all(8),
  //                 //       child: ListTile(
  //                 //         title: Text(q['question']),
  //                 //         subtitle: Column(
  //                 //           crossAxisAlignment: CrossAxisAlignment.start,
  //                 //           children: (q['options'] as List<String>).map((opt) {
  //                 //             return Text("- $opt");
  //                 //           }).toList(),
  //                 //         ),
  //                 //       ),
  //                 //     );
  //                 //   },
  //                 // );
  //               },
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}


// class QuestionsPage extends StatelessWidget {
//   final String subjectId;
//   final String topicId;
//   QuestionsPage({required this.subjectId, required this.topicId});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Questions')),
//       body: Consumer<QuizProvider>(
//         builder: (context, quizProvider, _) {
//           if (quizProvider.isLoading) {
//             return Center(child: CircularProgressIndicator());
//           }

//           if (quizProvider.questions.isEmpty) {
//             // Trigger fetch
//             quizProvider.fetchQuestions(subjectId: subjectId, topicId: topicId);
//             return Center(child: CircularProgressIndicator());
//           }

//           return ListView.builder(
//             itemCount: quizProvider.questions.length,
//             itemBuilder: (context, index) {
//               final q = quizProvider.questions[index];
//               return Card(
//                 child: ListTile(
//                   title: Text(q['question']),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: q['options'].map<Widget>((opt) {
//                       return Text("- $opt");
//                     }).toList(),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }



// // class QuestionScreen extends StatefulWidget {

// //   final String queId;
// //   final String subId;
// //  const QuestionScreen({super.key, required this.queId,required this.subId});

// //   @override
// //   State<QuestionScreen> createState() => _QuestionScreenState();
// // }

// // class _QuestionScreenState extends State<QuestionScreen> {
// //   int selectedOptionIndex = 0;



// //   void validateSelectedAnswer() {
// //     log("validate ans ");
// //     if (selectedOptionIndex == 0) {
// //       showDialog(
// //         context: context,
// //         builder: (context) {
// //           return Dialog(
// //             backgroundColor: Colors.white,
// //             child: SizedBox(
// //               height: 200,
// //               width: 200,
// //               child: Padding(
// //                 padding: const EdgeInsets.all(26.0),
// //                 child: Column(
// //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                   crossAxisAlignment: CrossAxisAlignment.center,
// //                   children: [
// //                     Text(
// //                       "You Answer is Correct",
// //                       style: TextStyle(fontSize: 20),
// //                     ),

// //                     ElevatedButton(
// //                       onPressed: () async{
// //                          Navigator.of(context).pushReplacement(MaterialPageRoute(
// //                           builder:(context)=> QuizResult()
// //                         ));

                        
                        
// //                       },
// //                       style: ButtonStyle(
// //                         backgroundColor: WidgetStatePropertyAll(
// //                           Colors.green,
// //                         ),
// //                       ),
// //                       child: SizedBox(
// //                         height: 50,
// //                         child: Center(
// //                           child: Row(
// //                             mainAxisAlignment: MainAxisAlignment.center,
// //                             children: [
// //                               Text(
// //                                 "Next",
// //                                 style: TextStyle(color: Colors.white),
// //                               ),
// //                               const SizedBox(
// //                                 width:20
// //                               ),
// //                               Icon(Icons.navigate_next_sharp,
// //                               color:Colors.white
// //                               )
// //                             ],
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           );
// //         },
// //       );
// //     } else {
// //       showDialog(
// //         context: context,
// //         builder: (context) {
// //           return Dialog(
// //             backgroundColor: Colors.white,
// //             child: SizedBox(
// //               height: 200,
// //               width: 200,
// //               child: Padding(
// //                 padding: const EdgeInsets.all(26.0),
// //                 child: Column(
// //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                   crossAxisAlignment: CrossAxisAlignment.center,
// //                   children: [
// //                     Text(
// //                       "You Answer is Wrong",
// //                       style: TextStyle(fontSize: 20),
// //                     ),

// //                     ElevatedButton(
// //                       onPressed: () {
// //                         Navigator.of(context).pop(() {});
// //                       },
// //                       style: ButtonStyle(
// //                         backgroundColor: WidgetStatePropertyAll(
// //                           Colors.red,
// //                         ),
// //                       ),
// //                       child: SizedBox(
// //                         height: 50,
// //                         child: Center(
// //                           child: Row(
// //                             mainAxisAlignment: MainAxisAlignment.center,
// //                             children: [
// //                               Text(
// //                                 "Try Again",
// //                                 style: TextStyle(color: Colors.white),
// //                               ),
// //                               const SizedBox(
// //                                 width:20
// //                               ),
                             
// //                             ],
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           );
// //         },
// //       );
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
//     return Scaffold(
//       //  backgroundColor: const Color.fromRGBO(35, 40, 61, 1),
//       appBar: AppBar(
//         // backgroundColor:const Color.fromRGBO(255, 255, 255, 0) ,
//         title: Text("Quiz"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(18.0),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   "Math Quiz",
//                   style: TextStyle(
//                     fontSize: 27,
//                     fontWeight: FontWeight.w700,
//                     color: Color.fromRGBO(131, 76, 52, 1),
//                   ),
//                 ),
//               ],
//             ),
//             Row(children: [Text("12/"), Text("20")]),
           
// //             // Expanded(
// //             //   child: StreamBuilder<QuerySnapshot>(
// //             //           stream:,
// //             //            builder: (context,snapshot){
// //             //             final questions = snapshot.data!.docs;
              
// //             //   return ListView.builder(
// //             //     itemCount: questions.length,
// //             //     itemBuilder: (context,index){
// //             //        if (!snapshot.hasData) return CircularProgressIndicator();
// //             //       final question = questions[index];
// //             //       return  Column(
// //             //         children: [
// //             //           Container(
// //             //             height:100,
// //             //             width:400,
// //             //             color:Colors.red,
// //             //             child:Text("${question['question']}")
// //             //           ),
// //             //           const SizedBox(
// //             //             height:30
// //             //           )
// //             //         ],
// //             //       );
// //             //     });
// //             //            }),
// //             // )

            
// //             SizedBox(
// //                   height:400,
// //                   child: Padding(
// //                       padding: const EdgeInsets.only(left: 20.0, right: 20),
// //                       child: GestureDetector(
// //                         onTap: () {
// //                           validateSelectedAnswer();
                         
// //                         },
// //                         child: Column(
// //                           children: [
// //                              Wrap(
// //                                 children: [
// //                   Text(
// //                     "${question['question']}",
// //                     style: TextStyle(
// //                       fontSize: 27,
// //                       fontWeight: FontWeight.w700,
// //                       color: Color.fromRGBO(131, 76, 52, 1),
// //                     ),
// //                   ),
// //                                 ],
// //                               ),
// //                               const SizedBox(height: 20),
// //                             Container(
// //                               height: 80,
// //                               width: 360,
// //                               decoration: BoxDecoration(
// //                                 color: Color.fromRGBO(255, 237, 217, 1),
// //                                 borderRadius: BorderRadius.circular(15),
// //                               ),
// //                               child: Row(
// //                                 crossAxisAlignment: CrossAxisAlignment.center,
// //                                 mainAxisAlignment: MainAxisAlignment.start,
// //                                 children: [
// //                                   const SizedBox(width: 20),
// //                                   Text(
// //                                     "19 Years",
// //                                     style: TextStyle(
// //                                       fontSize: 20,
// //                                       fontWeight: FontWeight.w700,
// //                                       color: Color.fromRGBO(131, 76, 52, 1),
// //                                     ),
// //                                   ),
// //                                   Spacer(),
// //                                   Icon(Icons.arrow_forward_ios),
// //                                 ],
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     ),
// //                 )

           
// //           ],
// //         ),
// //       ),

// //       // body:
// //     );
// //   }
// // }

// // /*

// //     get questions from firebase 
// //     FirebaseFirestore.instance.collection('Subjects').doc(widget.subId).collection('topics').doc(widget.queId).collection('questions').snapshots()


// // SizedBox(
// //                   height:400,
// //                   child: Padding(
// //                       padding: const EdgeInsets.only(left: 20.0, right: 20),
// //                       child: GestureDetector(
// //                         onTap: () {
// //                           validateSelectedAnswer();
                         
// //                         },
// //                         child: Column(
// //                           children: [
// //                              Wrap(
// //                                 children: [
// //                   Text(
// //                     "${question['question']}",
// //                     style: TextStyle(
// //                       fontSize: 27,
// //                       fontWeight: FontWeight.w700,
// //                       color: Color.fromRGBO(131, 76, 52, 1),
// //                     ),
// //                   ),
// //                                 ],
// //                               ),
// //                               const SizedBox(height: 20),
// //                             Container(
// //                               height: 80,
// //                               width: 360,
// //                               decoration: BoxDecoration(
// //                                 color: Color.fromRGBO(255, 237, 217, 1),
// //                                 borderRadius: BorderRadius.circular(15),
// //                               ),
// //                               child: Row(
// //                                 crossAxisAlignment: CrossAxisAlignment.center,
// //                                 mainAxisAlignment: MainAxisAlignment.start,
// //                                 children: [
// //                                   const SizedBox(width: 20),
// //                                   Text(
// //                                     "19 Years",
// //                                     style: TextStyle(
// //                                       fontSize: 20,
// //                                       fontWeight: FontWeight.w700,
// //                                       color: Color.fromRGBO(131, 76, 52, 1),
// //                                     ),
// //                                   ),
// //                                   Spacer(),
// //                                   Icon(Icons.arrow_forward_ios),
// //                                 ],
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     ),
// //                 );
// //  */