import 'package:flutter/material.dart';
import 'package:kpop/static/color.dart';

class CustomFab extends StatefulWidget {
  final Function(int a) onPressed;
  final String typeCode;
  const CustomFab({Key key, this.onPressed, this.typeCode}) : super(key: key);

  @override
  _CustomFabState createState() => _CustomFabState();
}

class _CustomFabState extends State<CustomFab> {
  bool isOpened = false;
  List<String> months = [
    "JAN",
    "FEB",
    "MAR",
    "APR",
    "MAY",
    "JUN",
    "JUL",
    "AUG",
    "SEP",
    "OCT",
    "NOV",
    "DEC"
  ];

  int checkMonthOver(int mon) {
    if (mon <= 0) mon = 12 + mon;
    return mon;
  }

  void toggled() {
    setState(() {
      this.isOpened = !isOpened;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Visibility(
          visible: isOpened,
          child: Column(
            children: List.generate(6, (index) {
              return Container(
                width: 40,
                height: 40,
                margin: EdgeInsets.only(top: 5, bottom: 5),
                child: FittedBox(
                  child: FloatingActionButton(
                    heroTag: "${widget.typeCode}$index",
                    onPressed: () => widget.onPressed(index),
                    child: Text(
                      months[checkMonthOver(DateTime.now().month - index) - 1],
                      style: TextStyle(color: CustomColor.main),
                    ),
                    elevation: 0,
                    backgroundColor: Colors.white,
                  ),
                ),
              );
            }),
          ),
        ),
        Container(
          width: 40,
          height: 40,
          margin: EdgeInsets.only(top: 5),
          child: FittedBox(
            child: FloatingActionButton(
              heroTag: "${widget.typeCode}Cal",
              onPressed: toggled,
              child: Icon(
                Icons.calendar_today,
                color: Colors.white,
              ),
              elevation: 0,
              backgroundColor: CustomColor.main,
            ),
          ),
        ),
      ],
    );
  }
}
