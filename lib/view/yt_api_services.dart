import 'dart:convert';
import 'dart:developer';


import 'package:coaching_institude/model/yt_video.dart';
import 'package:http/http.dart' as http;



class YtApiServices{
  String baseUrl = "https://www.googleapis.com/youtube/v3/playlistItems";

  // String source='';

  // YtApiServices([String? source]);

  getAllVideosFromPlaylist([String? source])async{

    // try{

      List<YtVideo>? allVideos=[];

      String link = 'https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&maxResults=50&playlistId=$source&key=AIzaSyAEXZSGhsQ-St7smhDyjhgej24VzOjyjIo';

      
    // var response = await http.get(Uri.parse(baseUrl+"?part=snippet&maxResults=50&playlistId=PLjVLYmrlmjGfGLShoW0vVX_tcyT8u1Y3E&key=${ApiKey.api_key}"));
    var response = await http.get(Uri.parse(link));
    if(response.statusCode==200){
      var jsonData = jsonDecode(response.body);
      // log("the data from yt api is $jsonData");

      List playListItems = jsonData['items'];
      log("playlist items :${playListItems[0]}");

      // playListItems

      for(var videoData in playListItems){
        YtVideo video =  YtVideo(
          videoId: videoData['snippet']['resourceId']['videoId'],
           videoTitle: videoData['snippet']['title'],
            thumbnailUrl: videoData['snippet']['thumbnails']['maxres']['url'], 
            viewsCount: "100K", 
            channelName: videoData['snippet']['channelTitle'],
            maxResults: 50
            );
        // log(video.videoId!);
        // log(video.videoTitle!);
        // log(video.thumbnailUrl!);
        // log(video.viewsCount!);
        // log(video.channelName!);


        allVideos.add(video);
        log("All Videos : $allVideos");
      }
      log("length = ${allVideos.length}");


    }else{
      // log(response.body);
      log("Unable to get data");
    }
    return allVideos;
    // }finally{};
    // }catch(ex){};
  }
}