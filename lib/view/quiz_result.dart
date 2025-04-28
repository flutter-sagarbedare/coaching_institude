import 'package:flutter/material.dart';

class QuizResult extends StatelessWidget {
  final int correctAnsCount;
  const QuizResult({super.key,required this.correctAnsCount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment:MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height:30
          ),
          Center(
            child: Text(
                        "Math Quiz",
                        style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(131, 76, 52, 1),
                        ),
                      ),
          ),

          Container(
            height: 311,
            decoration: BoxDecoration(
              color:Color.fromRGBO(246, 221, 195, 1),

            ),
            child: Row(
              children: [
            
                Container(
                  // height:140,
                  clipBehavior: Clip.hardEdge,
                  decoration:BoxDecoration(
                    shape: BoxShape.circle,
                    color:Colors.red,
                    // borderRadius:BorderRadius.circular(20)
                  ),
                  child: Image.asset('assets/troffy.jpg')),
            
                  const SizedBox(
                    width:30
                  ),
                  Text("$correctAnsCount")
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}