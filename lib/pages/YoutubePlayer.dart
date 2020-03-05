import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kpop/Color.dart';
import 'package:kpop/Object/Navigate.dart';
import 'package:kpop/Object/Reg.dart';
import 'package:kpop/Object/YoutubeApi.dart';
import 'package:kpop/pages/MusicPage/NewPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlay extends StatefulWidget {
  final Map<String, dynamic> json;
  final bool favorState;
  YoutubePlay({Key key, this.json, this.favorState}) : super(key: key);
  @override
  _YoutubePlayState createState() => _YoutubePlayState();
}

class _YoutubePlayState extends State<YoutubePlay> {
  YoutubePlayerController _controller;
  bool favorState;
  YoutubeApi ytApi;
  String _videoId;
  List ytResult = [];
  bool isDisposed = false;
  Map<String, dynamic> videoInfo;
  callAPI() async {
    print('UI callled');
    var infoReuslt = await ytApi.getVideoInfo(_videoId);
    print("VideoId:${_videoId}");
    videoInfo = infoReuslt[0]["statistics"];
    if (videoInfo != null) {
      videoInfo['viewCount'] = videoInfo['viewCount'].toString().replaceAllMapped(reg, mathFunc);
      videoInfo['likeCount'] = videoInfo['likeCount'].toString().replaceAllMapped(reg, mathFunc);
      videoInfo['dislikeCount'] =
          videoInfo['dislikeCount'].toString().replaceAllMapped(reg, mathFunc);
    }
    // videoInfo.forEach((key, value) {
    //   print("key:${videoInfo[key]} value:${videoInfo[value]}");
    // return value;
    // });
    ytResult = await ytApi.getRelatedVideo(_videoId);
    if (mounted) {
      setState(() {
        print('UI updated');
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ytApi = new YoutubeApi(key: NewPage.getYoutubeKey(context));
    favorState = widget.favorState;
    _videoId = widget.json['videoId'];
    _controller = YoutubePlayerController(
      initialVideoId: _videoId,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        disableDragSeek: false,
      ),
    );
    print(widget.json);
    callAPI();
  }

  @override
  void deactivate() {
    // _controller.pause();
    super.deactivate();
  }

  _scrollListner() async {
    List nextPage = await ytApi.getNextRelatedVideo(_videoId);
    nextPage.forEach((value) {
      ytResult.add(value);
    });
    if (!isDisposed) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }

  @override
  Widget build(BuildContext context) {
// YoutubePlayer()

    return Container(
      color: colors["Base"],
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "VideoPlayer",
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: false,
          ),
          body: Column(
            children: <Widget>[
              YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
            
                  ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: colors["Light"],
                  border: Border(
                    bottom: BorderSide(width: 0.2, color: colors["White"]),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(
                        widget.json['videoTitle'],
                        style: TextStyle(
                          color: colors["White"],
                        ),
                        maxLines: 1,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      child: Text(
                        (videoInfo == null ? "" : videoInfo["viewCount"]) + " views",
                        style: TextStyle(
                          color: colors["White"],
                        ),
                        maxLines: 1,
                      ),
                    ),
                    Container(height: 10),
                    Row(
                      children: <Widget>[
                        Container(
                          child: Image.asset(
                            "images/icon_like_normal.png",
                            scale: 2,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Text(
                              videoInfo == null ? "" : videoInfo["likeCount"],
                              style: TextStyle(
                                color: colors["White"],
                              ),
                              maxLines: 1,
                            ),
                          ),
                        ),
                        Container(
                          child: Image.asset(
                            "images/icon_hate_normal.png",
                            scale: 2,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Text(
                              videoInfo == null ? "" : videoInfo["dislikeCount"],
                              style: TextStyle(
                                color: colors["White"],
                              ),
                              maxLines: 1,
                            ),
                          ),
                        ),
                        Expanded(child: Container()),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Image.asset(
                            "images/icon_cloud_normal.png",
                            scale: 2,
                          ),
                        ),
                        GestureDetector(
                          child: Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            child: Image.asset(
                              "images/icon_bookmark_72x72_normal.png",
                              scale: 2,
                              color: favorState ? colors["Main"] : colors["White"],
                            ),
                          ),
                          onTap: () async {
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            List<dynamic> mvFavorite = prefs.getStringList('MvFavorite');
                            var data = jsonEncode(widget.json);
                            if (mvFavorite == null) {
                              prefs.setStringList('MvFavorite', [data]);
                            } else {
                              if (mvFavorite.contains(data)) {
                                mvFavorite.remove(data);
                                favorState = false;
                              } else {
                                mvFavorite.add(data);
                                favorState = true;
                              }
                              await prefs.setStringList('MvFavorite', mvFavorite);
                              setState(() {});
                            }
                            print("hi");
                            // print(mvFavorite);
                          },
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 10, top: 5),
                      child: Row(
                        children: <Widget>[
                          Container(
                            // color: colors["White"],
                            child: Image.asset(
                              "images/icon_downarrow_normal.png",
                              scale: 2,
                            ),
                          ),
                          Expanded(
                            // child: FittedBox(
                            child: Text(
                              widget.json['videoDes'],
                              maxLines: 1,
                              style: TextStyle(
                                color: Color(0x44FFFFFF),
                              ),
                            ),
                            // ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: colors["Light"],
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification scrollInfo) {
                      // print(scrollInfo.metrics);
                      if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
                          scrollInfo is ScrollEndNotification) {
                        // print(scrollInfo.metrics);
                        _scrollListner();
                        return true;
                      }
                      return false;
                    },
                    child: GridView.count(
                      crossAxisCount: 3,
                      mainAxisSpacing: 5.0,
                      crossAxisSpacing: 5.0,
                      childAspectRatio: 0.9,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      // physics: ScrollPhysics(),
                      children: ytResult.map((value) {
                        // print(ytResult.length);
                        var result = value["snippet"];
                        return GestureDetector(
                          child: new Container(
                            color: colors["Black"],
                            margin: new EdgeInsets.all(1.0),
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    child: Image.network(
                                      result["thumbnails"]["high"]["url"],
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  color: colors["Base"],
                                  child: Text(
                                    result["title"],
                                    maxLines: 2,
                                    style: TextStyle(color: colors["White"], fontSize: 11),
                                  ),
                                )
                              ],
                            ),
                          ),
                          onTap: () async {
                            Map<String, dynamic> json = {
                              'videoId': value['id']['videoId'],
                              'videoTitle': result["title"],
                              'videoDes': result["description"],
                              'videoThum': result["thumbnails"]["high"]["url"],
                            };
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            List mvFavorite = prefs.getStringList('MvFavorite');
                            navigateReplace(
                              context,
                              YoutubePlay(
                                favorState: false,
                                json: json,
                              ),
                            );
                            // print(value['id']['videoId']);
                            // setState(() {
                            //   _videoId = value['id']['videoId'];
                            // });
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
