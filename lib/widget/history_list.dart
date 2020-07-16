import 'package:flutter/material.dart';
import 'package:kpop/data/star_history.dart';
import 'package:kpop/static/color.dart';

class HistoryTile extends StatefulWidget {
  final String text;
  final List<StarHistory> starHistory;

  const HistoryTile({Key key, this.starHistory, this.text}) : super(key: key);
  @override
  _HistoryTileState createState() => _HistoryTileState();
}

class _HistoryTileState extends State<HistoryTile> {
  bool isOpen = false;
  List<StarHistory> historyList;

  @override
  void initState() {
    historyList = widget.starHistory;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => isOpen = !isOpen),
      child: Column(
        children: [
          Container(
            color: CustomColor.base,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              children: <Widget>[
                Image.asset(
                  "assets/icon/icon_star_52x52_normal.png",
                  color: CustomColor.main,
                  scale: 2,
                ),
                Expanded(
                  child: Text(
                    widget.text,
                    style: TextStyle(color: CustomColor.main, fontSize: 20),
                  ),
                ),
                RotatedBox(
                  quarterTurns: isOpen ? 0 : 2,
                  child: Image.asset(
                    "assets/icon/icon_uparrow_normal.png",
                    scale: 2,
                    color: CustomColor.main,
                  ),
                ),
              ],
            ),
          ),
          if (isOpen)
            ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: historyList.length,
              separatorBuilder: (context, index) => Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Divider(color: Colors.white.withOpacity(0.2), height: 1),
              ),
              itemBuilder: (context, index) {
                StarHistory starHistory = historyList.elementAt(index);
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Row(
                    children: <Widget>[
                      Text(starHistory.content),
                      Text(
                        "(${starHistory.starCode} Star)",
                        style: TextStyle(fontWeight: FontWeight.w200),
                      ),
                      Spacer(),
                      Text(
                        "${starHistory.starCount}",
                        style: TextStyle(
                          color: Color(0x88FFFFFF),
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          // ...historyList.map((history) {
          //   return Container(child: Text(history.content));
          // })
        ],
      ),
    );
  }
}
