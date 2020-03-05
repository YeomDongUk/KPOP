import 'package:flutter/material.dart';
import 'package:kpop/Color.dart';
import 'package:kpop/pages/SearchPage.dart';

class AngelBtn extends StatelessWidget {
  final angel;
  final setStar;
  final text;
  AngelBtn({this.angel, this.setStar, this.text});
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.height;
    return GestureDetector(
      child: Stack(
        children: [
          Container(
            width: width,
            margin: EdgeInsets.only(left: 20, right: 20),
            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: colors["Main"], width: 1.5),
              borderRadius: BorderRadius.all(Radius.circular(3)),
            ),
            child: Text(""),
          ),
          Positioned.fill(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              alignment: Alignment.center,
              child: Text(
                text,
                style: TextStyle(
                  color: colors["Main"],
                  fontWeight: FontWeight.w700,
                  fontSize: 17,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 40),
              alignment: Alignment.centerRight,
              child: RotatedBox(
                child: Image.asset(
                  "images/icon_uparrow_normal.png",
                  scale: 2,
                  color: colors["Main"],
                ),
                quarterTurns: 1,
              ),
            ),
          ),
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SearchPage(
              angel: angel,
              setStar: setStar,
              title: text.split(" ")[text.split(" ").length - 1],
            ),
          ),
        );
      },
    );
  }
}
