import 'dart:io';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


class ProfileScreen extends StatefulWidget{
  const ProfileScreen({super.key});
  

  @override
  State<ProfileScreen> createState ()=>_ProfileScreenState();
}
class _ProfileScreenState extends State<ProfileScreen>{
    String? userId;
    Map<String,dynamic> userdata={};

  void getUserInfo()async{
    
    // userdata = Provider.of<UserInformation>(context,listen:false).userData;


    // DocumentSnapshot doc = await FirebaseFirestore.instance.collection("Users").doc(userId).get();

    // userdata = doc.data() as Map<String,dynamic>;
    setState(() {
      
    });
  }

    @override
    void initState(){

   
    getUserInfo();

      super.initState();
    }

 @override
  Widget build(BuildContext context){

    if(userdata==null){
      return CircularProgressIndicator();
      
          }

    return Scaffold(
       appBar:AppBar(
        title:Text("Profile",
        style:GoogleFonts.montserrat(
          fontSize:30,
          fontWeight:FontWeight.bold
        )),
        // actions:[ GestureDetector(
        //   onTap: ()async{
            // final prefs = await SharedPreferences.getInstance();

  // Navigator.of(context).push(MaterialPageRoute(builder: (context){
  //   return SignIn();
  // }));
  // await prefs.clear(); 
  //         },
  //         child: Icon(Icons.logout)),const SizedBox(width: 30,)]
          // }
      // ),]
      ),
      // backgroundColor: Colors.blue,
     body:
     Consumer(
      builder: (context, provider, child) {
        // return
        //  StreamBuilder<List<Map<String, dynamic>>>(
        //   stream:
        //       Provider.of<CoreDataItems>(context, listen: false).fetchUserData(),
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return Center(child: CircularProgressIndicator());
        //     } else if (snapshot.hasError) {
        //       return Center(child: Text('Error: ${snapshot.error}'));
        //     } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        //       return Center(child: Text('No data available'));
        //     }

        //     final dataList = snapshot.data!;

            return      Column(
      children:[
           Row(
                  children: [
           Padding(
            padding:EdgeInsets.all(15.0),
            child:
            Image.asset(
              "assets/profile.png",
              height:120
            ),
           ),
                const SizedBox(
                  width:10
                ),
                 Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                    //  Text("${userdata["name"]}",
                     Text("Sagar",
                     style:GoogleFonts.montserrat(
                      fontSize: 23,
                      fontWeight: FontWeight.bold
                     )),
                     const SizedBox(height: 10,),
                        // Text("${userdata["name"]}",
                        Text("Sagar Nivrutti Bedare}",
                      style:GoogleFonts.montserrat(
                      fontSize: 12,
                      color:Colors.grey,
                      fontWeight: FontWeight.w400
                     )),
                     const SizedBox(height: 7,),
                     Text("Golegaon khurd",
                      style:GoogleFonts.montserrat(
                                                color:Color.fromARGB(255, 42, 37, 117),                  

                      fontSize: 12,
                      fontWeight: FontWeight.w400
                     )),
                   ],
                 ),
                  ]
                ),
                const SizedBox(height: 30,),
        Expanded(
          flex:1,
          child:Container(
            decoration: BoxDecoration(
            color:Colors.white,
              borderRadius:BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)) ,
              boxShadow: [
                BoxShadow(
                  color:Colors.black,
                  spreadRadius:1,
                  blurRadius: 20
                )
              ]
            ),
            child:Padding(
              padding: const EdgeInsets.all(30.0),
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                    Text("About",
                      style:GoogleFonts.montserrat(
                        fontSize: 14,
                        color:Color.fromARGB(255, 42, 37, 117),                  

                        fontWeight: FontWeight.bold,
                      )) ,
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color:const Color.fromARGB(146, 187, 222, 251),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child:Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Text(
                            "My Name Is Sagar Bedare"
                          ),
                        ),
                      ),


                      Text("Contact",
                      style:GoogleFonts.montserrat(
                        color:Color.fromARGB(255, 42, 37, 117),                  
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      )) ,
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color:const Color.fromARGB(146, 187, 222, 251),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child:Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Text(
                            "8669867540"
                          ),
                        ),
                      ),


                    


                      Text("Email ",
                      style:GoogleFonts.montserrat(
                        color:Color.fromARGB(255, 42, 37, 117),                  
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      )) ,
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color:const Color.fromARGB(146, 187, 222, 251),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child:Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Text(
                            "sagarbedare2004@gmail.com",
                          ),
                        ),
                      ),



                      Text("Qualification",
                      style:GoogleFonts.montserrat(
                        color:Color.fromARGB(255, 42, 37, 117),                  
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      )) ,
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color:const Color.fromARGB(146, 187, 222, 251),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child:Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Text(
                            "BCA"
                          ),
                        ),
                      ),
                      Text("Address",
                      style:GoogleFonts.montserrat(
                        color:Color.fromARGB(255, 42, 37, 117),                  
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      )) ,
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color:const Color.fromARGB(146, 187, 222, 251),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child:Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Text(
                            "Golegaon khurd"
                          ),
                        ),
                      ),
                      Text("Skill and Endoresement",
                      style:GoogleFonts.montserrat(
                        color:Color.fromARGB(255, 42, 37, 117),                  
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      )) ,
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color:const Color.fromARGB(146, 187, 222, 251),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child:Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Text(
                            "C Cpp Dsa Flutter"
                          ),
                        ),
                      ),
                      Text("Experience",
                      style:GoogleFonts.montserrat(
                        color:Color.fromARGB(255, 42, 37, 117),                  
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      )) ,
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color:const Color.fromARGB(146, 187, 222, 251),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child:Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Text(
                           " 2years"
                          ),
                        ),
                      ),                    
              
                ],
              ),
            )
          ),
        )
      ]
     );


  },
//         );
//       },
    )

//   // Column(children: [
//   //   userdata["name"]==null ? CircularProgressIndicator() : Text("${userdata["name"]}"),
//   // ],)


    );
  }
}

class CoreDataItems {
  get userEmail => null;

  fetchUserData() {}
}