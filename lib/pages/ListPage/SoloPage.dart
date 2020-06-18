import 'package:flutter/material.dart';
import 'package:kpop/Color.dart';
import 'package:kpop/Component/Ranking.dart';
import 'package:kpop/Object/GetList.dart';
import 'package:kpop/Object/LoginToken.dart';
import 'package:provider/provider.dart';

class SoloPage extends StatefulWidget {
  final sex;
  SoloPage({Key key, this.sex}) : super(key: key);

  _SoloPageState createState() => _SoloPageState();
}

class _SoloPageState extends State<SoloPage> with AutomaticKeepAliveClientMixin<SoloPage> {
  bool state;
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

  @override
  void initState() {
    state = true;
    getList(
      api: "IF012",
      typeCode: "I",
      genderCode: "M",
      loginToken: Provider.of<LoginToken>(context, listen: false).loginToken,
    ).then((list) {
      setState(() {
        _listBoy = list;
      });
    });
    getList(
      api: "IF012",
      typeCode: "I",
      genderCode: "F",
      loginToken: Provider.of<LoginToken>(context, listen: false).loginToken,
    ).then((list) {
      setState(() {
        _listGirl = list;
      });
      state = false;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return state
        ? Container(
            color: colors["Light"],
          )
        : RefreshIndicator(
            onRefresh: () async {
              getList(
                api: "IF012",
                typeCode: "I",
                genderCode: "M",
                loginToken: Provider.of<LoginToken>(context).loginToken,
              ).then((list) {
                if (mounted)
                  setState(() {
                    _listBoy = list;
                  });
              });
              getList(
                api: "IF012",
                typeCode: "I",
                genderCode: "F",
                loginToken: Provider.of<LoginToken>(context).loginToken,
              ).then((list) {
                if (mounted)
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
                          Container(
                            height: height * 0.33,
                            width: width,
                            child: FittedBox(
                              fit: BoxFit.cover,
                              child: Image.network(_list[index]['bannerImage']),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            width: width,
                            child: Ranking(
                              group: _list[index]["group"] == null
                                  ? ""
                                  : _list[index]["group"]["name"],
                              starCount: _list[index]['starCount'],
                              ranking: _list[index]["rank"],
                              name: _list[index]["name"],
                              color: index < 3 ? rankingColor[index] : rankingColor[3],
                              profileImage: _list[index]['profileImage'],
                              singerUid: _list[index]["uid"].toString(),
                              callback: () async {
                                getList(
                                  api: "IF012",
                                  typeCode: "I",
                                  genderCode: widget.sex == 0 ? "M" : "F",
                                  loginToken: Provider.of<LoginToken>(context).loginToken,
                                ).then((list) {
                                  setState(() {
                                    if (widget.sex == 0)
                                      _listBoy = list;
                                    else
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
                      starCount: _list[index]['starCount'],
                      ranking: _list[index]["rank"],
                      name: _list[index]["name"],
                      color: index < 3 ? rankingColor[index] : rankingColor[3],
                      profileImage: _list[index]['profileImage'],
                      singerUid: _list[index]["uid"].toString(),
                      callback: () async {
                        getList(
                          api: "IF012",
                          typeCode: "I",
                          genderCode: widget.sex == 0 ? "M" : "F",
                          loginToken: Provider.of<LoginToken>(context).loginToken,
                        ).then((list) {
                          setState(() {
                            if (widget.sex == 0)
                              _listBoy = list;
                            else
                              _listGirl = list;
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
