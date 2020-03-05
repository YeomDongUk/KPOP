import 'package:flutter/material.dart';
import 'package:kpop/pages/ListPage/SoloPage.dart';
import 'package:kpop/pages/ListPage/GroupPage.dart';
import 'package:kpop/pages/RankingPage.dart';
import 'package:kpop/pages/ListPage/AngelPage.dart';

class Body extends StatelessWidget {
  final pgc;
  final sex;
  final title;
  const Body({Key key, this.pgc, this.sex, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscoll) {
        overscoll.disallowGlow();
        return false;
      },
      child: TabBarView(
        physics: const ClampingScrollPhysics(),
        children: [
          SoloPage(sex: sex),
          GroupPage(sex: sex),
          RankingPage(sex: sex),
          AngelPage(),
        ],
        controller: pgc,
      ),
    );
  }
}
