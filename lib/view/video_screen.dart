
import 'package:flutter/material.dart';
import 'package:coaching_institude/model/yt_video.dart';
import 'package:google_fonts/google_fonts.dart';

class YoutubeVideoCard extends StatelessWidget{

  final YtVideo ytVideo;

    const YoutubeVideoCard({super.key,
    required this.ytVideo
    });

    @override
    Widget build(BuildContext context){
      return ListView(
        children:[ Card(
          margin:EdgeInsets.all(10),
          elevation: 5,
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(ytVideo.thumbnailUrl!),
              Padding(
                padding: EdgeInsets.all(10),
                child:Text(ytVideo.videoTitle!,
                style:GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold
                )
                )
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child:Text(ytVideo.channelName!,
                style:GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold
                )
                )
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child:Text(ytVideo.viewsCount!,
                style:GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold
                )
                )
              ),
            ],
          )
        ),
        ]
      );
    }
}