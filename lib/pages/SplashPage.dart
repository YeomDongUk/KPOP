import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kpop/Color.dart';
import 'package:kpop/Object/LoginToken.dart' as Login;
import 'package:kpop/Object/Navigate.dart';
import 'package:kpop/pages/LoginPage/LoginPage.dart';
import 'package:kpop/pages/MainPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kpop/Object/Http.dart';
import 'dart:convert';

// import 'dart:mirror';
class SplashPage extends StatelessWidget {
  autoLogin(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tokenValue = prefs.getString('loginToken');
    Login.loginToken = tokenValue;
    print("loginToken:$tokenValue");
    await Future.delayed(const Duration(milliseconds: 1500));
    if (tokenValue != null) {
      var res = fetch(
          "IF003", {'loginToken': tokenValue, 'pushToken': Login.pushToken});
      res.then(
        (result) async {
          var body = jsonDecode(result.body);
          var userInfo = body["userInfo"];
          // print(body);
          if (body["success"]) {
            navigateReplace(
              context,
              MainPage(
                user: userInfo,
              ),
            );
          } else {
            navigateReplace(
              context,
              LoginPage(),
            );
          }
        },
      );
    } else {
      navigateReplace(
        context,
        LoginPage(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    autoLogin(context);
    return Container(
      color: colors["Black"],
      child: SafeArea(
        child: Container(
          child: Center(
            child: Image.asset("images/icon_login_normal.png"),
          ),
        ),
      ),
    );
  }
}
