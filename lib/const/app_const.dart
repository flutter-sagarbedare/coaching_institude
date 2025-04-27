import 'package:flutter/material.dart';

class ApiKey{
  static const String api_key = "AIzaSyAEXZSGhsQ-St7smhDyjhgej24VzOjyjIo";

   
}

// void displaySnackBar(BuildContext context, String data){
    
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//               data,
//               style: TextStyle(color: Colors.black, fontSize: 20),
//             ),
//             backgroundColor: Colors.red[600],
//           ),
//         );
 
//   }

  void displaySnackBar(BuildContext context, String data) {
    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.white),
          SizedBox(width: 10),
          Expanded(child: Text(data)),
        ],
      ),
      backgroundColor: Colors.teal,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      duration: Duration(seconds: 3),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      elevation: 10,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  void displayNSnackBar(BuildContext context, String data) {
    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(Icons.cancel_outlined, color: Colors.white),
          SizedBox(width: 10),
          Expanded(child: Text(data)),
        ],
      ),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      duration: Duration(seconds: 3),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      elevation: 10,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }


