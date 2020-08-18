import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:kpop/data/music_video.dart';

class YoutubeApi {
  static BaseOptions _baseOptions = BaseOptions(
    baseUrl: "https://www.googleapis.com/youtube/v3",
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );
  static Dio _dio = Dio(_baseOptions);
  final String key = "AIzaSyChZAIr8W3fJzrBq-sNMGZ2N583nRXVpC4";

  Future<Map<String, dynamic>> search({
    @required String query,
    String nextPageToken,
  }) async {
    try {
      String url =
          "/search?part=snippet&type=video&maxResults=10&q=$query&key=${this.key}";
      if (nextPageToken != null) url = url + "&pageToken=$nextPageToken";
      Response res = await _dio.get(url);
      List<MusicVideo> musicVideoList =
          List<Map<String, dynamic>>.from(res.data['items']).map((map) {
        String videoId = map['id']['videoId'];
        Map snippet = map['snippet'];
        return MusicVideo(
            id: videoId,
            title: snippet['title'],
            thumbnail: snippet['thumbnails']['high']['url'],
            description: snippet['description']);
      }).toList();
      return {
        "nextPageToken": res.data['nextPageToken'],
        "musicVideoList": musicVideoList,
      };
    } catch (error) {
      print(error);
      return null;
    }
  }
}
