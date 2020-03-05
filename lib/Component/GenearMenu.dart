import 'package:flutter/material.dart';
import 'package:kpop/Color.dart';

class GenearMenu extends Container {
  final height;
  final maintext;
  final imgsrc;
  final subtext;
  final bool bar;
  final Function onTap;
  GenearMenu(
      {Key key,
      this.height,
      this.imgsrc,
      this.maintext,
      this.subtext,
      this.bar,
      this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 70,
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Container(
        padding: EdgeInsets.only(top: 15, bottom: 15),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color(0xFFFFFFF),
              width: 1,
            ),
          ),
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(maintext, style: TextStyle(color: colors["White"])),
                      Text(subtext,
                          style: TextStyle(
                              color: Color(0x77FFFFFF), fontSize: 12)),
                    ],
                  ),
                ),
                imgsrc == null
                    ? Container()
                    : GestureDetector(
                        child: Image.asset(
                          imgsrc,
                          scale: 2,
                        ),
                        onTap: () => onTap(),
                      ),
              ],
            ),
            bar
                ? Stack(
                    children: <Widget>[
                      Opacity(
                        opacity: 0.3,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF444444),
                            borderRadius: BorderRadius.all(
                              const Radius.circular(10),
                            ),
                          ),
                          margin: EdgeInsets.only(top: 10),
                          height: 20,
                        ),
                      ),
                      Opacity(
                        opacity: 0.3,
                        child: Container(
                          decoration: BoxDecoration(
                            color: colors["Main"],
                            borderRadius: BorderRadius.all(
                              const Radius.circular(10),
                            ),
                          ),
                          margin: EdgeInsets.only(top: 10),
                          height: 20,
                          width: 100,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        alignment: Alignment.center,
                        child: Text(
                          "21%",
                          style: TextStyle(
                            color: colors["White"],
                          ),
                        ),
                        height: 20,
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
