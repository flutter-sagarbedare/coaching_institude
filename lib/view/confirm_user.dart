// import 'dart:async';
// import 'dart:developer';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:coaching_institude/main.dart';
// import 'package:coaching_institude/view/verfied_screen.dart';
// import 'package:coaching_institude/view/verify_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Confirm_user extends StatefulWidget {
//   const Confirm_user({super.key});

//   @override
//   State<Confirm_user> createState() => _Confirm_userState();
// }

// class _Confirm_userState extends State<Confirm_user> {

//   TextEditingController _passController = TextEditingController(); 
//    bool isLoading = false;

//     @override
//   void initState(){

//     // showMainScreen();
   
     
//     super.initState();
//   }

//   // dynamic firebaseFunc()async{
//   //   log('in firebase fun');
//   //      DocumentSnapshot docs = await FirebaseFirestore.instance.collection('password').doc('pasword').get();

//   //     Map<String,dynamic> data= docs.data() as Map<String,dynamic>;
//   //     log(data['password']);
//   //     SharedPreferences pref =await SharedPreferences.getInstance();
//   //     log("${pref.getString('password')}");
//   //     String? sData = await pref.getString('password');

//   //     return [data['password'],sData];
//   // }

//   // Future<bool> checkSharedPreferenceData()async{
//   //    SharedPreferences pref =await SharedPreferences.getInstance();
 
//   //     String? sData = await pref.getString('password');

//   //     if(sData == null ){
//   //       return false;
//   //     }else{
//   //       return true;
//   //     }
//   // }

//   // Future<bool> checkUserValidation() async {

//   //   if(await checkSharedPreferenceData()){
//   //     log("true");
//   //     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
//   //         return VerifyScreen();
//   //     }));
//   //   }
      
//   //     dynamic  data = await firebaseFunc();
//   //     log(data[0]+""+data[1]);
//   //         //   log(data[0]);
//   //         //  log(data[1]);
//   // //  if(data[0] != null && data[1]!= null){
//   // //         // if(data[0] == data[1])
//   // //         //     return true;

//   // //     return true;

//   // //     }else{
//   // //       return false;


//   // //     }
//   //   return false;
//   // }

//   // dynamic showMainScreen(){ 

   

//   //       return Center(
//   //         child:Container(
//   //              width: 330,
//   //              height: 135,
//   //              decoration:BoxDecoration(
               
//   //              color:Color.fromRGBO(248, 145, 87, 1),
//   //                borderRadius:BorderRadius.circular(10)
          
               
//   //            ), 
//   //              child:Padding(
//   //                padding: const EdgeInsets.all(14.0),
//   //                child: Column(
//   //                 mainAxisAlignment: MainAxisAlignment.start,
//   //                 crossAxisAlignment: CrossAxisAlignment.start,
//   //                 children: [
//   //                   Text("Enter Your Password"),
//   //                   TextField(
//   //                     controller:_passController,
//   //                   ),
//   //                   const SizedBox(
//   //                     height:10
//   //                   ),
//   //                   GestureDetector(
//   //                     onTap:()async{
                      
                      
//   //   if (_passController.text.isNotEmpty) {
//   //     setState(() {
//   //       isLoading = true;
//   //     });

//   //     try {
//   //       await FirebaseFirestore.instance.collection('password').doc('pasword').update({
//   //         "password": _passController.text.trim()
//   //       });

//   //       SharedPreferences pref = await SharedPreferences.getInstance();
//   //       await pref.setString(_passController.text.trim(), 'password');

//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         SnackBar(
//   //           content: Text("Password saved"),
//   //           backgroundColor: Colors.green,
//   //         ),
//   //       );

//   //       Navigator.of(context).pushAndRemoveUntil(
//   //         MaterialPageRoute(builder: (_) => MyHomePage(title: 'Coaching Class')),
//   //         (route) => false,
//   //       );
//   //     } catch (e) {
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         SnackBar(
//   //           content: Text("Error saving password: $e"),
//   //           backgroundColor: Colors.red,
//   //         ),
//   //       );
//   //     } finally {
//   //       setState(() {
//   //         isLoading = false;
//   //       });
//   //     }
//   //   } else {
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(
//   //         content: Text("Enter password"),
//   //         backgroundColor: Colors.red,
//   //       ),
//   //     );
    
  


//   //                       // Map<String,dynamic> docs= data.data() as Map<String,dynamic>;



//   //                     }},
//   //                     child:Container(
//   //                       child:Center(
//   //                         child:Text("Submit")
//   //                       )
//   //                     )
//   //                   )

//   //                 ],
//   //                ),
//   //              )
//   //         ),
//   //       );

    
//   // }
  
//   // // Widget verifiedUser(){
//   // //   //  Timer(
//   // //   //   Duration(seconds:3),
//   // //   // (){


//   // //   //      Navigator.of(context).pushAndRemoveUntil(
//   // //   //           MaterialPageRoute(builder: (_) => MyHomePage(title: 'Coaching Class',)),
//   // //   //           (route) => false, // Remove all previous routes
//   // //   //         );
            
      
//   // //   // }   
//   // //   // );
//   // //   (){


//   // //   };
//   // // }

//   @override
//   Widget build(BuildContext context) {
//    checkUserValidation();
//    return  Scaffold();
//   }

 
    
// }