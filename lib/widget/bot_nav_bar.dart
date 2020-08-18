import 'package:flutter/material.dart';
import 'package:kpop/static/color.dart';
import 'package:kpop/static/localizations.dart';

class BotNavBar extends StatefulWidget {
  final PageController pageController;

  const BotNavBar({Key key, this.pageController}) : super(key: key);
  @override
  _BotNavBarState createState() => _BotNavBarState();
}

class _BotNavBarState extends State<BotNavBar> {
  PageController _pageController;
  int selectedIndex = 0;

  @override
  void initState() {
    _pageController = widget.pageController;
    super.initState();
  }

  void animateToPage(int index) {
    _pageController.animateToPage(index,
        duration: Duration(milliseconds: 100), curve: Curves.easeOut);
    setState(() {
      selectedIndex = index;
    });
  }

  Widget _buildBottomNavigationItem(int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () => animateToPage(index),
        child: Container(
          color:
              index == selectedIndex ? CustomColor.selected : CustomColor.base,
          alignment: Alignment.center,
          child: Text(
            getNavigationText(index),
            style: TextStyle(
              color: index == selectedIndex ? CustomColor.main : Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  String getNavigationText(int index) {
    switch (index) {
      case 0:
        return getLocalizations.individual30Days;
      case 1:
        return getLocalizations.group30Days;
      case 2:
        return getLocalizations.individual;
      case 3:
        return getLocalizations.group;

      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Row(
        children:
            List.generate(4, (int index) => _buildBottomNavigationItem(index)),
      ),
    );
  }
}
