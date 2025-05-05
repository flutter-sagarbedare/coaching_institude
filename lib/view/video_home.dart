import 'dart:developer';


import 'package:coaching_institude/view/lecture_player.dart';
import 'package:flutter/material.dart';

import 'package:coaching_institude/model/yt_video.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class YoutubeHomePage extends StatefulWidget {

   List<YtVideo> videos =[];

  YoutubeHomePage({super.key,required this.videos});

  @override
  State<YoutubeHomePage> createState() => _YoutubeHomePageState();
}

class _YoutubeHomePageState extends State<YoutubeHomePage> {
  // @override
  // void initState(){
  //   setList();
  //   super.initState();
  // }

  // void setList()async{
  //   log("In set list");
  //   videos =await YtApiServices().getAllVideosFromPlaylist();

  // }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Lectures",
        style:TextStyle(
          color: Colors.white
        )),
        backgroundColor: Colors.deepPurple,
       
        
      ),
      body:
      Consumer(
        builder:(context,YtVideoViewModel,_){
          return ListView.builder(
        itemCount:widget.videos.length,
        itemBuilder: 
      (context,index){
        return Padding(
        padding: const EdgeInsets.all(12.0),
        child: GestureDetector(
          onTap:(){
              Navigator.of(context).push(MaterialPageRoute(builder: (context){
                return LecturePlayer(videoId: "${widget.videos[index].videoId}");
              }));

          },
          child: Container(
            decoration: BoxDecoration(
              color:Color.fromRGBO(240, 244, 253, 1),
              borderRadius: BorderRadius.circular(10)
            ),
            child: Row(
              mainAxisAlignment:MainAxisAlignment.center,
              crossAxisAlignment:CrossAxisAlignment.center,
              children: [
            Container(
              height: 140,
              width: 200,
              child: Image.network("${widget.videos[index].thumbnailUrl}",
               loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                if(loadingProgress == null){
            
                return child;
                }else{
                    return Center(
                      child: CircularProgressIndicator(
                        
                      ),
                    );
                }
               }
              ),
              
              ),
             const SizedBox(width:20),
            Expanded(
              child: Column(
                children: [
                  Text("${index+1} . ${widget.videos[index].videoTitle}",
                  style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  // color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                  ),
                  
                  
                ],
              ),
            )
              ],
            ),
          ),
        ),
      );
      });
        } ,)
      
      // Text("${widget.videos[0].channelName}"),
  //       Consumer<YtVideoViewModel>(
  //       builder: (context, ytVideoViewModel,_){
  //         if(ytVideoViewModel.playListItems.isEmpty){
  //           return Center(child: Text("No video"));
  //         }else{
  //   return  ListView.builder(
  //       itemCount:ytVideoViewModel.playListItems.length,
  //       itemBuilder: (context,index){
  //       return YoutubeVideoCard(ytVideo:videos[0]);
  //     });
  //         }
  // })


        // Consumer<YtVideoViewModel>(
        // builder: (context, ytVideoViewModel,_){
        //   if(ytVideoViewModel.playListItems.isEmpty){
        //     return Center(
        //       child:Text("There are no videos")
        //     );
        //   // /
        //   }else{
        //     return 
        //     ListView.builder(
        //       itemCount: ytVideoViewModel.playListItems.length,
        //       itemBuilder: (context,index){
        //         log("In lecture screen");
        //         return YoutubeVideoCard(ytVideo: videos[0],);
        //     }
        //     );
          // }
        // },
      // ),
    );
  }
}