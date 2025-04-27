import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coaching_institude/view/profile_screen.dart';
import 'package:coaching_institude/view/questions_screen.dart';
import 'package:coaching_institude/view/quiz_result.dart';
import 'package:coaching_institude/view/quiz_test.dart';
import 'package:coaching_institude/view/video_home.dart';
import 'package:coaching_institude/view/yt_api_services.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
// import 'package:carousel_slider:coaching_institudeer.dart';
import 'package:coaching_institude/view/lecture.dart';
import 'package:coaching_institude/view/notes.dart';
import 'package:coaching_institude/view/syllabus.dart';
import 'package:coaching_institude/view/test.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io'; // <-- for Platform.isAndroid

// Import only if using SurfaceAndroidWebView
import 'package:webview_flutter_android/webview_flutter_android.dart';



void main() {

  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    options:FirebaseOptions(
       apiKey: "AIzaSyD62cDi05NnC1SQcELtK2ENPU3ELIRddIo",
  authDomain: "coaching-institude.firebaseapp.com",
  projectId: "coaching-institude",
  storageBucket: "coaching-institude.firebasestorage.app",
  messagingSenderId: "119883482337",
  appId: "1:119883482337:web:1dfda9aee95ffcb0f6e3a0",
  measurementId: "G-SHV6BN4RTZ"
    )
  );
  runApp(

    MultiProvider(
     providers:[
      ChangeNotifierProvider(create: (_) => QuizProvider()),
     ],
     child:MyApp()
    )
  );
}

class QuizProvider extends ChangeNotifier {
 
  List<Map<String, dynamic>> _subjects = [];
  List<Map<String, dynamic>> _topics = [];
  List<Map<String, dynamic>> _questions = [];
  bool _isLoading = false;

  List<Map<String, dynamic>> get subjects => _subjects;
  List<Map<String, dynamic>> get topics => _topics;
  List<Map<String, dynamic>> get questions => _questions;
  bool get isLoading => _isLoading;

  /// Fetch all subjects
  Future<void> fetchSubjects() async {
    _isLoading = true;
    notifyListeners();

    try {
      final querySnapshot = await FirebaseFirestore.instance.collection('Subjects').get();
      _subjects = querySnapshot.docs.map((doc) {
        return {
          'id': doc.id,
          'name': doc['name'],
        };
      }).toList();
    } catch (e) {
      print('Error fetching subjects: $e');
    }

    _isLoading = false;
    notifyListeners();
    log('subjects got fetched');
  }

