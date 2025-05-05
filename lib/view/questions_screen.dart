import 'dart:developer';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coaching_institude/main.dart';
import 'package:coaching_institude/view/quiz_result.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:auto_size_text/auto_size_text.dart';

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
  dynamic questions;
  bool ansCheck = false;
  int selectedIndex = -1;
  int correctAnsCount = 0;

  @override
  void initState() {
    getMCQData();

    super.initState();
  }

  void getMCQData() async {
    await Provider.of<QuizProvider>(
      context,
      listen: false,
    ).fetchQuestions(widget.subjectId, widget.topicId);

    questions = Provider.of<QuizProvider>(context, listen: false).questions;
    questionCount = questions.length;
    // setState(() {});
  }

  int queIndex = 1;
  late int questionCount = 0;

  void validateSelectedAnswer(bool isTrue) {
    log("validate ans ");
    if (isTrue) {
      showDialog(
  context: context,
  barrierDismissible: false,
  useRootNavigator: false,
  builder: (BuildContext dialogContext) {
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
                "Your Answer is Correct",
                style: TextStyle(fontSize: 20),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop(); // Dismiss dialog

                  Future.delayed(Duration(milliseconds: 300), () {
                    if(_currentQuestionIndex == questionCount -1 ){
                      callResult();
                    }
                    if (_currentQuestionIndex < questionCount - 1 ) {
                      setState(() {
                        queIndex++;
                        _nextQuestion();
                        ansCheck = false;
                        selectedIndex = -1;
                      });
                    } else {
                      callResult(); // Navigate to result screen
                    }
                  });
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
                        Text("Next", style: TextStyle(color: Colors.white)),
                        const SizedBox(width: 20),
                        Icon(Icons.navigate_next_sharp, color: Colors.white),
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
  builder: (BuildContext dialogContext) {
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
              Text("Your Answer is Wrong", style: TextStyle(fontSize: 20)),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop(); // Only close the dialog
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
                        Text("Try Again", style: TextStyle(color: Colors.white)),
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
  void _nextQuestion() {
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);
    if (_currentQuestionIndex < questionCount - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      callResult();
      log('Navigated to QuizResult...');
    }
  }

  void callResult() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return QuizResult(correctAnsCount: correctAnsCount,
          questionCount:questionCount
          );
        },
      ),
    );
  }

  Color buttonColor(int index) {
    if (selectedIndex == -1) {
      return Color.fromRGBO(248, 145, 87, 1); // default color
    } else if (index == selectedIndex) {
      return ansCheck ? Color.fromRGBO(26, 181, 134, 1) : Colors.red;
    } else {
      return Color.fromRGBO(248, 145, 87, 1); // default color
      // other buttons stay normal
    }
  }
  

  Future<bool> _onWillPop(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure?'),
        content: Text('Do you want to exit this screen?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false), // Stay
            child: Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true), // Exit
            child: Text('Yes'),
          ),
        ],
      ),
    ) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:() =>_onWillPop(context),
      child: Scaffold(
        appBar: AppBar(title: Text('Questions')),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<QuizProvider>(
            builder: (context, quizProvider, _) {
              if (quizProvider.isLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (quizProvider.questions.isEmpty ||
                  _currentQuestionIndex >= quizProvider.questions.length) {
                return Center(child: Text('No questions available'));
              }
              final currentQuestion = quizProvider.questions[_currentQuestionIndex];
          
              return Column(
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
                  Row(
                    children: [
                      Text('${_currentQuestionIndex + 1} / ${questionCount}'),
                    ],
                  ),
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
                        height: MediaQuery.sizeOf(context).height-200,
                        child: ListView.builder(
                          itemCount:
                              (currentQuestion['options']
                                      as List<dynamic>)
                                  .length,
                         
                          itemBuilder: (context, index) {
                            final String option =
                                (currentQuestion['options']
                                    as List<dynamic>)[index];
                            return Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedIndex =
                                        index; // set which option clicked
                                    log('in gesture detector');
                                    if (option ==
                                        currentQuestion['answer']) {
                                      ansCheck = true;
                                      correctAnsCount++;
                                           if(_currentQuestionIndex == questionCount -1 ){
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(content: Text(
                                                "Quiz Completed",
                                                style:TextStyle(color:Colors.green)
                                              ))
                                            );
                                              callResult();
                                       }    else{               
                                      validateSelectedAnswer(true);
                                       }
                                    } else {
                                      ansCheck = false;
                                                          
                                      validateSelectedAnswer(false);
                                    }
                                  });
                                },
                                child: Container(
                                  height: 80,
                                  width: 360,
                                  decoration: BoxDecoration(
                                    color: buttonColor(index),
                                    borderRadius: BorderRadius.circular(
                                      15,
                                    ),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(width: 20),
      
                                      Flexible(
                                        child: AutoSizeText(    
                                          minFontSize: 5,                                  
                                            option,
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
                                            ),
                                          ),
                                      ),
                                      
                                      // SizedBox(height: 20),
                                                          
                                      // Spacer(),
                                      // Icon(Icons.arrow_forward_ios),
                                    ],
                                  ),
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
            },
          ),
        ),
      ),
    );
  }
}
