import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:http/http.dart' as http;
import 'package:kpop/Color.dart';
import 'package:kpop/Object/Http.dart';
import 'package:kpop/Object/LoginToken.dart';
import 'package:kpop/Object/Navigate.dart';
import 'package:kpop/Object/UserInform.dart';
import 'package:kpop/pages/LoginPage/AdditionalPage.dart';
import 'package:kpop/pages/MainPage.dart';
import 'package:provider/provider.dart';

class InstaLoginPage extends StatefulWidget {
  @override
  _InstaLoginPageState createState() => _InstaLoginPageState();
}

class _InstaLoginPageState extends State<InstaLoginPage> {
  String url =
      "https://api.instagram.com/oauth/authorize?client_id=95ba65817deb4d1c9a62faed67c7ce35&redirect_uri=http://58.229.184.156:9070/&response_type=code";
  @override
  void initState() {
    super.initState();
    final flutterWebviewPlugin = new FlutterWebviewPlugin();

    flutterWebviewPlugin.onUrlChanged.listen((String url) async {
      print(url);
      if (url.indexOf("?code=") != -1) {
        var code = url.split("=")[1];
        flutterWebviewPlugin.close();
        var respones = await http.post("https://api.instagram.com/oauth/access_token", body: {
          "client_id": "95ba65817deb4d1c9a62faed67c7ce35",
          "redirect_uri": "http://58.229.184.156:9070/",
          "client_secret": "6ea246a434da4637852ab19c20dcd68f",
          "code": code,
          "grant_type": "authorization_code"
        });
        var user = jsonDecode(respones.body)['user'];
        var res = await fetch("IF002", {'registTypeCode': "INSTAGRAM", 'id': user["id"]});
        var result = jsonDecode(res.body);
        if (result["success"]) {
          print(result["userInfo"]);
          Provider.of<LoginToken>(context, listen: false).tokenSave(result["loginToken"]);
          navigateReplace(context, MainPage(user: result["userInfo"]));
        } else {
          var userInform = UserInform(
            registTypeCode: "INSTAGRAM",
            id: user["id"],
            nickname: user["username"],
            profileImage: user["profile_picture"],
            platformTypeCode: "IOS",
          );
          navigateReplace(
            context,
            AdditionalPage(
              info: userInform,
            ),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colors["Base"],
      child: SafeArea(
        child: WebviewScaffold(
          appBar: AppBar(
            title: Text("Instagram Login"),
            centerTitle: false,
          ),
          url: url,
          appCacheEnabled: false,
        ),
      ),
    );
  }
}
