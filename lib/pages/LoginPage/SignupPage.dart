import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kpop/Color.dart';
import 'package:kpop/Component/InputBox.dart';
import 'package:kpop/Object/Http.dart';
import 'package:kpop/Object/LoginToken.dart';
import 'package:kpop/Object/Navigate.dart';
import 'package:kpop/Object/UserInform.dart';
import 'dart:convert';
import 'package:kpop/Object/app_localizations.dart';
import 'package:kpop/pages/MainPage.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  UserInform userInform;
  List<Inputbox> inputBoxs;
  List<FocusNode> focusNodes = [];
  TextEditingController _emailController;
  TextEditingController _pwController;
  TextEditingController _nicNameController;
  TextEditingController _recoController;

  signUp(context) async {
    try {
      userInform.id = _emailController.text;
      userInform.password = _pwController.text;
      userInform.nickname = _nicNameController.text;
      userInform.recomMemberNickname = _recoController.text;
      userInform.registTypeCode = "EMAIL";
      userInform.platformTypeCode = Platform.isAndroid ? "Android" : "IOS";
      var res = await fetch(
        "IF001",
        userInform.toJson(),
      );

      var body = jsonDecode(res.body);
      var token = body["loginToken"];
      print(body);
      if (body['success'] == true) {
        res = await fetch("IF003", {"loginToken": token});
        body = jsonDecode(res.body);
        if (body['success']) {
          Provider.of<LoginToken>(context, listen: false).tokenSave(token);

          navigateReplace(context, MainPage(user: body["userInfo"]));
        }
      }
    } catch (error) {
      print(error);
    }
  }

  bool validateEmail(String eamil) {
    RegExp regExp = new RegExp(r"(?=.{10,30}$)^[a-zA-Z0-9]+@[a-zA-z0-9]+\.[a-zA-z]+");
    return regExp.hasMatch(eamil);
  }

  bool validatePw(String pw) {
    RegExp regExp = new RegExp(r"(?=.+\d)(?=.+[a-zA-Z])[a-zA-z0-9]{8,20}");
    return regExp.hasMatch(pw);
  }

  bool validateNicName(String nicName) {
    RegExp regExp = new RegExp(r"[A-za-z0-9+]{3,12}$");
    return regExp.hasMatch(nicName);
  }

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _pwController = TextEditingController();
    _nicNameController = TextEditingController();
    _recoController = TextEditingController();
    userInform = new UserInform();
    userInform.registTypeCode = "EMAIL";
    userInform.platformTypeCode = Platform.isAndroid ? "Android" : "IOS";
    for (var i = 0; i < 4; i++) focusNodes.add(FocusNode());
  }

  @override
  void dispose() {
    _emailController.dispose();
    _pwController.dispose();
    _nicNameController.dispose();
    _recoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colors["Base"],
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context).translate('Signup')),
            centerTitle: false,
          ),
          body: Container(
            padding: EdgeInsets.all(20),
            color: colors["DeepBase"],
            child: ListView(
              physics: ClampingScrollPhysics(),
              children: <Widget>[
                Container(
                  child: Text(
                    AppLocalizations.of(context).translate('email'),
                    style: TextStyle(
                      color: colors["White"],
                    ),
                  ),
                ),
                Inputbox(
                  hintText: AppLocalizations.of(context).translate('email'),
                  focusNode: focusNodes[0],
                  nextFocusNode: focusNodes[1],
                  controller: _emailController,
                ),
                Container(
                  child: Text(
                    AppLocalizations.of(context).translate('emailWarning'),
                    style: TextStyle(
                      color: colors["Main"],
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    AppLocalizations.of(context).translate('pw'),
                    style: TextStyle(
                      color: colors["White"],
                    ),
                  ),
                ),
                Inputbox(
                  hintText: AppLocalizations.of(context).translate('pw'),
                  focusNode: focusNodes[1],
                  nextFocusNode: focusNodes[2],
                  controller: _pwController,
                  isPassword: true,
                ),
                Container(
                  child: Text(
                    AppLocalizations.of(context).translate('passWarning'),
                    style: TextStyle(
                      color: colors["Main"],
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    AppLocalizations.of(context).translate('NicName'),
                    style: TextStyle(
                      color: colors["White"],
                    ),
                  ),
                ),
                Inputbox(
                  hintText: AppLocalizations.of(context).translate('NicName'),
                  focusNode: focusNodes[2],
                  controller: _nicNameController,
                  nextFocusNode: focusNodes[3],
                ),
                Container(
                  child: Text(
                    AppLocalizations.of(context).translate('nicWarning'),
                    style: TextStyle(
                      color: colors["Main"],
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    AppLocalizations.of(context).translate('Recommender'),
                    style: TextStyle(
                      color: colors["White"],
                    ),
                  ),
                ),
                Inputbox(
                  hintText: AppLocalizations.of(context).translate('recommender'),
                  focusNode: focusNodes[3],
                  controller: _recoController,
                ),
                Container(
                  child: Text(
                    "",
                    style: TextStyle(
                      color: colors["Main"],
                    ),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      color: colors["Main"],
                      borderRadius: BorderRadius.circular(3),
                    ),
                    height: 50,
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context).translate('SIGNUP'),
                        style: TextStyle(
                            color: colors["Base"], fontWeight: FontWeight.w700, fontSize: 15),
                      ),
                    ),
                  ),
                  onTap: () {
                    bool emailCheck = validateEmail(_emailController.text);
                    bool pwCheck = validatePw(_pwController.text);
                    bool nicCheck = validateNicName(_nicNameController.text);
                    print(emailCheck);
                    print(pwCheck);
                    print(nicCheck);
                    if (emailCheck && pwCheck && nicCheck) {
                      signUp(context);
                    }
                  },
                  //  () => signUp(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
