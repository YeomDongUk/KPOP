import 'dart:convert';
import 'dart:io';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:kpop/Color.dart';
import 'package:kpop/Component/GenearMenu.dart';
import 'package:kpop/Component/History.dart';
import 'package:kpop/Object/Http.dart';
import 'package:kpop/Object/LoginToken.dart';
import 'package:kpop/Object/RewardState.dart';
import 'package:kpop/Object/app_localizations.dart';

import 'package:kpop/pages/LoginPage/LoginPage.dart';

import 'StarRefillPage.dart';

class MystarsPage extends StatefulWidget {
  @override
  _MystarsPageState createState() => _MystarsPageState();
}

class _MystarsPageState extends State<MystarsPage> {
  var starCount;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    RewardedVideoAd.instance.listener =
        (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) async {
      if (event == RewardedVideoAdEvent.rewarded) {
        await fetch("IF026", {
          'loginToken': loginToken,
          'typeCode': 'VIDEOAD',
          'starCount': 36,
          'content': '영상 AAD',
          'starCode': 'EVER'
        });
        setState(() {});
        print("rewardType:$rewardType, rewardAmount:$rewardAmount");
      } else if (event == RewardedVideoAdEvent.loaded) {
        print("eventLoad");
      } else if (event == RewardedVideoAdEvent.closed) {
        RewardedVideoAd.instance
            .load(
              adUnitId: RewardedVideoAd.testAdUnitId,
              targetingInfo: MobileAdTargetingInfo(
                keywords: <String>['flutterio', 'beautiful apps'],
                contentUrl: 'https://flutter.io',
                childDirected: false,
                testDevices: <String>[], // Android emulators are considered test devices
              ),
            )
            .catchError((e) => print("error:$e"));
      } else {}
    };
  }

// "open => start => complete => rewarded => closed"

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colors["Base"],
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              AppLocalizations.of(context).translate("MyStars"),
            ),
            centerTitle: false,
          ),
          body: FutureBuilder(
            future: fetch("IF016", {"loginToken": loginToken}),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                var body = jsonDecode(snapshot.data.body);
                int accumStar = 0;
                for (var index in body["starUsageHistory"]) {
                  accumStar = accumStar + index["starCount"];
                }
                starCount = body["myStarCount"];
                return Container(
                  color: colors["Light"],
                  child: ListView(
                    physics: const ClampingScrollPhysics(),
                    children: <Widget>[
                      GenearMenu(
                        maintext: AppLocalizations.of(context).translate("MyStars"),
                        subtext: starCount.toString(),
                        imgsrc: "images/icon_tip_normal.png",
                        bar: false,
                      ),
                      GenearMenu(
                        maintext: AppLocalizations.of(context).translate("EverStars"),
                        subtext: body["everStarCount"].toString(),
                        imgsrc: null,
                        bar: false,
                      ),
                      GenearMenu(
                        maintext: AppLocalizations.of(context).translate("DailyStars"),
                        subtext: body["dailyStarCount"].toString(),
                        imgsrc: "images/icon_question_blue_normal.png",
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => new InformDialog());
                          // );
                        },
                        bar: false,
                      ),
                      GenearMenu(
                        maintext: AppLocalizations.of(context).translate("MyAccumulatedVotes"),
                        subtext: accumStar.toString(),
                        // imgsrc: "images/icon_question_blue_normal.png",
                        onTap: () => print("hi"),
                        bar: false,
                      ),
                      // GenearMenu(
                      //   maintext: AppLocalizations.of(context)
                      //       .translate("Everstarcollectedtoday"),
                      //   subtext: body["todayEverStarCount"].toString(),
                      //   imgsrc: "images/icon_question_blue_normal.png",
                      //   bar: true,
                      // ),
                      History(
                        text: "Star Usage History",
                        imgSrc: "images/icon_star_52x52_normal.png",
                        list: body["starUsageHistory"],
                        accum: false,
                      ),
                      History(
                        text: "Star Accumulation History",
                        imgSrc: "images/icon_star_52x52_normal.png",
                        list: body["starEarnHistory"],
                        accum: true,
                      ),
                    ],
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
          bottomNavigationBar: Visibility(
            // visible: Platform.isAndroid,
            child: Container(
              height: 75,
              child: Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      child: Container(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        color: colors["Base"],
                        child: Column(
                          children: <Widget>[
                            Expanded(child: Image.asset("images/icon_new_normal.png")),
                            Text(
                              "See video ad",
                              style: TextStyle(color: colors["White"]),
                            ),
                            // 738091
                            Text(
                              "Get 36 Stars",
                              style: TextStyle(
                                color: Color(0x77FFFFFF),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        RewardedVideoAd.instance.show();
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      child: Container(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        color: colors["Base"],
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: Image.asset("images/icon_star_home_normal.png"),
                            ),
                            Text(
                              "Star Charging",
                              style: TextStyle(
                                color: colors["White"],
                              ),
                            ),
                            Text(
                              "Station",
                              style: TextStyle(
                                color: colors["White"],
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () => navigate(context, StarRefillPage()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class InformDialog extends Dialog {
  Radius borderRadius = Radius.circular(5);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(borderRadius),
      ),
      child: Container(
        height: 200,
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xFFF19FCD),
                borderRadius: BorderRadius.only(
                  topLeft: borderRadius,
                  topRight: borderRadius,
                ),
              ),
              child: Text(
                "Daily Star",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 20, right: 20),
                // child:
                //  FittedBox(
                child: Text(
                  "Daily stars are stars that are reset every night at 12:00 a.m. (KST)",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              // ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFEFEFEF),
                borderRadius: BorderRadius.only(
                  bottomLeft: borderRadius,
                  bottomRight: borderRadius,
                ),
              ),
              height: 60,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(
                              color: Color(0xFFCCCCCC),
                              width: 0.5,
                            ),
                            top: BorderSide(
                              color: Color(0xFFCCCCCC),
                              width: 1,
                            ),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text("OK"),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: Color(0xFFCCCCCC),
                              width: 0.5,
                            ),
                            top: BorderSide(
                              color: Color(0xFFCCCCCC),
                              width: 1,
                            ),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text("CANCEL"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
