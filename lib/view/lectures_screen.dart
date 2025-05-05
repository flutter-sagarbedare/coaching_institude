import 'dart:developer';

import 'package:flutter/material.dart';
import 'video_screen.dart';
import 'yt_video_view_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


class CourseDataScreen extends StatefulWidget{

  const CourseDataScreen({super.key});

  @override
  State<CourseDataScreen> createState() => _CourseDataScreenState();
}

class _CourseDataScreenState extends State<CourseDataScreen> {
  @override
  void initState(){
    // ()async{
    // await YtApiServices().getAllVideosFromPlaylist();
    // };
    Provider.of<YtVideoViewModel>(context,listen:false).getAllVideos();
    super.initState();
  }
  var temp = YtVideoViewModel();

  @override
  Widget build(BuildContext context){
    // log("sagar :${temp.playListItems}");
    return Scaffold(
      appBar:AppBar(
        title: const Text("Flutter Online"),
        backgroundColor: Colors.deepPurple,
      ),
      body: 
      // Consumer<YtVideoViewModel>(
      //   builder: (context, YtVideoViewModel,_){
      //     if(YtVideoViewModel.playListItems.isEmpty){
      //       return Center(
      //         child:Text("There are no videos")
      //       );
      //     // /
      //     }else{
      //       return 
      //       ListView.builder(
      //         itemCount: temp.playListItems.length,
      //         itemBuilder: (context,index){
      //           log("In lecture screen");
      //           return YoutubeVideoCard(ytVideo: YtVideoViewModel.playListItems[0],);
      //       }
      //       );
      //     }
      //   },
      // ),
      Consumer<YtVideoViewModel>(
  builder: (context, ytVideoViewModel, _) {
    if (ytVideoViewModel.playListItems == null || ytVideoViewModel.playListItems.isEmpty) {
      return const Center(child: Text("There are no videos"));
    } else {
      return ListView.builder(
        itemCount: ytVideoViewModel.playListItems.length,
        itemBuilder: (context, index) {
          log("In lecture screen");
          return YoutubeVideoCard(
            ytVideo: ytVideoViewModel.playListItems[index], // Use correct index
          );
        },
      );
    }
  },
),
            // ListView.builder(
            //   itemCount: temp.playListItems.length,
            //   itemBuilder: (context,index){
            //     return YoutubeVideoCard(
            //       ytVideo: temp.playListItems[index],
            //     );
            // } )
      );  
      }
}