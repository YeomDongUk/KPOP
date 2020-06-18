import 'package:flutter/material.dart';
import 'package:kpop/Color.dart';
import 'package:kpop/Component/Ranking.dart';
import 'package:kpop/Object/GetList.dart';
import 'package:kpop/Object/Http.dart';
import 'package:kpop/Object/LoginToken.dart';
import 'package:provider/provider.dart';

class Group30Ranking extends StatefulWidget {
  final sex;
  Group30Ranking({Key key, this.sex}) : super(key: key);

  _Group30Ranking createState() => _Group30Ranking();
}

class _Group30Ranking extends State<Group30Ranking>
    with AutomaticKeepAliveClientMixin<Group30Ranking> {
  bool state;
  bool select = true;
  List<Color> rankingColor = [
    Color(0xAA0E151C),
    Color(0xFF191E25),
    Color(0xFF131A21),
    Color(0xFF0E151C)
  ];
  var _listBoy = [];
  var _listGirl = [];
  @override
  bool get wantKeepAlive => true;

  var monthAgo =
      new DateTime(DateTime.now().year, DateTime.now().month - 1, DateTime.now().day).toString();

  @override
  void initState() {
    state = true;
    getMonthList(
      api: "IF013",
      typeCode: "G",
      genderCode: "M",
      loginToken: Provider.of<LoginToken>(context, listen: false).loginToken,
    ).then((list) {
      setState(() {
        _listBoy = list;
        state = false;
      });
    });
    getMonthList(
      api: "IF013",
      typeCode: "G",
      genderCode: "F",
      loginToken: Provider.of<LoginToken>(context, listen: false).loginToken,
    ).then((list) {
      setState(() {
        _listGirl = list;
        state = false;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    // print();
    return state
        ? Container(
            color: colors["Light"],
          )
        : RefreshIndicator(
            onRefresh: () async {
              getList(
                typeCode: "I",
                genderCode: "M",
                loginToken: Provider.of<LoginToken>(context).loginToken,
              ).then((list) {
                setState(() {
                  _listBoy = list;
                });
              });
              getList(
                typeCode: "I",
                genderCode: "F",
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
                                padding: EdgeInsets.only(
                                  right: 15,
                                  top: 10,
                                  bottom: 10,
                                ),
                                child: Text(
                                  "${monthAgo.substring(0, 10).replaceAll("-", ".")}. ~ ${DateTime.now().toString().substring(0, 10).replaceAll("-", ".")}.",
                                  style: TextStyle(
                                    color: colors["White"],
                                  ),
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
                              ranking: _list[index]["rank"],
                              name: _list[index]["name"],
                              color: index < 3 ? rankingColor[index] : rankingColor[3],
                              profileImage: _list[index]['profileImage'],
                              singerUid: _list[index]["uid"],
                              callback: () async {
                                getMonthList(
                                  api: "IF013",
                                  typeCode: "G",
                                  genderCode: widget.sex == 0 ? "M" : "F",
                                  loginToken: Provider.of<LoginToken>(context).loginToken,
                                ).then((list) {
                                  setState(() {
                                    _listBoy = list;
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
                      ranking: _list[index]["rank"],
                      name: _list[index]["name"],
                      color: index < 3 ? rankingColor[index] : rankingColor[3],
                      profileImage: _list[index]['profileImage'],
                      singerUid: _list[index]["uid"],
                      callback: () async {
                        getMonthList(
                          api: "IF013",
                          typeCode: "G",
                          genderCode: widget.sex == 0 ? "M" : "F",
                          loginToken: Provider.of<LoginToken>(context).loginToken,
                        ).then((list) {
                          setState(() {
                            _listBoy = list;
                          });
                        });
                      },
                    );
                  },
                ),
              ),
            ),
          );
  }
}
