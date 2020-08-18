import 'package:flutter/material.dart';
import 'package:kpop/data/board.dart';
import 'package:kpop/static/color.dart';

class BoardTile extends StatefulWidget {
  final Board board;

  const BoardTile({Key key, this.board}) : super(key: key);

  @override
  _BoardTileState createState() => _BoardTileState();
}

class _BoardTileState extends State<BoardTile> {
  bool isOpened = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () => setState(() => isOpened = !isOpened),
          child: Container(
            color: CustomColor.boxColor,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Row(
              children: <Widget>[
                Text(
                  widget.board.title,
                  style: TextStyle(fontSize: 17.5),
                ),
                SizedBox(width: 13),
                if (widget.board.newYn == "N")
                  Text(
                    "NEW",
                    style: TextStyle(
                      color: CustomColor.main,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                Spacer(),
                RotatedBox(
                  quarterTurns: isOpened ? 0 : 2,
                  child: Image.asset(
                    "assets/icon/icon_uparrow_normal.png",
                    scale: 2,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (isOpened)
          Container(
            color: Colors.black,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Text(widget.board.content),
          ),
      ],
    );
  }
}
