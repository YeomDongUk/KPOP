import 'package:flutter/material.dart';
import 'package:kpop/Component/BottonNav.dart';
import 'package:kpop/Color.dart';
import 'package:kpop/pages/Ranking/Group30Ranking.dart';
import 'package:kpop/pages/Ranking/Ind30Ranking.dart';
import 'package:kpop/pages/Ranking/GroupRanking.dart';
import 'package:kpop/pages/Ranking/IndRanking.dart';

class RankingPage extends StatefulWidget {
  final sex;
  RankingPage({Key key, this.sex}) : super(key: key);

  _RankingPageState createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage>
    with SingleTickerProviderStateMixin {
  PageController _pageController;
  bool isOpened;
  int activeIndex;
  var now = new DateTime.now();
  var month;
  void _bottomToggle(int index) {
    setState(() {
      this.activeIndex = index;
    });
    _pageController.animateToPage(index,
        duration: Duration(milliseconds: 100), curve: Curves.easeOut);
  }

  @override
  void initState() {
    this.isOpened = true;
    this.activeIndex = 0;
    this._pageController =
        PageController(initialPage: 0, keepPage: true, viewportFraction: 1.0);
    month = now.month;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colors["Base"],
      child: SafeArea(
        child: Scaffold(
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              // SoloPage(),
              Ind30Ranking(sex: widget.sex),
              Group30Ranking(sex: widget.sex),
              IndRanking(sex: widget.sex),
              GroupRanking(sex: widget.sex),
              // SoloPage(),
              // SoloPage(),
              // SoloPage(),
            ],
            controller: _pageController,
          ),
          bottomNavigationBar:
              BottomNav(activeIndex: activeIndex, bottomToggle: _bottomToggle),
          // floatingActionButton: activeIndex>1?  Column(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: mkfab(month + 1),
          // ):Container(),
        ),
      ),
    );
  }
}
