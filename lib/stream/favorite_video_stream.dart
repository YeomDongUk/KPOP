import 'dart:async';

import 'package:kpop/data/music_video.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteVideoStream {
  StreamController<List<MusicVideo>> _controller;
  Stream<List<MusicVideo>> _stream;
  Stream<List<MusicVideo>> get stream => _stream;
  List<MusicVideo> musicVideoList = [];
  SharedPreferences _pref;

  FavoriteVideoStream() {
    _controller = StreamController<List<MusicVideo>>.broadcast();
    _stream = _controller.stream;
    _init();
  }

  void _init() async {
    _pref = await SharedPreferences.getInstance();
    List<String> videoList = _pref.getStringList("favoriteVideos");
    print(videoList);
  }

  void addVideo(MusicVideo musicVideo) {
    musicVideoList.add(musicVideo);
    _controller.sink.add(musicVideoList);
  }

  void deleteVideo(MusicVideo musicVideo) {
    musicVideoList.remove(musicVideo);
    _controller.sink.add(musicVideoList);
  }

  void dispose() {
    _controller.close();
  }
}
