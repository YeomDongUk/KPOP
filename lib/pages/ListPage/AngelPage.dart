import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:kpop/Color.dart';
import 'package:kpop/Component/Favor.dart';
import 'package:kpop/Component/IdolBar.dart';
import 'package:kpop/Component/SetAngel.dart';
import 'package:kpop/Component/SetFavorite.dart';

import 'package:kpop/Object/Http.dart';
import 'package:kpop/Object/LoginToken.dart';
import 'package:kpop/Object/app_localizations.dart';
import 'package:provider/provider.dart';

// import

class AngelPage extends StatefulWidget {
  @override
  _AngelPageState createState() => _AngelPageState();
}

class _AngelPageState extends State<AngelPage> with AutomaticKeepAliveClientMixin<AngelPage> {
  Map<String, dynamic> angel;
  String loginToken;
  Future initialize;
  List favorite;
  List groupBoy = [];
  List groupGirl = [];
  List indivBoy = [];
  List indivGirl = [];
  getAngel() async {
    print("getAngel");
    final res = await fetch("IF005", {'loginToken': loginToken});
    var body = jsonDecode(res.body);
    if (body["success"])
      angel = body['singer'];
    else
      angel = null;
    return;
  }

  getFavorite() async {
    print("getFavorite");
    final res = await fetch("IF007", {'loginToken': loginToken});
    var body = jsonDecode(res.body);
    if (body["success"]) {
      favorite = body['singer'];
      Set iter = Set.from(favorite);
      groupBoy.clear();
      groupGirl.clear();
      indivBoy.clear();
      indivGirl.clear();
      iter.forEach(
        (element) {
          if (element["typeCode"] == "G") {
            if (element["genderCode"] == "M") {
              groupBoy.add(element);
            } else {
              groupGirl.add(element);
            }
          } else {
            if (element["genderCode"] == "M") {
              indivBoy.add(element);
            } else {
              indivGirl.add(element);
            }
          }
        },
      );
    } else {
      favorite = null;
    }
  }

  getAllList() async {
    await getAngel();
    await getFavorite();
    print("all done");
  }

  setAngel(Map<String, dynamic> star) async {
    print("setAngel");
    final res = await fetch("IF006", {'singerUid': star['uid'], 'loginToken': loginToken});
    var body = jsonDecode(res.body);
    print(body);

    if (body["success"]) {
      this.angel = body['singer'];
    } else {}
    setState(() {});
  }

  setFavorite(Map<String, dynamic> star) async {
    print("hi");
    var typeCode = star['typeCode'];
    var genderCode = star['genderCode'];
    List list;
    print("$typeCode $genderCode");
    final res = await fetch("IF008", {'singerUid': star['uid'], 'loginToken': loginToken});
    var body = jsonDecode(res.body);
    print(body);
    if (body["success"]) {
      if (typeCode == "G") {
        if (genderCode == "M") {
          list = groupBoy;
        } else {
          list = groupGirl;
        }
      } else {
        if (genderCode == "M") {
          list = indivBoy;
        } else {
          list = indivGirl;
        }
      }
      list.add(star);
      setState(() {});
    }
  }

  deleteFavorite(Map<String, dynamic> star) async {
    var typeCode = star['typeCode'];
    var genderCode = star['genderCode'];
    print("$typeCode $genderCode");
    if (typeCode == "G") {
      if (genderCode == "M") {
        await findForDelete(groupBoy, star);
      } else {
        await findForDelete(groupGirl, star);
      }
    } else {
      if (genderCode == "M") {
        await findForDelete(indivBoy, star);
      } else {
        await findForDelete(indivGirl, star);
      }
    }
    setState(() {
      print('delete');
    });
  }

  findForDelete(List list, Map<String, dynamic> star) async {
    final res = await fetch("IF025", {"singerUid": star['uid'], "loginToken": loginToken});
    var body = jsonDecode(res.body);
    print(body);
    if (body["success"])
      for (var element in list) {
        if (element['uid'] == star['uid']) {
          list.remove(element);
          break;
        }
      }
  }

  deleteAngel(Map<String, dynamic> star) async {
    final res = await fetch("IF024", {'singerUid': star['uid'], 'loginToken': loginToken});
    var body = jsonDecode(res.body);
    if (body["success"]) {
      this.angel = null;
    }
    setState(() {});
  }

  callback() async {
    await getAllList();
    setState(() {
      print("hi");
    });
  }

  @override
  void initState() {
    super.initState();
    loginToken = Provider.of<LoginToken>(context, listen: false).loginToken;
    initialize = getAllList();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Container(
      color: colors["Base"],
      child: SafeArea(
        child: FutureBuilder(
          future: initialize,
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var angelFrame;
              var favorFrame;
              if (angel == null) {
                angelFrame = SetAngel(angel: angel, setAngel: setAngel);
              } else {
                angelFrame = Container(
                  key: UniqueKey(),
                  height: height * 0.33,
                  width: width,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: height * 0.33,
                        width: width,
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: Image.network(angel["bannerImage"]),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          height: 80,
                          child: IDolBar(
                            star: angel,
                            setAngel: setAngel,
                            deleteAngel: deleteAngel,
                            deleteFavorite: deleteFavorite,
                            setFavorite: setFavorite,
                            callback: callback,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              if (groupBoy.length == 0 &&
                  indivBoy.length == 0 &&
                  indivGirl.length == 0 &&
                  groupGirl.length == 0) {
                favorFrame = SetFavorite(
                  angel: angel,
                  setFavorite: setFavorite,
                );
              } else {
                favorFrame = Column(
                  children: <Widget>[
                    Favor(
                      key: UniqueKey(),
                      text:
                          "${AppLocalizations.of(context).translate("Boys")} ${AppLocalizations.of(context).translate("Individual")}",
                      list: indivBoy,
                      setAngel: setAngel,
                      deleteAngel: deleteAngel,
                      deleteFavorite: deleteFavorite,
                      setFavorite: setFavorite,
                      callback: callback,
                    ),
                    Favor(
                      key: UniqueKey(),
                      text:
                          "${AppLocalizations.of(context).translate("Girl")} ${AppLocalizations.of(context).translate("Individual")}",
                      list: indivGirl,
                      setAngel: setAngel,
                      deleteAngel: deleteAngel,
                      deleteFavorite: deleteFavorite,
                      setFavorite: setFavorite,
                      callback: callback,
                    ),
                    Favor(
                      key: UniqueKey(),
                      text:
                          "${AppLocalizations.of(context).translate("Girls")} ${AppLocalizations.of(context).translate("Group")}",
                      list: groupGirl,
                      setAngel: setAngel,
                      deleteAngel: deleteAngel,
                      deleteFavorite: deleteFavorite,
                      setFavorite: setFavorite,
                      callback: callback,
                    ),
                    Favor(
                      key: UniqueKey(),
                      text:
                          "${AppLocalizations.of(context).translate("Boy")} ${AppLocalizations.of(context).translate("Group")}",
                      list: groupBoy,
                      setAngel: setAngel,
                      deleteAngel: deleteAngel,
                      deleteFavorite: deleteFavorite,
                      setFavorite: setFavorite,
                      callback: callback,
                    ),
                  ],
                );
              }
              return Container(
                color: colors["Light"],
                child: RefreshIndicator(
                  onRefresh: () => getAllList(),
                  child: ListView(
                    physics: const ClampingScrollPhysics(),
                    children: <Widget>[
                      angelFrame,
                      favorFrame,
                    ],
                  ),
                ),
              );
            } else
              return Container(
                color: colors["Light"],
              );
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
