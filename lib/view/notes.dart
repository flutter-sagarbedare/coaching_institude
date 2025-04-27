import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class NotesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes Page"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.deepPurple, width: 2),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    foregroundColor: Colors.deepPurple, // Text and splash color
                  ),
                  onPressed: () async{
                  final url='https://cetcell.mahacet.org/wp-content/uploads/2023/12/Syllabus.pdf';
                 if(await canLaunch(url))
                  await launch(url);
                    
                  },
                  child: Text("English Notes"),
                ),
              ),
            ),
          ),

  Container(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.deepPurple, width: 2),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  foregroundColor: Colors.deepPurple, // Text and splash color
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Button Clicked!")),
                  );
                },
                child: Text("English Notes"),
              ),
            ),
          ),

            Container(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.deepPurple, width: 2),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  foregroundColor: Colors.deepPurple, // Text and splash color
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Button Clicked!")),
                  );
                },
                child: Text("Marathi Notes"),
              ),
            ),
          ),

            Container(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.deepPurple, width: 2),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  foregroundColor: Colors.deepPurple, // Text and splash color
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Button Clicked!")),
                  );
                },
                child: Text("Hindi Notes"),
              ),
            ),
          ),


        ],
      ),
    );
  }
}
