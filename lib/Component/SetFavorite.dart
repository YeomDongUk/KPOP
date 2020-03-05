import 'package:flutter/material.dart';
import 'package:kpop/Color.dart';
import 'package:kpop/Component/AngelBtn.dart';

class SetFavorite extends StatelessWidget {
  final Map<String, dynamic> angel;
  final Function setFavorite;
  SetFavorite({this.angel, this.setFavorite});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "images/icon_bookmark_230x240_normal.png",
            scale: 2,
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              "I don't have my favorite idol yet!",
              style: TextStyle(color: colors["SubText"], fontSize: 18),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              "Set up your idol favorite!",
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
            setStar: setFavorite,
            text: "Setting up an Favorites",
          ),
        ],
      ),
    );
  }
}
