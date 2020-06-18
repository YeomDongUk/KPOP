import 'package:flutter/material.dart';
import 'package:kpop/Color.dart';
import 'package:kpop/Object/Http.dart';
import 'dart:convert';

import 'package:kpop/Object/LoginToken.dart';
import 'package:provider/provider.dart';

class Vote extends StatefulWidget {
  final String singerUid;
  final int myStar;
  final int everStar;
  final int dailyStar;

  final callback;
  Vote({
    Key key,
    this.singerUid,
    this.myStar,
    this.everStar,
    this.dailyStar,
    this.callback,
  }) : super(key: key);

  _VoteState createState() => _VoteState();
}

class _VoteState extends State<Vote> {
  TextEditingController starController = new TextEditingController();
  setStart(int unit) {
    if (starController.text == "") {
      if (unit < widget.myStar) {
        starController.text = unit.toString();
      }
    } else {
      int star = int.parse(starController.text) + unit;
      if (star <= widget.myStar) {
        starController.text = star.toString();
      }
    }
  }

  setAllStar() {
    starController.text = widget.myStar.toString();
  }

  setDailyStar() {
    starController.text = widget.dailyStar.toString();
  }

  voteStar(context) async {
    var res = await fetch("IF017", {
      'loginToken': Provider.of<LoginToken>(context, listen: false).loginToken,
      'singerUid': widget.singerUid,
      'starCount': int.parse(starController.text)
    });
    var body = jsonDecode(res.body);
    print(body);
    if (body["success"]) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        // alignment: Alignment.center,
        height: 480,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Text(
                "Star to stars",
                style: TextStyle(
                  color: colors["Base"],
                  fontSize: 20,
                  decoration: TextDecoration.none,
                ),
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                // color: colors["Base"],
                border: Border(
                  bottom: BorderSide(color: colors["Base"], width: 0.5),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(3), topRight: Radius.circular(3)),
                        border: Border.all(color: colors["Base"], width: 0.5),
                      ),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "My Star",
                            style: TextStyle(
                              color: colors["Base"],
                              fontSize: 20,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          Spacer(),
                          Text(
                            widget.myStar.toString(),
                            style: TextStyle(
                              color: colors["Base"],
                              fontSize: 20,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: colors["Base"], width: 0.5),
                      ),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Ever Star",
                            style: TextStyle(
                              color: colors["Base"],
                              fontSize: 20,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          Spacer(),
                          Text(
                            widget.everStar.toString(),
                            style: TextStyle(
                              color: colors["Base"],
                              fontSize: 20,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(3), bottomRight: Radius.circular(3)),
                        border: Border.all(color: colors["Base"], width: 0.5),
                      ),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Daily Star",
                            style: TextStyle(
                              color: colors["Base"],
                              fontSize: 20,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          Spacer(),
                          Text(
                            widget.dailyStar.toString(),
                            style: TextStyle(
                              color: colors["Base"],
                              fontSize: 20,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(height: 10),
                    Table(
                      children: [
                        TableRow(
                          children: [
                            GestureDetector(
                              onTap: () => setStart(1),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(3),
                                  ),
                                  border: Border.all(color: colors["Base"], width: 0.5),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset(
                                      "images/icon_star_60x60_normal.png",
                                      scale: 3,
                                      color: colors["Main"],
                                    ),
                                    Text(
                                      "x 1",
                                      style: TextStyle(
                                        color: colors["Base"],
                                        fontSize: 13,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.w200,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => setStart(10),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(3),
                                  ),
                                  border: Border.all(color: colors["Base"], width: 0.5),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset(
                                      "images/icon_star_60x60_normal.png",
                                      scale: 3,
                                      color: colors["Main"],
                                    ),
                                    Text(
                                      "x 10",
                                      style: TextStyle(
                                        color: colors["Base"],
                                        fontSize: 13,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.w200,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            GestureDetector(
                              onTap: () => setStart(50),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(color: colors["Base"], width: 0.5),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset(
                                      "images/icon_star_60x60_normal.png",
                                      scale: 3,
                                      color: colors["Main"],
                                    ),
                                    Text(
                                      "x 50",
                                      style: TextStyle(
                                        color: colors["Base"],
                                        fontSize: 13,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.w200,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => setStart(100),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(color: colors["Base"], width: 0.5),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset(
                                      "images/icon_star_60x60_normal.png",
                                      scale: 3,
                                      color: colors["Main"],
                                    ),
                                    Text(
                                      "x 100",
                                      style: TextStyle(
                                        color: colors["Base"],
                                        fontSize: 13,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.w200,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            GestureDetector(
                              onTap: () => setAllStar(),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(3),
                                  ),
                                  border: Border.all(color: colors["Base"], width: 0.5),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset(
                                      "images/icon_star_60x60_normal.png",
                                      scale: 3,
                                      color: colors["Main"],
                                    ),
                                    Text(
                                      "x ALL",
                                      style: TextStyle(
                                        color: colors["Base"],
                                        fontSize: 13,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.w200,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => setDailyStar(),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(3),
                                  ),
                                  border: Border.all(color: colors["Base"], width: 0.5),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset(
                                      "images/icon_star_60x60_normal.png",
                                      scale: 3,
                                      color: colors["Main"],
                                    ),
                                    Text(
                                      "x Daily ALL",
                                      style: TextStyle(
                                        color: colors["Base"],
                                        fontSize: 13,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.w200,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(3)),
                        border: Border.all(color: colors["Base"], width: 0.5),
                      ),
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: TextField(
                        controller: starController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Container(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          flex: 5,
                          child: GestureDetector(
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: colors["Base"],
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Text(
                                "Confirm",
                                style: TextStyle(
                                  color: colors["White"],
                                  fontSize: 20,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                            onTap: () async {
                              await voteStar(context);
                              await widget.callback();
                            },
                          ),
                        ),
                        Spacer(
                          flex: 1,
                        ),
                        Expanded(
                          flex: 5,
                          child: GestureDetector(
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: colors["Base"],
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Text(
                                "Cancle",
                                style: TextStyle(
                                  color: colors["White"],
                                  fontSize: 20,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                            onTap: Navigator.of(context).pop,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
