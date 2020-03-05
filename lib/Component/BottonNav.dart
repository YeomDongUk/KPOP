import 'package:flutter/material.dart';
import 'package:kpop/Color.dart';
import 'package:kpop/Object/app_localizations.dart';

class BottomNav extends StatelessWidget {
  BottomNav({Key key, this.bottomToggle, this.activeIndex}) : super(key: key);

  final void Function(int index) bottomToggle;
  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      // decoration: BoxDecoration(
      //   border: Border(
      //     bottom: BorderSide(
      //       color: colors['White'],
      //       width: 0.1,
      //     ),
      //   ),
      // ),
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: () {
                bottomToggle(0);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: activeIndex == 0 ? colors["Selected"] : colors["Base"],
                  border: Border(
                    right: BorderSide(
                      color: colors['White'],
                      width: 0.1,
                    ),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  AppLocalizations.of(context).translate("Individual30Days"),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: activeIndex == 0 ? colors["Main"] : colors["White"],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                bottomToggle(1);
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: activeIndex == 1 ? colors["Selected"] : colors["Base"],
                  border: Border(
                    right: BorderSide(
                      color: colors['White'],
                      width: 0.1,
                    ),
                  ),
                ),
                child: Text(
                  AppLocalizations.of(context).translate("Group30Days"),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: activeIndex == 1 ? colors["Main"] : colors["White"],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                bottomToggle(2);
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: activeIndex == 2 ? colors["Selected"] : colors["Base"],
                  border: Border(
                    right: BorderSide(
                      color: colors['White'],
                      width: 0.1,
                    ),
                  ),
                ),
                child: Text(
                  AppLocalizations.of(context).translate("Individual"),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: activeIndex == 2 ? colors["Main"] : colors["White"],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                bottomToggle(3);
              },
              child: Container(
                alignment: Alignment.center,
                color: activeIndex == 3 ? colors["Selected"] : colors["Base"],
                child: Text(
                  AppLocalizations.of(context).translate("Group"),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: activeIndex == 3 ? colors["Main"] : colors["White"],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