  /// Fetch topics for a given subject
  Future<void> fetchTopics(String subjectId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('Subjects')
          .doc(subjectId)
          .collection('topics')
          .get();

      _topics = querySnapshot.docs.map((doc) {
        return {
          'id': doc.id,
          'name': doc['name'],
        };
      }).toList();
    } catch (e) {
      print('Error fetching topics: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Fetch questions for a given topic
  Future<void> fetchQuestions(String subjectId, String topicId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('Subjects')
          .doc(subjectId)
          .collection('topics')
          .doc(topicId)
          .collection('questions')
          .get();

      _questions = querySnapshot.docs.map((doc) {
        return {
          'question': doc['question'],
          'options': List<String>.from(doc['options']),
          'answer': doc['answer'],
        };
      }).toList();
    } catch (e) {
      print('Error fetching questions: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Clear topics and questions when navigating back
  void clearTopicsAndQuestions() {
    _topics = [];
    _questions = [];
    notifyListeners();
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      // home: const MyHomePage(title: 'Coaching Class'),
      home: QuizTestScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

 

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedItem = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
   
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
     
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("User Name"),
              accountEmail: Text("user@example.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Colors.blue),
              ),
            ),
            ListTile(leading: Icon(Icons.home), title: Text('Home'), onTap: () => Navigator.pop(context)),
            ListTile(leading: Icon(Icons.contacts), title: Text('Contact'), onTap: () => Navigator.pop(context)),
            ListTile(leading: Icon(Icons.share), title: Text('Share'), onTap: () => Navigator.pop(context)),
            ListTile(leading: Icon(Icons.person), title: Text('Profile'), onTap: () {}),
          ],
        ),
      ),


      body: Column(
        children: [
          // Container(
          //   height: 180,
          //   width: double.infinity,
          //   padding: EdgeInsets.symmetric(vertical: 8),
          //   child: CarouselSlider(
          //     items: [
          //      // buildSliderImage('image/slide1.jpg', isAsset: true),
          //      // buildSliderImage('image/slide2.jpeg',isAsset: true),
          //      // buildSliderImage('image/slide3.jpeg',isAsset: true),

          //       buildSliderImage('https://png.pngtree.com/png-clipart/20230529/original/pngtree-special-offer-tag-shape-free-vector-png-image_9173639.png'),
          //       buildSliderImage('https://cdn.pixabay.com/photo/2017/09/11/11/02/coaching-2738522_1280.jpg'),
          //       buildSliderImage('https://media.istockphoto.com/id/1455039694/photo/coaching-motivational-business-marketing-words-quotes-concept-words-lettering-typography.jpg?s=612x612&w=0&k=20&c=XSxg_VpkYkfYN2X_Mz-298PTdPE_1R0Z61KCcLWVmvw='),

          //     ],
          //     options: CarouselOptions(
          //       height: 180.0,
          //       enlargeCenterPage: true,
          //       autoPlay: true,
          //       aspectRatio: 16 / 9,
          //       autoPlayCurve: Curves.fastOutSlowIn,
          //       enableInfiniteScroll: true,
          //       autoPlayAnimationDuration: Duration(milliseconds: 200),
          //       viewportFraction: 0.8,
          //     ),
          //   ),
          // ),
          Divider(color: Colors.grey.shade400, thickness: 5, height: 5),
          Expanded(
            child: GridView.extent(
              padding: const EdgeInsets.all(5),
              crossAxisSpacing: 3,
              mainAxisSpacing: 3,
              maxCrossAxisExtent: 200.0,
              children: <Widget>[
                buildCardWithGesture(
                  context,
                  'Lecture Video',
                  'https://thumbs.dreamstime.com/z/video-lecture-icon-trendy-design-style-video-lecture-icon-isolated-white-background-video-lecture-vector-icon-simple-135726740.jpg',
                  onTap: () async{ 
                     var  videos =await YtApiServices().getAllVideosFromPlaylist("PL4cUxeGkcC9iVGY3ppchN9kIauln8IiEh");
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context){
                      return YoutubeHomePage(videos:videos);
                    }));
                  }
                  
                    
  
                ),
                buildCardWithGesture(
                  context,
                  'MCQ',
                  'assets/troffy.jpg',
                  onTap: () async{ 
                     var  videos =await YtApiServices().getAllVideosFromPlaylist("PL4cUxeGkcC9iVGY3ppchN9kIauln8IiEh");
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context){
                      return QuizTestScreen();
                    }));
                  }
                  
                    
  
                ),
                buildCardWithGesture(
                  context,
                  'Test',
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRxR92_SFvR3klJqHfM3024HuVe_sPt5aTzvg&s',
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TestPage())),
                ),
                buildCardWithGesture(
                  context,
                  'Syllabus',
                  'https://www.shutterstock.com/image-photo/syllabus-shown-on-cjnceptual-photo-260nw-1912408927.jpg',
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Syllabus())),
                ),
                buildCardWithGesture(
                  context,
                  'Notes',
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRZNNdkTJ-dnUm4YXT9zzqkv0uMu-NxdnIk7w&s',
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => NotesPage())),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items:  [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.youtube_searched_for), label: "Lecture"),
          BottomNavigationBarItem(icon: GestureDetector(
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context){
                  return ProfileScreen();
                })
              );
            },
            child:
             Icon(Icons.person_off_outlined
             )
             ), label: "Profile"),
        ],
        currentIndex: _selectedItem,
        onTap: (setvalue) {
          setState(() {
            _selectedItem = setvalue;
          });
        },
      ),
    );
  }

  Widget buildSliderImage(String path, {bool isAsset = false}) {
    return Container(
      margin: EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        image: DecorationImage(
          image: isAsset ? AssetImage(path) : NetworkImage(path) as ImageProvider,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget buildCardWithGesture(
      BuildContext context,
      String title,
      String imagePath, {
        bool isAsset = false,
        VoidCallback? onTap,
      }) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        margin: const EdgeInsets.all(8),
        height: 220,
        width: 160,
        child: Card(
          elevation: 10,
          shadowColor: Colors.black,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.green[500],
                  radius: 50,
                  child: CircleAvatar(
                    backgroundImage: isAsset ? AssetImage(imagePath) : NetworkImage(imagePath) as ImageProvider,
                    radius: 48,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ),
    ); 
  }
}
