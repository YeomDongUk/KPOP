import 'package:flutter/material.dart';
import 'package:kpop/static/color.dart';

class SettingBox extends StatelessWidget {
  final String text;
  final Function() onTap;

  const SettingBox({Key key, this.text, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: CustomColor.main, width: 1.5),
          borderRadius: BorderRadius.all(Radius.circular(3)),
        ),
        child: Row(
          children: <Widget>[
            SizedBox(width: 25),
            Spacer(),
            Text(
              text,
              style: TextStyle(
                color: CustomColor.main,
                fontWeight: FontWeight.w700,
                fontSize: 17,
              ),
            ),
            Spacer(),
            RotatedBox(
              quarterTurns: 1,
              child: Image.asset(
                "assets/icon/icon_uparrow_normal.png",
                width: 25,
                color: CustomColor.main,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
