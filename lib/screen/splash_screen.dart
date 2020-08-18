import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Hero(
            tag: "logo",
            child: Image.asset("assets/icon/icon_login_normal.png"),
          ),
        ),
      ),
    );
  }
}
