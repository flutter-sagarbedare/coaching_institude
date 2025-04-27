import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class LecturePlayer extends StatefulWidget {
  final String videoId;
  const LecturePlayer({super.key,required this.videoId});

  @override
  State<LecturePlayer> createState() => _LecturePlayerState();
}

class _LecturePlayerState extends State<LecturePlayer> {

   late YoutubePlayerController _controller;
 

 @override
  void initState() {
//     _controller = YoutubePlayerController.fromVideoId(
//       videoId: widget.videoId,
//     params: YoutubePlayerParams(
//       // showControls: false,
//       showFullscreenButton: true
//     )
// );

    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
       
      ),
    );
    super.initState();
 
  }

 
  // @override
  // void deactivate() {
  //   // Pauses video while navigating to next page.
  //   _controller.pause();
  //   super.deactivate();
  // }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   _idController.dispose();
  //   _seekToController.dispose();
  //   super.dispose();
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:myMadeAppBar(context),
      body: YoutubePlayer(
  controller: _controller,
  aspectRatio: 16 / 9,
  topActions: [
    IconButton(onPressed: (){
      // Navigator.of(context).pop();
      if(MediaQuery.of(context).orientation == Orientation.portrait) 
                        { 
                            // SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]); 
                        }else { 
                            SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]); 
                        } 
      
    }, icon: Icon(Icons.arrow_back_ios_new,
    size:30,
    color:Colors.white
    ))
  ],
 
  
)
    );
    
  }
}

dynamic myMadeAppBar(context) {
  if(MediaQuery.of(context).orientation == Orientation.portrait){
    return AppBar(
      title:Text("Lecture")
    );
  }else{
    // return PreferredSize();
  }
}