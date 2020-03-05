import 'package:flutter/material.dart';
import 'package:kpop/Color.dart';

class SlideList extends StatefulWidget {
  final String title;
  final String content;
  final int index;
  final bool flag;
  SlideList({Key key, this.index, this.title, this.content, this.flag}) : super(key: key);

  _SlideList createState() => _SlideList();
}

class _SlideList extends State<SlideList> {
  bool isToggled;
  var barColor = Color(0xFF1F2734);

  void toggle() {
    setState(() {
      isToggled = !isToggled;
    });
  }

  @override
  void initState() {
    this.isToggled = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          child: Container(
            color: barColor,
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Container(
              decoration: BoxDecoration(
                color: barColor,
                border: Border(
                  bottom: BorderSide(
                    color: colors["White"],
                    width: 0.15,
                  ),
                ),
              ),
              height: 80,
              child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    // color: colors["Black"],
                    margin: EdgeInsets.only(left: 5, right: 13),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.65,
                    ),
                    child: Text(
                      widget.title,
                      style: TextStyle(color: colors["White"], fontSize: 17.5),
                    ),
                  ),
                  widget.flag
                      ? Container(
                          child: Text(
                            "NEW",
                            style: TextStyle(
                                color: colors["Main"], fontSize: 13, fontWeight: FontWeight.bold),
                            maxLines: 1,
                          ),
                        )
                      : Container(),
                  Spacer(),
                  Container(
                    child: isToggled
                        ? Image.asset(
                            "images/icon_uparrow_normal.png",
                            // height: (),
                            scale: 2,
                            color: colors["White"],
                          )
                        : Image.asset(
                            "images/icon_downarrow_normal.png",
                            // height: (),
                            scale: 2,
                            color: colors["White"],
                          ),
                  )
                ],
              ),
            ),
          ),
          onTap: toggle,
        ),
        Visibility(
          child: Container(
            padding: EdgeInsets.all(25),
            child: Text(
              widget.content,
              style: TextStyle(color: colors["White"]),
            ),
            // height: 300,
            width: MediaQuery.of(context).size.width,
            color: Color(0xFF10151A),
          ),
          visible: isToggled,
        ),
      ],
    );
  }
}
