import 'package:flutter/material.dart';
import 'package:kpop/Color.dart';
import 'package:kpop/Component/Ranking.dart';
import 'package:kpop/Component/my_flutter_app_icons.dart';
import 'package:kpop/Object/GetList.dart';
import 'package:kpop/Object/LoginToken.dart';
import 'package:provider/provider.dart';

class IndRanking extends StatefulWidget {
  final sex;
  IndRanking({Key key, this.sex}) : super(key: key);

  _IndRanking createState() => _IndRanking();
}

class _IndRanking extends State<IndRanking> with AutomaticKeepAliveClientMixin<IndRanking> {
  bool state;
  bool select = true;
  bool isOpened = false;
  int month = 0;
  var _listBoy = [];
  var _listGirl = [];
  var today = "${DateTime.now().year}${DateTime.now().month}${DateTime.now().day - 1}";

  @override
  void initState() {
    state = true;
    getMonthList(
      api: "IF014",
      typeCode: "I",
      genderCode: "M",
      month: 0,
      orderByCode: "DATE",
      loginToken: Provider.of<LoginToken>(context, listen: false).loginToken,
    ).then((list) {
      setState(() {
        _listBoy = list;
        state = false;
      });
    });
    getMonthList(
      api: "IF014",
      typeCode: "I",
      genderCode: "F",
      month: 0,
      orderByCode: "DATE",
      loginToken: Provider.of<LoginToken>(context, listen: false).loginToken,
    ).then((list) {
      setState(() {
        _listGirl = list;
        state = false;
      });
    });

    super.initState();
  }

  void toggled() {
    setState(() {
      this.isOpened = !isOpened;
      if (!isOpened) {
      } else {}
    });
    print(isOpened);
  }

