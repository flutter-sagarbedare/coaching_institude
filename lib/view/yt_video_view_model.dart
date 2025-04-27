import 'dart:developer';


import 'package:coaching_institude/view/yt_api_services.dart';
import 'package:flutter/material.dart';
import 'package:coaching_institude/model/yt_video.dart';


class YtVideoViewModel extends ChangeNotifier{
  List<YtVideo> _playListItems = [];
  
  List<YtVideo> get  playListItems =>_playListItems;

  getAllVideos()async {
    _playListItems = await YtApiServices().getAllVideosFromPlaylist();
    notifyListeners();
    // print("sagar :$playListItems");

  }

  //   Future<void> getAllVideos() async {
  //   try {
  //     _playListItems = await YtApiServices().getAllVideosFromPlaylist() ?? [];
  //     notifyListeners();
  //   } catch (e) {
  //     debugPrint("Error fetching videos: $e");
  //     _playListItems = [];
  //     notifyListeners();
  //   }
  // }
}
