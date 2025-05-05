import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coaching_institude/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  TextEditingController _passController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: isLoading ? Center(child:CircularProgressIndicator()) :
      Center(
        child: Container(
          width: 330,
          height: 170,
          decoration: BoxDecoration(
            // color: Color.fromRGBO(255, 178, 97, 1),
            color:Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color:Colors.white
            ),
            boxShadow: [
              BoxShadow(
                color:Colors.black,
                // offset:Offset.infinite,
                blurRadius: 10,
                spreadRadius: 2
              )
            ]
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Enter Your Password",
                style:TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold
                )
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.only(left:10,right:10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    color: const Color.fromARGB(255, 160, 160, 160)
                  ),
                  child: TextField(controller: _passController,
                  
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Password"
                    
                  ))),
                const SizedBox(height: 15),
                // GestureDetector(
                //   onTap: () async {
                //     if (_passController.text.isNotEmpty) {
                //       setState(() {
                //         isLoading = true;
                //       });

                //       try {
                //         await FirebaseFirestore.instance
                //             .collection('password')
                //             .doc('pasword')
                //             .update({"password": _passController.text.trim()});

                //         SharedPreferences pref =
                //             await SharedPreferences.getInstance();
                //         await pref.setString(
                //           _passController.text.trim(),
                //           'password',
                //         );
                //         await pref.setBool('isLoggedIn', true);

                //         ScaffoldMessenger.of(context).showSnackBar(
                //           SnackBar(
                //             content: Text("Password saved"),
                //             backgroundColor: Colors.green,
                //           ),
                //         );

                //         Navigator.of(context).pushAndRemoveUntil(
                //           MaterialPageRoute(
                //             builder: (_) => MyHomePage(title: 'Coaching Class'),
                //           ),
                //           (route) => false,
                //         );
                //       } catch (e) {
                //         ScaffoldMessenger.of(context).showSnackBar(
                //           SnackBar(
                //             content: Text("Error saving password: $e"),
                //             backgroundColor: Colors.red,
                //           ),
                //         );
                //       } finally {
                //         setState(() {
                //           isLoading = false;
                //         });
                //       }
                //     } else {
                //       ScaffoldMessenger.of(context).showSnackBar(
                //         SnackBar(
                //           content: Text("Enter password"),
                //           backgroundColor: Colors.red,
                //         ),
                //       );
                //     }
                //   },
                //   child:Container(
                //     height: 36,
                //     decoration: BoxDecoration(
                //       color:Colors.grey,
                //       borderRadius: BorderRadius.circular(15)
                //     ),
                //     child: Center(child:Text("Submit")))
                // ),
                ElevatedButton(
                  onPressed:
                  () async {

                    onPasswordVerified(_passController.text.trim(),context);
                      

                    // if (_passController.text.isNotEmpty) {
                    //   setState(() {
                    //     isLoading = true;
                    //   });

                    //   try {
                    //     await FirebaseFirestore.instance
                    //         .collection('password')
                    //         .doc('pasword')
                    //         .update({"password": _passController.text.trim()});

                    //     SharedPreferences pref =
                    //         await SharedPreferences.getInstance();
                    //     await pref.setString(
                    //       _passController.text.trim(),
                    //       'password',
                    //     );
                    //     await pref.setBool('isLoggedIn', true);

                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       SnackBar(
                    //         content: Text("Password saved"),
                    //         backgroundColor: Colors.green,
                    //       ),
                    //     );

                    //     Navigator.of(context).pushAndRemoveUntil(
                    //       MaterialPageRoute(
                    //         builder: (_) => MyHomePage(title: 'Coaching Class'),
                    //       ),
                    //       (route) => false,
                    //     );
                    //   } catch (e) {
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       SnackBar(
                    //         content: Text("Error saving password: $e"),
                    //         backgroundColor: Colors.red,
                    //       ),
                    //     );
                    //   } finally {
                    //     setState(() {
                    //       isLoading = false;
                    //     });
                    //   }
                    // } else {
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     SnackBar(
                    //       content: Text("Enter password"),
                    //       backgroundColor: Colors.red,
                    //     ),
                    //   );
                    // }
                  },      
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.green)
                  ),            
                  child:Center(
                    child:Text("Submit")
                  ),)
              ],
            ),
          ),
        ),
      )
    );
  }

  void onPasswordVerified(String enteredPassword,BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Fetch current password from Firebase
  DocumentSnapshot docs = await FirebaseFirestore.instance
      .collection('password')
      .doc('pasword')
      .get();

  String firebasePassword = (docs.data() as Map<String, dynamic>)['password'];

  if (enteredPassword == firebasePassword) {
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('password', enteredPassword);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage(title: 'safar')));
  } else {
     ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Wrong password"),
                          backgroundColor: Colors.red,
                        ),
                      );
    log('Incorrect password');
    // Show error to user
  }
}

}
