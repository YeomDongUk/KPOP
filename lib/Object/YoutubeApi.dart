import 'dart:convert';
import 'package:http/http.dart' as http;

class YoutubeApi {
  final String key;
  String nextPageToken;
  String url =
      "https://www.googleapis.com/youtube/v3/search?part=snippet&type=video";
  YoutubeApi({this.key});
  Future<List> search(String query) async {
    var res = await http.get(
      "${this.url}&maxResults=10&q=$query&key=${this.key}",
      headers: {"Accept": "application/json"},
    );
    var jsonData = json.decode(res.body);
    if (jsonData['error'] != null) {
      print(jsonData['error']);
      return [];
    }
    if (jsonData['pageInfo']['totalResults'] == null) return [];
    List list = jsonData["items"];
    this.nextPageToken = jsonData["nextPageToken"];
    return list;
  }

  Future<List> nextPage(String query) async {
    var res = await http.get(
      "${this.url}&maxResults=10&q=$query&key=${this.key}&pageToken=${this.nextPageToken}",
      headers: {"Accept": "application/json"},
    );
    var jsonData = json.decode(res.body);
    if (jsonData['error'] != null) {
      print(jsonData['error']);
      return [];
    }
    if (jsonData['pageInfo']['totalResults'] == null) return [];
    List list = jsonData["items"];
    this.nextPageToken = jsonData["nextPageToken"];

    return list;
  }

  Future<List> getRelatedVideo(String videoId) async {
    var res = await http.get(
      "${this.url}&maxResults=12&key=${this.key}&relatedToVideoId=$videoId",
      headers: {"Accept": "application/json"},
    );
    var jsonData = json.decode(res.body);
    if (jsonData['error'] != null) {
      print(jsonData['error']);
      return [];
    }
    if (jsonData['pageInfo']['totalResults'] == null) return [];
    List list = jsonData["items"];
    if (jsonData["nextPageToken"] == null) return [];
    this.nextPageToken = jsonData["nextPageToken"];
    print("1");
    return list;
  }

  Future<List> getNextRelatedVideo(String videoId) async {
    print("getNextRelatedVideo");
    var res = await http.get(
      "${this.url}&maxResults=12&key=${this.key}&relatedToVideoId=$videoId&pageToken=${this.nextPageToken}",
      headers: {"Accept": "application/json"},
    );
    var jsonData = json.decode(res.body);
    if (jsonData['error'] != null) {
      print(jsonData['error']);
      return [];
    }
    if (jsonData['pageInfo']['totalResults'] == null) return [];
    List list = jsonData["items"];
    this.nextPageToken = jsonData["nextPageToken"];

    return list;
  }

  Future<List> getVideoInfo(String videoId) async {
    var res = await http.get(
      "https://www.googleapis.com/youtube/v3/videos?part=statistics&id=$videoId&key=AIzaSyDXf0QJIi2WUdt7N6s7WC7nf7BN4iq-IbM",
      headers: {"Accept": "application/json"},
    );
    var jsonData = json.decode(res.body);
    if (jsonData['error'] != null) {
      print(jsonData['error']);
      return [];
    }
    if (jsonData['pageInfo']['totalResults'] == null) return [];
    List list = jsonData["items"];
    this.nextPageToken = jsonData["nextPageToken"];
    print("2");
    return list;
  }
}
