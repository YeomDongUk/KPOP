import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kpop/Color.dart';
import 'package:kpop/Object/Http.dart';
import 'package:kpop/Object/LoginToken.dart';
import 'package:provider/provider.dart';

class SingerInfo extends StatefulWidget {
  final star;
  final setAngel;
  final deleteAngel;
  final deleteFavorite;
  final setFavorite;
  SingerInfo({
    Key key,
    this.star,
    this.setAngel,
    this.deleteAngel,
    this.setFavorite,
    this.deleteFavorite,
  }) : super(key: key);

  @override
  _SingerInfoState createState() => _SingerInfoState();
}

class _SingerInfoState extends State<SingerInfo> {
  bool angel;
  bool favorite;
  bool isDisposed = false;
  var _listInfoFuture;

  callInfo() async {
    var res = await fetch("IF027", {
      "loginToken": Provider.of<LoginToken>(context, listen: false).loginToken,
      "singerUid": widget.star['uid']
    });
    var body = jsonDecode(res.body);
    if (body["success"]) {
      if (!isDisposed)
        setState(() {
          angel = body["angelCode"];
          favorite = body["favoriteCode"];
        });
    } else {}
  }

  @override
  void initState() {
    super.initState();
    _listInfoFuture = callInfo();
  }

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }

  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _listInfoFuture,
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Dialog(
            child: Container(
              height: 400,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () async {
                            if (angel) {
                              await widget.deleteAngel(widget.star);
                              setState(() {
                                angel = false;
                              });
                            } else {
                              await widget.setAngel(widget.star);
                              setState(() {
                                angel = true;
                              });
                            }
                          },
                          child: Container(
                            height: 50,
                            child: Image.asset(
                              "images/icon_angel_230x240_normal.png",
                              color: angel ? colors["Main"] : colors["Base"],
                              scale: 4,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (favorite) {
                              // print(widget.star);
                              widget.deleteFavorite(widget.star);
                              // await widget.deleteAngel(widget.uid);
                              setState(() {
                                favorite = false;
                              });
                            } else {
                              widget.setFavorite(widget.star);
                              // widget.
                              // await widget.setAngel(widget.uid);
                              setState(() {
                                favorite = true;
                              });
                            }
                          },
                          child: Container(
                            height: 40,
                            child: Image.asset(
                              "images/icon_cupid_normal.png",
                              color: favorite ? colors["Main"] : colors["Base"],
                              scale: 2.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        image: new DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(widget.star['profileImage']),
                        ),
                      ),
                      width: 100,
                      height: 100,
                    ),
                    Container(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 5, right: 5),
                          child: Text(
                            widget.star['name'],
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          widget.star["group"] != null ? widget.star["group"]["name"] : "",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              color: colors["White"],
            ),
          );
        } else {
          return Container(
            height: 400,
          );
        }
      },
    );
  }
}
