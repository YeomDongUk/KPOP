import 'package:flutter/material.dart';
import 'package:kpop/screen/musicvideo/newvideo/popular_video_screen.dart';
import 'package:kpop/screen/musicvideo/newvideo/tv_show_video_screen.dart';
import 'package:kpop/static/color.dart';
import 'package:kpop/screen/musicvideo/newvideo/latest_video_screen.dart';

import 'favorite_video_screen.dart';

class NewVideoScreen extends StatefulWidget {
  @override
  _NewVideoScreenState createState() => _NewVideoScreenState();
}

class _NewVideoScreenState extends State<NewVideoScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TabBar(
          controller: _tabController,
          indicatorColor: CustomColor.main,
          indicatorWeight: 3,
          unselectedLabelColor: Colors.white,
          labelColor: CustomColor.main,
          labelStyle: TextStyle(fontSize: 12.5),
          labelPadding: EdgeInsets.all(0),
          tabs: [
            Tab(text: "LATEST"),
            Tab(text: "POPULAR"),
            Tab(text: "TV SHOW"),
            Tab(text: "FAVORITE"),
          ],
        ),
        Expanded(
          child: Container(
            color: CustomColor.light,
            child: TabBarView(
              physics: ClampingScrollPhysics(),
              controller: _tabController,
              children: <Widget>[
                LatestVideoScreen(),
                PopularVideoScreen(),
                TvShowVideoScreen(),
                FavoriteVideoScreen(),
              ],
            ),
          ),
        )
      ],
    );
  }
}
