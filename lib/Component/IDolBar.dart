import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:kpop/Color.dart';
import 'package:kpop/Component/SingerInfo.dart';
import 'package:kpop/Component/Vote.dart';
import 'package:kpop/Object/Http.dart';
import 'package:kpop/Object/LoginToken.dart';
import 'package:provider/provider.dart';

class IDolBar extends StatefulWidget {
  final star;
  final Function deleteAngel;
  final Function setAngel;
  final Function setFavorite;
  final Function deleteFavorite;
  final Function callback;
  IDolBar({
    Key key,
    this.star,
    this.deleteAngel,
    this.setAngel,
    this.setFavorite,
    this.deleteFavorite,
    this.callback,
  }) : super(key: key);
  @override
  _IDolBarState createState() => _IDolBarState();
}

class _IDolBarState extends State<IDolBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      child: Container(
        width: width,
        color: Color(0xAA0E151C),
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                image: new DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(widget.star['profileImage']),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: colors["White"],
                        fontSize: 20,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: "${widget.star['rank']}st  ",
                            style: TextStyle(color: Color(0xFF748192))),
                        TextSpan(text: "${widget.star['name']}  "),
                        TextSpan(
                            text: widget.star["group"] != null ? widget.star["group"]["name"] : "",
                            style: TextStyle(fontSize: 13)),
                      ],
                    ),
                  ),
                  Container(height: 5),
                  Container(
                    height: 20,
                    padding: EdgeInsets.only(right: 10),
                    alignment: Alignment.bottomRight,
                    decoration: BoxDecoration(
                      color: Color(0xFF49193B),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: colors["Main"]),
                    ),
                    child: Text(
                      "${widget.star['starCount']}",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              width: 30,
              child: GestureDetector(
                child: Image.asset("images/icon_vote_select.png"),
                onTap: () async {
                  var res = await fetch("IF015",
                      {'loginToken': Provider.of<LoginToken>(context, listen: false).loginToken});
                  var body = jsonDecode(res.body);
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Vote(
                        singerUid: widget.star['uid'].toString(),
                        myStar: body["myStarCount"],
                        everStar: body["everStarCount"],
                        dailyStar: body["dailyStarCount"],
                        callback: widget.callback,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return SingerInfo(
              star: widget.star,
              deleteAngel: widget.deleteAngel,
              setAngel: widget.setAngel,
              deleteFavorite: widget.deleteFavorite,
              setFavorite: widget.setFavorite,
            );
          },
        );
      },
    );
  }
}
