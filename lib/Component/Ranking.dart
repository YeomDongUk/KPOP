import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kpop/Color.dart';
import 'package:kpop/Component/Vote.dart';
import 'package:kpop/Object/Http.dart';
import 'package:kpop/Object/LoginToken.dart';
import 'package:kpop/Object/Reg.dart';

class Ranking extends StatefulWidget {
  final String singerUid;
  final int ranking;
  final int starCount;
  final String group;
  final String name;
  final color;
  final String profileImage;
  final String date;
  final callback;
  const Ranking({
    Key key,
    this.singerUid,
    this.ranking,
    this.starCount,
    this.group,
    this.name,
    this.color,
    this.profileImage,
    this.date,
    this.callback,
  }) : super(key: key);

  @override
  _RankingState createState() => _RankingState();
}

class _RankingState extends State<Ranking> {
  var starCount;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(10),
        color: widget.color,
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              width: 35,
              alignment: Alignment.center,
              child: Text(
                widget.ranking.toString(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: colors["SubText"],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 20),
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                image: new DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(widget.profileImage),
                ),
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        child: Text(
                          widget.name,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: colors["White"],
                            fontSize: 20,
                          ),
                        ),
                        margin: EdgeInsets.only(right: 10),
                      ),
                      Text(
                        widget.group,
                        style: TextStyle(
                          color: colors["White"],
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${widget.starCount.toString().replaceAllMapped(reg, mathFunc)} points",
                    style: TextStyle(
                        color: colors["SubText"], fontWeight: FontWeight.w100),
                  ),
                ],
              ),
            ),
            widget.date == null
                ? Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 28,
                      child: Image.asset(
                          "images/icon_rightarrow_gray_thin_normal.png"),
                    ),
                  )
                : Expanded(
                    child: Container(
                      height: 40,
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "${widget.date.replaceAll("-", ".")}.",
                        style: TextStyle(color: colors["White"]),
                      ),
                    ),
                  ),
          ],
        ),
      ),
      onTap: () async {
        var res = await fetch("IF015", {'loginToken': loginToken});
        var body = jsonDecode(res.body);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Vote(
              singerUid: widget.singerUid.toString(),
              myStar: body["myStarCount"],
              everStar: body["everStarCount"],
              dailyStar: body["dailyStarCount"],
              callback: widget.callback,
            );
          },
        );
      },
    );
  }
}
