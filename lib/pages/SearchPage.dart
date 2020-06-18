import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:kpop/Color.dart';
import 'package:kpop/Object/Http.dart';
import 'package:kpop/Object/LoginToken.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  final setStar;
  final angel;
  final String title;
  SearchPage({Key key, this.angel, this.title, this.setStar}) : super(key: key);

  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Map<String, dynamic> angel;
  String angelName;
  @override
  void initState() {
    super.initState();
    angel = widget.angel;
    if (angel == null) {
      angelName = "";
    } else {
      angelName = "${angel['name']}${angel['group'] != null ? "_" + angel['group']['name'] : ""}";
    }
  }

  final TextEditingController _nameController = TextEditingController();
  List searchList;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: colors["Base"],
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Setting ${widget.title}"),
            centerTitle: false,
            elevation: 0,
          ),
          body: Container(
            color: colors["DeepBase"],
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: colors["White"],
                        ),
                      ),
                    ),
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color: colors["White"],
                              fontSize: 15,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: "Angel ",
                                style: TextStyle(
                                    color: colors["Main"],
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20),
                              ),
                              TextSpan(
                                text: angelName,
                              ),
                            ],
                          ),
                        ),
                        Container(height: 20),
                        Container(
                          decoration: angel == null
                              ? BoxDecoration(
                                  border: Border.all(color: colors["White"], width: 2),
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                )
                              : BoxDecoration(
                                  border: Border.all(color: colors["White"], width: 2),
                                  image: DecorationImage(
                                    image: NetworkImage(angel['profileImage']),
                                    fit: BoxFit.cover,
                                  ),
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                          width: 120,
                          height: 120,
                        ),
                        Container(height: 20),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(3),
                                    bottomLeft: Radius.circular(3),
                                  ),
                                  border: Border.all(color: colors["Main"], width: 0.5),
                                ),
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: TextField(
                                  controller: _nameController,
                                  style: TextStyle(
                                    color: colors["White"],
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Search Idol",
                                    hintStyle: TextStyle(
                                      color: Color(0xAAFFFFFF),
                                    ),
                                  ),
                                  // keyboardType: TextInputType.number,
                                ),
                              ),
                            ),
                            GestureDetector(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: colors["Main"],
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(3),
                                    bottomRight: Radius.circular(3),
                                  ),
                                  border: Border.all(color: colors["Main"], width: 0.5),
                                ),
                                child: Image.asset(
                                  "images/icon_search_normal.png",
                                  scale: 2,
                                ),
                              ),
                              onTap: () async {
                                var res = await fetch("IF004", {
                                  'loginToken':
                                      Provider.of<LoginToken>(context, listen: false).loginToken,
                                  'singerName': _nameController.text
                                });
                                var body = jsonDecode(res.body);
                                setState(() {
                                  searchList = body["singer"];
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: searchList == null ? 0 : searchList.length,
                      itemBuilder: (BuildContext context, int index) {
                        var width = MediaQuery.of(context).size.width;
                        return GestureDetector(
                          onTap: () {
                            print(searchList[index]["uid"]);
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                Radius borderRadius = Radius.circular(5);
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
                                          width: width,
                                          decoration: BoxDecoration(
                                            color: Color(0xFFF19FCD),
                                            borderRadius: BorderRadius.only(
                                              topLeft: borderRadius,
                                              topRight: borderRadius,
                                            ),
                                          ),
                                          child: Text(
                                            "Setting Star",
                                            style: TextStyle(
                                                fontSize: 20, fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: FittedBox(
                                              child: Text(
                                                "Are you sure?",
                                                style: TextStyle(fontSize: 20),
                                              ),
                                            ),
                                          ),
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
                                                    print(searchList[index]["uid"]);
                                                    await widget.setStar(
                                                      searchList[index],
                                                    );
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

                                // return AlertDialog(
                                //   title: Container(
                                //       color: colors["Main"],
                                //       child: Text("Setting ${widget.title}")),
                                //   content: Container(
                                //     child: Text("정말 설정 하시겠습니까?"),
                                //   ),
                                //   actions: <Widget>[
                                //     GestureDetector(
                                //       child: Container(
                                //         padding: EdgeInsets.all(10),
                                //         child: Text("Confirm"),
                                //       ),
                                //       // onTap: () => setting(),
                                //     ),
                                //     GestureDetector(
                                //       child: Container(
                                //         padding: EdgeInsets.all(10),
                                //         child: Text("Cancle"),
                                //       ),
                                //       onTap: () => Navigator.of(context).pop(),
                                //     ),
                                //   ],
                                // );
                              },
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: colors["Sub"],
                              border: Border(
                                bottom: BorderSide(
                                  color: colors["White"],
                                ),
                              ),
                            ),
                            height: 70,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: colors["White"], width: 2),
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    image: new DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(searchList[index]["profileImage"]),
                                    ),
                                  ),
                                  width: 50,
                                  height: 50,
                                ),
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          child: Text(
                                            '${searchList[index]["name"]}',
                                            style: TextStyle(
                                              color: colors["White"],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            "${searchList[index]["voteCount"]}",
                                            style: TextStyle(
                                              color: colors["White"],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
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
