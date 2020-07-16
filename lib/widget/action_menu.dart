import 'package:flutter/material.dart';

class ActionMenu extends StatelessWidget {
  final String imgsrc;
  final Function() onTap;
  final Color color;

  const ActionMenu({Key key, this.imgsrc, this.onTap, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: Image.asset(
          imgsrc,
          color: color,
          width: 40,
        ),
      ),
      onTap: onTap,
    );
  }
}
