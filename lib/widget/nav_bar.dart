import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Container(
          child: IconButton(
            icon: Image.asset(
              "assets/icon/icon_list_normal.png",
              scale: 2.5,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        );
      },
    );
  }
}
