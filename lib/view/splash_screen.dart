 import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coaching_institude/main.dart';
import 'package:coaching_institude/view/verfied_screen.dart';
import 'package:coaching_institude/view/verify_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool isUser = false;

@override
  void initState(){

    //  Timer(
    //   Duration(seconds:3),
    //   ()=>  checkLoginState(context)
      
    // );
     checkLoginState(context);


    super.initState();
  }

  void checkLoginState(BuildContext context)async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    // prefs.setBool('isLoggedIn',false);
    // prefs.setString('password','sagar');

    DocumentSnapshot docs = await FirebaseFirestore.instance.collection('password').doc('pasword').get();
    Map<String,dynamic> data = docs.data() as Map<String,dynamic>;
      String firebasePassword = data['password'];
  log('Firebase Password: $firebasePassword');

     bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  String? localPassword = prefs.getString('password');


  if (isLoggedIn && localPassword != null && localPassword == firebasePassword) {
    log('User is already logged in and password matches.');
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> MyHomePage())); // or your HomePage route
  } else {
    log('Login required or password mismatch.');
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> VerifyScreen())); // or your VerifyPage route
  }
   
    

    // bool isLoggedIn =  prefs.getBool('isLoggedIn')!;
    String password = prefs.getString('password')!;
    if(password == null){
      log('no password is found');
    }

    // DocumentSnapshot docs = await FirebaseFirestore.instance.collection('password').doc('pasword').get();

    // Map<String,dynamic> data = docs.data() as Map<String,dynamic>;
    // if(password == null || isLoggedIn == null){
    //    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> VerifyScreen()));
    //    return;
    // }
    // if(isLoggedIn){
    //   if(data['password'] == password){
    //    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> MyHomePage(title: "Sagar Coachind",)));
    //   }else{
    //    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> VerifyScreen()));
    // }
    // }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Image.asset('assets/troffy.jpg')),
    );
  }
}