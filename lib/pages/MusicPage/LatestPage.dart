import 'package:flutter/material.dart';
import 'package:kpop/Color.dart';
import 'package:kpop/Object/YoutubeApi.dart';
import 'package:kpop/pages/LoginPage/LoginPage.dart';
import 'package:kpop/pages/MusicPage/NewPage.dart';

import 'package:kpop/pages/YoutubePlayer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LatestPage extends StatefulWidget {
  final String query;
  final bool appbar;
  LatestPage({Key key, this.appbar, this.query}) : super(key: key);

  @override
  _LatestPageState createState() => _LatestPageState();
}

class _LatestPageState extends State<LatestPage> with AutomaticKeepAliveClientMixin<LatestPage> {
  YoutubeApi ytApi;
  // StrignMusicVideo.getYoutubeKey();
  ScrollController _controller;
  List ytResult = [];
  String query;
  callAPI() async {
    print('UI callled');

    ytResult = await ytApi.search(query);
    if (mounted)
      setState(() {
        print('UI Updated');
      });
  }

  _scrollListner() async {
    List nextPage = await ytApi.nextPage(query);
    if (mounted)
      nextPage.forEach((value) {
        setState(() {
          ytResult.add(value);
        });
      });
  }

  @override
  void initState() {
    super.initState();
    query = widget.query;
    ytApi = new YoutubeApi(key: NewPage.getYoutubeKey(context));
    _controller = ScrollController();
    callAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colors["Light"],
      padding: EdgeInsets.all(5),
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
              scrollInfo is ScrollEndNotification) {
            _scrollListner();
            return true;
          }
          return false;
        },
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 5.0,
          crossAxisSpacing: 5.0,
          childAspectRatio: 0.9,
          controller: _controller,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: ytResult.map((value) {
            var result = value["snippet"];

            return GestureDetector(
              child: Container(
                color: colors["Black"],
                margin: EdgeInsets.all(1.0),
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
                    ),
                  ],
                ),
              ),
              onTap: () async {
                print(value['id']['videoId']);
                Map<String, dynamic> json = {
                  'videoId': value['id']['videoId'],
                  'videoTitle': result["title"],
                  'videoDes': result["description"],
                  'videoThum': result["thumbnails"]["high"]["url"],
                };
                SharedPreferences prefs = await SharedPreferences.getInstance();
                List mvFavorite = prefs.getStringList('MvFavorite');

                navigate(
                  context,
                  YoutubePlay(
                    json: json,
                    favorState: false,
                  ),
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
