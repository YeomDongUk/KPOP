import 'package:flutter/material.dart';
import 'package:kpop/Color.dart';
import 'package:kpop/Component/HamberNav.dart';
import 'package:kpop/Object/app_localizations.dart';
import 'package:kpop/pages/MusicPage/ArtistPage.dart';
import 'package:kpop/pages/MusicPage/LatestPage.dart';
import 'package:kpop/pages/MusicPage/NewPage.dart';

class MusicVideo extends StatefulWidget {
  @override
  _MusicVideoState createState() => _MusicVideoState();
}

class _MusicVideoState extends State<MusicVideo> {
  int activeIndex;
  PageController _pageController;
  void bottomToggle(int index) {
    setState(() {
      activeIndex = index;
    });
    _pageController.animateToPage(index,
        duration: Duration(milliseconds: 100), curve: Curves.easeOut);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    activeIndex = 0;
    this._pageController = PageController(initialPage: 0, keepPage: true, viewportFraction: 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colors["Base"],
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context).translate("MusicVideo")),
            leading: new Builder(
              builder: (context) {
                return GestureDetector(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: Container(
                    // margin: EdgeInsets.only(top: 5, bottom: 5),
                    // width: 10,
                    // color: colors["Main"],
                    child: Image.asset(
                      "images/icon_list_normal.png",
                      // width: 0,
                      scale: 2.5,
                    ),
                  ),
                );
              },
            ),
            elevation: 0.0,
            actions: <Widget>[
              GestureDetector(
                child: Container(
                  child: Image.asset("images/icon_search_normal.png"),
                  padding: EdgeInsets.all(10),
                ),
                onTap: () {},
              ),
              // GestureDetector(
              //   child: Container(
              //     child: Image.asset("images/icon_setting_normal.png"),
              //     padding: EdgeInsets.only(top: 10, bottom: 10, right: 10),
              //   ),
              // ),
            ],
          ),
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              NewPage(),
              ArtistPage(),
              LatestPage(query: "korea drama ost 공식", appbar: false),
              LatestPage(query: "korea idol lyrics 공식", appbar: false),
            ],
            controller: _pageController,
          ),
          drawer: HamberNav(),
          bottomNavigationBar: Container(
            color: colors["Base"],
            padding: EdgeInsets.only(top: 5),
            height: 52,
            child: Row(
              children: <Widget>[
                MusicNav(
                  imgSrc: "images/icon_new_normal.png",
                  text: "New",
                  onTaped: bottomToggle,
                  activeIndex: activeIndex,
                  index: 0,
                ),
                MusicNav(
                  imgSrc: "images/icon_artist_normal.png",
                  text: "Artist",
                  onTaped: bottomToggle,
                  activeIndex: activeIndex,
                  index: 1,
                ),
                MusicNav(
                  imgSrc: "images/icon_dramaost_normal.png",
                  text: "Drama OST",
                  onTaped: bottomToggle,
                  activeIndex: activeIndex,
                  index: 2,
                ),
                MusicNav(
                  imgSrc: "images/icon_lyrics_normal.png",
                  text: "Lyrics",
                  onTaped: bottomToggle,
                  activeIndex: activeIndex,
                  index: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MusicNav extends Container {
  final String imgSrc;
  final String text;
  final Function onTaped;
  final int activeIndex;
  final int index;
  MusicNav({this.imgSrc, this.text, this.onTaped, this.activeIndex, this.index});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTaped(index),
        child: Container(
          color: colors["Base"],
          child: Column(
            children: <Widget>[
              Expanded(
                child: Image.asset(
                  imgSrc,
                  color: activeIndex == index ? colors["Main"] : colors["White"],
                ),
              ),
              Text(
                text,
                style: TextStyle(
                  color: activeIndex == index ? colors["Main"] : colors["White"],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
