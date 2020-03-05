import 'package:flutter/material.dart';
import 'package:kpop/Color.dart';
import 'package:kpop/Component/AngelBtn.dart';

class SetAngel extends StatelessWidget {
  final Map<String, dynamic> angel;
  final Function setAngel;
  SetAngel({this.angel, this.setAngel});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "images/icon_angel_230x240_normal.png",
            scale: 2,
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              "There's no angel of honor yet!",
              style: TextStyle(color: colors["SubText"], fontSize: 18),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              "Set up your own angel of honor right now!",
              style: TextStyle(
                color: colors["SubText"],
                fontSize: 12,
                fontWeight: FontWeight.w200,
              ),
            ),
          ),
          Container(height: 35),
          AngelBtn(
            angel: angel,
            setStar: setAngel,
            text: "Setting up an Angel",
          ),
        ],
      ),
    );
  }
}
