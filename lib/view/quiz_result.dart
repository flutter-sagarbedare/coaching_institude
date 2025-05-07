import 'package:coaching_institude/main.dart';
import 'package:flutter/material.dart';

class QuizResult extends StatefulWidget {
  final int correctAnsCount;
  final int questionCount;
  
  const QuizResult({super.key,required this.correctAnsCount,required this.questionCount});

  @override
  State<QuizResult> createState() => _QuizResultState();
}

class _QuizResultState extends State<QuizResult> {
    double perc = 0;
@override
void initState(){
  
perc = (widget.correctAnsCount / widget.questionCount * 100);

  super.initState();
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
            onPressed: () {
              //  Navigator.of(context).pop(true);
               Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>MyHomePage()));
            },
            child: Text('Yes'),
          ),
        ],
      ),
    ) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return 
    WillPopScope(
      onWillPop:() =>_onWillPop(context),
      child: Scaffold(
        
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment:MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height:30
              ),
              Center(
                child: Text(
                            "Math Quiz Result",
                            style: TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(131, 76, 52, 1),
                            ),
                          ),
              ),
              const SizedBox(
                height: 100,
              ),
              Container(
                height: 311,
                decoration: BoxDecoration(
                  color:Color.fromRGBO(246, 221, 195, 1),
                        borderRadius:BorderRadius.circular(30)         
          
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 330,
                      height: 135,
                      decoration:BoxDecoration(
                      
                      color:Color.fromRGBO(248, 145, 87, 1),
                        borderRadius:BorderRadius.circular(10)
      
                      
                    ), 
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                      const SizedBox(
                        width: 30,
                      ),
                          Container(
                            height:110,
                            // width: 300,
                            clipBehavior: Clip.hardEdge,
                            decoration:BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset('assets/troffy.jpg',scale:1),
                          ),
                      
                            const SizedBox(
                              width:40
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                // color:Colors.white
                                border: Border.all(color: Colors.white,
                                width:2
                                ),
                              ),
                              child: Center(child: Text("${perc}%"))),
                            const SizedBox(
                              width:5
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    height:95,
                      width:152,
                    decoration: BoxDecoration(
                      
                      color:Colors.white,
                        borderRadius:BorderRadius.circular(10)
      
                      
                    ),
                    child: Center(
                      child: Text("Solved Questions \n            ${widget.questionCount}",
                      style:TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(131, 76, 52, 0.9)
                      ),
                      softWrap: true,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                    Container(
                    height:95,
                      width:152,
                    decoration: BoxDecoration(
                      
                      color:Color.fromRGBO(26, 181, 134, 1),
                        borderRadius:BorderRadius.circular(10)
      
                      
                    ),
                    child: Center(
                      child: Text("Correct Questions \n            ${widget.correctAnsCount}",
                      style:TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.white
                      ),
                      softWrap: true,
                      ),
                    ),
                  ),
                ],
              )
                  ],
                ),
              ),
              const SizedBox(
                height: 80,
              ),
      
              ElevatedButton(onPressed: (){
      
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context)=>MyApp())
                  );
      
              },
              
               child: Center(
                child:Text(
                  "Go To Home "
                )
               ) )
              
            ],
          ),
        ),
      ),
    );
  }
}

