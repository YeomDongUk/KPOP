import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kpop/Color.dart';
import 'package:kpop/Component/my_flutter_app_icons.dart';
import 'package:kpop/pages/LoginPage/LoginPage.dart';
import 'package:kpop/pages/YoutubePlayer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MvFavoritePage extends StatefulWidget {
  MvFavoritePage({Key key}) : super(key: key);

  _MvFavoritePageState createState() => _MvFavoritePageState();
}

class _MvFavoritePageState extends State<MvFavoritePage> {
  Future initallize;
  List mvFavorite;
  ScrollController _controller;
  getList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    mvFavorite = prefs.getStringList('MvFavorite');
    if (mvFavorite == null) {
      mvFavorite = [];
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initallize = getList();
    _controller = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setStringList('MvFavorite', []);
          setState(() {
            mvFavorite.clear();
          });
        },
        child: Icon(
          MyFlutterApp.trash,
        ),
        backgroundColor: colors["Main"],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: colors["Light"],
        child: FutureBuilder(
          future: initallize,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (mvFavorite.isNotEmpty) {
                return GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 5.0,
                  crossAxisSpacing: 5.0,
                  childAspectRatio: 0.9,
                  controller: _controller,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: mvFavorite.map((value) {
                    // print();
                    // json.decode(value);
                    Map<String, dynamic> result = jsonDecode(value);

                    return GestureDetector(
                      child: Container(
                        color: colors["Black"],
                        margin: EdgeInsets.all(1.0),
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                child: Image.network(
                                  result["videoThum"],
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
                                result["videoTitle"],
                                maxLines: 2,
                                style: TextStyle(color: colors["White"], fontSize: 11),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        navigate(
                          context,
                          YoutubePlay(
                            json: result,
                            favorState: true,
                          ),
                        );
                      },
                    );
                  }).toList(),
                );
              } else {
                return Container(
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            "images/icon_bookmark_230x240_normal.png",
                            color: colors["Main"],
                            scale: 1.2,
                          ),
                          Text(
                            "There are no videos in your favirite.",
                            style: TextStyle(
                              color: colors["White"],
                            ),
                          ),
                          Text(
                            "To add videos. tab on above icon",
                            style: TextStyle(
                              color: colors["White"],
                            ),
                          ),
                          Text(
                            "whenever you see it",
                            style: TextStyle(
                              color: colors["White"],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        color: Color(0x77000000),
                      ),
                    ],
                  ),
                );
              }
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
