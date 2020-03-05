import 'package:flutter/material.dart';
import 'package:kpop/Color.dart';

class History extends StatefulWidget {
  final String text;
  final List list;
  final String imgSrc;
  final bool accum;

  History({Key key, this.text, this.list, this.imgSrc, this.accum})
      : super(key: key);

  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  bool state;
  @override
  void initState() {
    state = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
              color: Color(0xFF111820),
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFFFFFF),
                  width: 1,
                ),
              ),
            ),
            child: Container(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              child: Row(
                children: <Widget>[
                  Image.asset(
                    widget.imgSrc,
                    scale: 2,
                    color: colors["Main"],
                  ),
                  Expanded(
                    child: Text(
                      widget.text,
                      style: TextStyle(color: Color(0xFFFF2298), fontSize: 20),
                    ),
                  ),
                  RotatedBox(
                    quarterTurns: state ? 0 : 2,
                    child: Image.asset(
                      "images/icon_uparrow_normal.png",
                      scale: 2,
                      color: colors["Main"],
                    ),
                  ),
                ],
              ),
            ),
          ),
          onTap: () => setState(() => state = !state),
        ),
        Visibility(
          visible: state,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.list.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xFFFFFFF),
                      width: 1,
                    ),
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "${widget.list[index]["content"]} ${widget.accum ? "(" + widget.list[index]["starCode"] + " Star)" : ""}",
                          style: TextStyle(
                            color: colors["White"],
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      ),
                      Text(
                        widget.list[index]["starCount"].toString(),
                        style: TextStyle(
                          color: Color(0x88FFFFFF),
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
