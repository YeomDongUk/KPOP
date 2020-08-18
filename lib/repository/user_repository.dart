import 'package:flutter/material.dart';
import 'package:kpop/api/api.dart';
import 'package:kpop/data/star.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  String loginToken;
  Future<Map<String, dynamic>> authenticate({
    @required String id,
    @required String password,
  }) async {
    Map<String, dynamic> result = await Api.signIn(
      id: id,
      password: password,
    );
    print("result: $result");
    return result;
  }

  Future<Map<String, dynamic>> autoSignIn({@required String loginToken}) async {
    Map<String, dynamic> result = await Api.autoSignIn(
      loginToken: loginToken,
    );
    return result;
  }

  Future<String> getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    this.loginToken = pref.getString('loginToken');
    return this.loginToken;
  }

  Future<void> deleteToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove('loginToken');
    loginToken = null;
    return;
  }

  Future<void> persistToken(String loginToken) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    this.loginToken = loginToken;
    await pref.setString('loginToken', loginToken);
    return;
  }

  Future<bool> hasToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('loginToken') != null ? true : false;
  }

  Future<Star> getMyStar() async {
    return await Api.getMyStar(loginToken: loginToken);
  }
}
