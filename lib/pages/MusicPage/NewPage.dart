import 'package:flutter/material.dart';
import 'package:kpop/Color.dart';
import 'package:kpop/Component/HamberNav.dart';
import 'package:kpop/Object/app_localizations.dart';
import 'package:kpop/pages/MusicPage/LatestPage.dart';
import 'package:kpop/pages/MusicPage/MvFavoritePage.dart';

// import

class NewPage extends StatefulWidget {
  @override
  _NewPageState createState() => _NewPageState();
  static String getYoutubeKey(BuildContext context) {
    // _MusicVideoState state = context.ancestorStateOfType(TypeMatcher<_MusicVideoState>());
    return _NewPageState.key;
  }
}

class _NewPageState extends State<NewPage> with TickerProviderStateMixin {
  static String key = "AIzaSyDXf0QJIi2WUdt7N6s7WC7nf7BN4iq-IbM";
// AIzaSyChZAIr8W3fJzrBq-sNMGZ2N583nRXVpC4
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Container(
        color: colors["Base"],
        child: SafeArea(
          child: Container(
            child: Column(
              children: <Widget>[
                TabBar(
                  indicatorColor: colors["Main"],
                  indicatorWeight: 3,
                  unselectedLabelColor: colors["White"],
                  labelColor: colors["Main"],
                  labelStyle: TextStyle(fontSize: 12.5),
                  labelPadding: EdgeInsets.all(0),
                  tabs: [
                    Tab(
                      text: "LATEST",
                    ),
                    Tab(
                      text: "POPULAR",
                    ),
                    Tab(text: "TV SHOW"),
                    Tab(text: "FAVORITE"),
                  ],
                  controller: _tabController,
                ),
                Expanded(
                  child: TabBarView(
                    children: <Widget>[
                      LatestPage(query: "korea idol mv 공식", appbar: false),
                      LatestPage(query: "korea idol popular 공식", appbar: false),
                      LatestPage(query: "korea idol tvshow 공식", appbar: false),
                      MvFavoritePage(),
                    ],
                    controller: _tabController,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//  print(ytResult[index].thumbnail['default']['url']);
