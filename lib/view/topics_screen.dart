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


   @override
  void initState(){
    getMCQData();
    super.initState();
  }

  void getMCQData()async {
    //  DocumentSnapshot docs =await FirebaseFirestore.instance.collection('MCQ').doc('zkBlnljsOl4Utc5oIZ2q').get() ;

    // mcqs.add(docs.data() as Map<String,dynamic>);
   await Provider.of<QuizProvider>(context,listen:false).fetchTopics(widget.subjectId);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Expanded(
        child: StreamBuilder<QuerySnapshot>(
          stream:FirebaseFirestore.instance.collection('Subjects').doc(widget.subjectId).collection('topics').snapshots(),
           builder: (context,snapshot){
            final topics = snapshot.data!.docs;
        
              return ListView.builder(
                itemCount: topics.length,
                itemBuilder: (context,index){
                   if (!snapshot.hasData) return CircularProgressIndicator();
                  final topic = topics[index];
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
                          Text("${topic['name']}",
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
                                    return QuestionsScreen(subjectId:widget.subjectId,topicId:topic.id);
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
           }),
      ));
    
  }
}