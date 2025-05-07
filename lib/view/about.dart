import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  Map<String,dynamic> data = {};
  bool _isLoading = true;

  @override
  void initState(){ 
    getAboutData();


    super.initState();
  }

  void getAboutData()async{
    DocumentSnapshot doc = await FirebaseFirestore.instance.collection('About').doc('About').get();
    data = doc.data() as Map<String,dynamic>;
    setState(() {
      _isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {

      
    return Scaffold(
      appBar: AppBar(
        title: Text("About Us"),
      ),
      body:_isLoading ? Center(child:CircularProgressIndicator()) :      
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('assets/logo.jpg'),
          const SizedBox(height: 50,),
          Text(data['name']),
          const SizedBox(height: 10,),
          Text(data['Description']),
          const SizedBox(height: 10,),
          Text(data['contact']),
          
        ],
      )
    );
  }
}