import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginToken with ChangeNotifier {
  String _loginToken;
  String get loginToken => _loginToken;

  Future<Null> tokenSave(String tokenValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('loginToken', tokenValue);
    _loginToken = tokenValue;
  }

  Future<void> getLoginToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tokenValue = prefs.getString('loginToken');
    _loginToken = tokenValue;
    notifyListeners();
  }
}

String pushToken;