  void setMonth(int month) {
    this.month = month;
    getMonthList(
      api: "IF014",
      typeCode: "I",
      genderCode: "M",
      month: month,
      orderByCode: "DATE",
      loginToken: Provider.of<LoginToken>(context).loginToken,
    ).then((list) {
      print(list);
      setState(() {
        _listBoy = list;
      });
    });
    getMonthList(
      api: "IF014",
      typeCode: "I",
      genderCode: "F",
      month: month,
      orderByCode: "DATE",
      loginToken: Provider.of<LoginToken>(context).loginToken,
    ).then((list) {
      print(list);
      setState(() {
        _listGirl = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return state
        ? Container(
            color: colors["Light"],
          )
        : RefreshIndicator(
            onRefresh: () async {
              getMonthList(
                api: "IF014",
                typeCode: "I",
                genderCode: "M",
                month: month,
                orderByCode: select ? "DATE" : "VOTE",
                loginToken: Provider.of<LoginToken>(context).loginToken,
              ).then((list) {
                setState(() {
                  _listBoy = list;
                });
              });
              getMonthList(
                api: "IF014",
                typeCode: "I",
                genderCode: "F",
                month: month,
                orderByCode: select ? "DATE" : "VOTE",
                loginToken: Provider.of<LoginToken>(context).loginToken,
              ).then((list) {
                setState(() {
                  _listGirl = list;
                });
              });

              return null;
            },
            child: new Container(
              color: colors["Base"],
              child: new SafeArea(
                top: false,
                child: Scaffold(
                  floatingActionButton: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Visibility(
                        visible: isOpened,
                        child: Column(
                          children: List.generate(6, (index) {
                            return Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.only(top: 5, bottom: 5),
                              child: FittedBox(
                                child: FloatingActionButton(
                                  heroTag: "Ind${index}",
                                  onPressed: () => setMonth(index),
                                  child: Text(
                                    months[check(DateTime.now().month - index) - 1],
                                    style: TextStyle(color: colors["Main"]),
                                  ),
                                  elevation: 0,
                                  backgroundColor: colors["White"],
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        margin: EdgeInsets.only(top: 5),
                        child: FittedBox(
                          child: FloatingActionButton(
                            heroTag: "IndCal",
                            onPressed: toggled,
                            child: Icon(MyFlutterApp.icon_day_normal),
                            elevation: 0,
                            backgroundColor: colors["Main"],
                          ),
                        ),
                      ),
                    ],
                  ),
                  body: Container(
                    color: colors["Light"],
                    height: height,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: widget.sex == 0 ? _listBoy.length : _listGirl.length,
                      itemBuilder: (BuildContext context, int index) {
                        var _list;
                        if (widget.sex == 0)
                          _list = _listBoy;
                        else
                          _list = _listGirl;
                        if (index == 0)
                          return Stack(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Container(
                                    height: 40,
                                    color: colors["Black"],
                                    alignment: Alignment.centerRight,
                                    padding: EdgeInsets.only(right: 15),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        GestureDetector(
                                          child: Container(
                                            color: colors["Black"],
                                            height: 40,
                                            child: Container(
                                              margin: EdgeInsets.all(10),
                                              height: 16,
                                              width: 16,
                                              decoration: BoxDecoration(
                                                color: colors["Black"],
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: select ? colors["Main"] : colors["White"],
                                                ),
                                              ),
                                              padding: EdgeInsets.all(1.5),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: select ? colors["Main"] : colors["White"],
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                            ),
                                          ),
                                          onTap: () async {
                                            if (select == false) {
                                              getMonthList(
                                                api: "IF014",
                                                typeCode: "I",
                                                genderCode: "M",
                                                month: month,
                                                orderByCode: "DATE",
                                                loginToken:
                                                    Provider.of<LoginToken>(context).loginToken,
                                              ).then((list) {
                                                setState(() {
                                                  select = true;
                                                  _listBoy = list;
                                                });
                                              });
                                              getMonthList(
                                                api: "IF014",
                                                typeCode: "I",
                                                genderCode: "F",
                                                month: month,
                                                orderByCode: "DATE",
                                                loginToken:
                                                    Provider.of<LoginToken>(context).loginToken,
                                              ).then((list) {
                                                setState(() {
                                                  select = true;
                                                  _listGirl = list;
                                                });
                                              });
                                            }
                                          },
                                        ),
                                        Image.asset(
                                          "images/icon_time_normal.png",
                                          scale: 2.2,
                                        ),
                                        Container(width: 10, height: 45),
                                        GestureDetector(
                                          child: Container(
                                            height: 40,
                                            color: colors["Black"],
                                            child: Container(
                                              margin: EdgeInsets.all(10),
                                              height: 16,
                                              width: 16,
                                              decoration: BoxDecoration(
                                                color: colors["Black"],
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: !select ? colors["Main"] : colors["White"],
                                                ),
                                              ),
                                              padding: EdgeInsets.all(1.5),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: !select ? colors["Main"] : colors["White"],
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                            ),
                                          ),
                                          onTap: () async {
                                            if (select != false) {
                                              getMonthList(
                                                api: "IF014",
                                                typeCode: "I",
                                                genderCode: "M",
                                                month: month,
                                                orderByCode: "VOTE",
                                                loginToken:
                                                    Provider.of<LoginToken>(context).loginToken,
                                              ).then((list) {
                                                setState(() {
                                                  select = false;

                                                  _listBoy = list;
                                                });
                                              });
                                              getMonthList(
                                                api: "IF014",
                                                typeCode: "I",
                                                genderCode: "F",
                                                month: month,
                                                orderByCode: "VOTE",
                                                loginToken:
                                                    Provider.of<LoginToken>(context).loginToken,
                                              ).then((list) {
                                                setState(() {
                                                  select = false;
                                                  _listGirl = list;
                                                });
                                              });
                                            }
                                          },
                                        ),
                                        Image.asset(
                                          "images/icon_star_36x36_normal.png",
                                          scale: 1.2,
                                          color: colors["White"],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: height * 0.33,
                                    width: width,
                                    child: FittedBox(
                                      fit: BoxFit.cover,
                                      child: Image.network(_list[index]['bannerImage']),
                                    ),
                                  ),
                                ],
                              ),
                              Positioned(
                                bottom: 0,
                                width: width,
                                child: Ranking(
                                  group: _list[index]["group"] == null
                                      ? ""
                                      : _list[index]["group"]["name"],
                                  starCount: _list[index]['startCount'],
                                  ranking: 1,
                                  name: _list[index]["name"],
                                  color: index < 3 ? rankingColor[index] : rankingColor[3],
                                  profileImage: _list[index]['profileImage'],
                                  date: _list[index]['hofDt'],
                                  singerUid: _list[index]["uid"].toString(),
                                  callback: () async {
                                    getMonthList(
                                      api: "IF014",
                                      typeCode: "I",
                                      genderCode: widget.sex == 0 ? "M" : "F",
                                      month: 0,
                                      orderByCode: select ? "DATE" : "VOTE",
                                      loginToken: Provider.of<LoginToken>(context).loginToken,
                                    ).then((list) {
                                      setState(() {
                                        _listGirl = list;
                                      });
                                    });
                                  },
                                ),
                              ),
                            ],
                          );
                        return Ranking(
                          group: _list[index]["group"] == null ? "" : _list[index]["group"]["name"],
                          starCount: _list[index]['startCount'],
                          ranking: 1,
                          name: _list[index]["name"],
                          color: index < 3 ? rankingColor[index] : rankingColor[3],
                          profileImage: _list[index]['profileImage'],
                          date: _list[index]['hofDt'],
                          singerUid: _list[index]["uid"].toString(),
                          callback: () async {
                            getMonthList(
                              api: "IF014",
                              typeCode: "I",
                              genderCode: widget.sex == 0 ? "M" : "F",
                              month: 0,
                              orderByCode: select ? "DATE" : "VOTE",
                              loginToken: Provider.of<LoginToken>(context).loginToken,
                            ).then((list) {
                              setState(() {
                                _listGirl = list;
                              });
                            });
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          );
  }

  @override
  bool get wantKeepAlive => true;
}

List<String> months = [
  "JAN",
  "FEB",
  "MAR",
  "APR",
  "MAY",
  "JUN",
  "JUL",
  "AUG",
  "SEP",
  "OCT",
  "NOV",
  "DEC"
];

List<Color> rankingColor = [
  Color(0xAA0E151C),
  Color(0xFF191E25),
  Color(0xFF131A21),
  Color(0xFF0E151C)
];

int check(int mon) {
  if (mon <= 0) mon = 12 + mon;
  return mon;
}
