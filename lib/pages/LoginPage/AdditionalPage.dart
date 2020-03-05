import 'package:flutter/material.dart';
import 'package:kpop/Color.dart';
import 'package:kpop/Component/InputBox.dart';
import 'package:kpop/Object/Http.dart';
import 'dart:convert';
import 'package:kpop/Object/UserInform.dart';
import 'package:kpop/pages/MainPage.dart';

class AdditionalPage extends StatefulWidget {
  final UserInform info;
  AdditionalPage({Key key, @required this.info}) : super(key: key);
  @override
  _AdditionalPageState createState() => _AdditionalPageState();
}

class _AdditionalPageState extends State<AdditionalPage> {
  String id;
  String password;
  String nickname;
  String recommender;

  @override
  void initState() {
    super.initState();
    nickname = widget.info.nickname;
  }

  setNickname(String ninckname) {
    setState(() {
      this.nickname = ninckname;
    });
  }

  setRecommender(String recommender) {
    setState(() {
      this.recommender = recommender;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colors["Base"],
      child: SafeArea(
        // color:
        child: Scaffold(
          appBar: AppBar(
            title: Text("Additional information"),
            centerTitle: false,
          ),
          body: Container(
            color: colors["DeepBase"],
            padding: EdgeInsets.all(20),
            child: Center(
              child: ListView(
                physics: ClampingScrollPhysics(),
                children: <Widget>[
                  Container(
                    child: Text(
                      "You can register wth the nickname you want.",
                      style: TextStyle(
                        color: colors["White"],
                      ),
                    ),
                  ),
                  Inputbox(
                    hintText: "Nic Name",
                    initValue: widget.info.nickname,
                  ),
                  Container(
                    child: Text(
                      "* English, Numbers(3-12 Characters)",
                      style: TextStyle(
                        color: colors["Main"],
                      ),
                    ),
                  ),
                  Inputbox(
                    hintText: "Recommender (Nic Name)",
                  ),
                  Container(
                    child: Text(
                      "* Optional",
                      style: TextStyle(
                        color: colors["Main"],
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        color: colors["Main"],
                        borderRadius: BorderRadius.circular(3),
                      ),
                      height: 50,
                      child: Center(
                        child: Text(
                          "JOIN",
                          style: TextStyle(
                              color: colors["Base"],
                              fontWeight: FontWeight.w700,
                              fontSize: 15),
                        ),
                      ),
                    ),
                    onTap: () async {
                      widget.info.nickname = this.nickname;
                      widget.info.recomMemberNickname = this.recommender;
                      var res = await fetch(
                        "IF001",
                        widget.info,
                      );

                      var body = jsonDecode(res.body);
                      if (body["success"]) {
                        print(body);
                        var userInfo = body["userInfo"];
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainPage(user: userInfo),
                          ),
                        );
                      } else {
                        var code = body["message"].split(":")[0];
                        if (code == "00102") {
                          //닉네임 중복
                          print("닉네임 중복");
                        }
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
