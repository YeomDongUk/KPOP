import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kpop/Component/InputBox.dart';
import 'package:kpop/Object/Navigate.dart';
import 'package:kpop/Object/app_localizations.dart';
import 'package:kpop/pages/LoginPage/AdditionalPage.dart';
import 'package:kpop/pages/LoginPage/InstaLoginPage.dart';
import 'package:kpop/pages/MainPage.dart';
import 'package:kpop/pages/LoginPage/SignupPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_line_login/flutter_line_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kpop/Color.dart';
import 'package:kpop/Object/UserInform.dart';
import 'package:kpop/Object/Http.dart';
import 'package:kpop/Object/LoginToken.dart' as Login;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colors["Black"],
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: Container(
              color: colors["Black"],
              padding: const EdgeInsets.all(25.0),
              child: ListView(
                physics: const ClampingScrollPhysics(),
                children: <Widget>[
                  GestureDetector(
                    child: Image.asset(
                      "images/icon_login_normal.png",
                      height: MediaQuery.of(context).size.height * 0.35,
                    ),
                    // onTap: () => setState(() {
                    //   KpopFlutter.setLocale(context, new Locale("ko", "KR"));
                    // }),
                  ),
                  LoginMiddle(),
                  LoginBottom(),
                ],
                // color: colors["White"],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///
///                                 Login Middle Area - STL
///
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class LoginMiddle extends StatefulWidget {
  LoginMiddle({Key key}) : super(key: key);

  _LoginMiddleState createState() => _LoginMiddleState();
}

class _LoginMiddleState extends State<LoginMiddle> {
  var _pwController = TextEditingController();
  var _idController = TextEditingController();

  final FocusNode pwFoucsNode = FocusNode();

  _login(BuildContext context, String id, String pw) async {
    var res = await fetch(
      "IF002",
      {
        "registTypeCode": "EMAIL",
        "id": id,
        "password": pw,
        "platformTypeCode": "IOS",
        "pushToken": null
      },
    );
    var body = jsonDecode(res.body);
    if (body["success"]) {
      Login.tokenSave(body["loginToken"]);
      navigateReplace(
        context,
        MainPage(
          user: body["userInfo"],
        ),
      );
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _pwController.dispose();
    _idController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //
    return Container(
      child: Column(
        children: <Widget>[
          Inputbox(
            hintText: AppLocalizations.of(context).translate('email'),
            nextFocusNode: pwFoucsNode,
            keyboardType: TextInputType.emailAddress,
            controller: _idController,
            color: colors["Base"],
          ),
          Container(
            color: colors["Black"],
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Inputbox(
            focusNode: pwFoucsNode,
            hintText: AppLocalizations.of(context).translate('pw'),
            color: colors["Base"],
            isPassword: true,
            controller: _pwController,
          ),
          Container(
            color: colors["Black"],
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          new GestureDetector(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.067,
              decoration: new BoxDecoration(
                  color: colors["Main"], borderRadius: new BorderRadius.all(Radius.circular(5.0))),
              child: new Center(
                child: new Text(
                  AppLocalizations.of(context).translate('login'),
                  // AppLocalizations.of(context).tr('login'),
                  style: TextStyle(
                    color: colors["White"],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            onTap: () => _login(context, _idController.text, _pwController.text),
          ),
          Container(
            color: colors["Black"],
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          new Container(
            alignment: Alignment.centerRight,
            child: Text(
              AppLocalizations.of(context).translate('findPw'),
              style: TextStyle(color: colors["Main"]),
            ),
          ),
          Container(
            color: colors["Black"],
            height: MediaQuery.of(context).size.height * 0.02,
          ),
        ],
      ),
    );
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///
///                                 Login Bottom Area
///
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class LoginBottom extends StatelessWidget {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  final List<String> registTypeCodes = [
    "EMAIL",
    "FACEBOOK",
    "INSTAGRAM",
    "GOOGLE",
    "TWITTER",
    "LINE",
    "LINKEDIN",
  ];

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _flutterLineLogin = new FlutterLineLogin();

  Future _facebookLogin(context) async {
    final facebookLogin = FacebookLogin();
    // facebookLogin
    try {
      final result = await facebookLogin.logIn(['email']);
      print("Ggg");
      if (result.status == FacebookLoginStatus.loggedIn) {
        final FacebookAccessToken accessToken = result.accessToken;
        final token = accessToken.token;
        final AuthCredential credential = FacebookAuthProvider.getCredential(
          accessToken: token,
        );
        final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
        var resultBody = await fetch("IF002",
            {"registTypeCode": registTypeCodes[1], "id": user.uid, "platformTypeCode": "IOS"});

        var res = jsonDecode(resultBody.body);

        if (res["success"]) {
          Login.tokenSave(res["loginToken"]);
          navigateReplace(context, MainPage(user: res["userInfo"]));
        } else {
          var userInform = UserInform(
            registTypeCode: registTypeCodes[1],
            id: user.uid,
            nickname: user.displayName,
            profileImage: user.photoUrl,
            platformTypeCode: "IOS",
          );
          navigate(
            context,
            AdditionalPage(
              info: userInform,
            ),
          );
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _signInWithGoogle(context) async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      print("1");
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      print("2");
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      print("3");
      final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
      var res = await fetch("IF002", {'registTypeCode': registTypeCodes[3], 'id': user.uid});
      var result = jsonDecode(res.body);
      if (result["success"]) {
        print(result["userInfo"]);
        Login.tokenSave(result["loginToken"]);
        navigateReplace(context, MainPage(user: result["userInfo"]));
      } else {
        var userInform = UserInform(
          registTypeCode: registTypeCodes[3],
          id: user.uid,
          nickname: user.displayName,
          profileImage: user.photoUrl,
          platformTypeCode: "IOS",
        );
        navigate(
          context,
          AdditionalPage(
            info: userInform,
          ),
        );
      }
    } catch (error) {
      print("Error $error");
    }
  }

  void _twitterLogin(context) async {
    final AuthCredential credential = TwitterAuthProvider.getCredential(
        authToken: "1445185574-xI0IngGD76ykOyQjfbmX8XjgIHUTHSuh6PNJBc8",
        authTokenSecret: "621zeGuraFXePrWJSGPlxqEM7ks2XelIPgCNWPNZBfoIx");
    final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
    var res = await fetch("IF002", {'registTypeCode': registTypeCodes[4], 'id': user.uid});
    var result = jsonDecode(res.body);
    if (result["success"]) {
      print(result["userInfo"]);
      Login.tokenSave(result["loginToken"]);
      navigateReplace(context, MainPage(user: result["userInfo"]));
    } else {
      var userInform = UserInform(
        registTypeCode: registTypeCodes[4],
        id: user.uid,
        nickname: user.displayName,
        profileImage: user.photoUrl,
        platformTypeCode: "IOS",
      );
      navigate(
        context,
        AdditionalPage(
          info: userInform,
        ),
      );
    }
  }

  Future<Null> _lineLogin(context) async {
    print("good job");
    try {
      await _flutterLineLogin.startLogin(
        (data) async {
          var res = await fetch("IF002", {
            'registTypeCode': registTypeCodes[5],
            'id': data['userID'],
            'platformTypeCode': "IOS",
            'pushToken': Login.pushToken
          });
          var result = jsonDecode(res.body);
          if (result["success"]) {
            // print("reulst÷")
            print(result["userInfo"]);
            Login.tokenSave(result["loginToken"]);
            navigateReplace(context, MainPage(user: result["userInfo"]));
          } else {
            print(result["userInfo"]);
            var userInform = UserInform(
              registTypeCode: registTypeCodes[5],
              id: data['userID'],
              nickname: data['displayName'],
              profileImage: data['pictureUrl'],
              platformTypeCode: "IOS",
            );
            navigate(
              context,
              AdditionalPage(
                info: userInform,
              ),
            );
          }
        },
        () {
          print("falied");
        },
      );
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          // Row(
          // children: <Widget>[
          // Expanded(
          //   child: Container(
          //     color: colors["White"],
          //     height: 1,
          //   ),
          // ),
          // Container(
          //   margin: EdgeInsets.only(left: 10, right: 10),
          //   child: Text(
          //     AppLocalizations.of(context).translate('sns'),
          //     style: TextStyle(color: colors["White"]),
          //   ),
          // ),
          // Expanded(
          //   child: Container(
          //     color: colors["White"],
          //     height: 1,
          //   ),
          // ),
          //   ],
          // ),
          // Container(
          //   color: colors["Black"],
          //   height: MediaQuery.of(context).size.height * 0.02,
          // ),
          // Row(
          //   children: <Widget>[
          //     Expanded(
          //       child: GestureDetector(
          //         child: Image.asset("images/icon_facebook_normal.png"),
          //         onTap: () => _facebookLogin(context),
          //       ),
          //     ),
          //     Expanded(
          //       child: GestureDetector(
          //         child: Image.asset("images/icon_instagram_normal.png"),
          //         onTap: () => navigate(context, InstaLoginPage()),
          //       ),
          //     ),
          //     Expanded(
          //       child: GestureDetector(
          //         child: Image.asset("images/icon_google_normal.png"),
          //         onTap: () => _signInWithGoogle(context),
          //       ),
          //     ),
          //     Expanded(
          //       child: GestureDetector(
          //         child: Image.asset("images/icon_twitter_normal.png"),
          //         onTap: () => _twitterLogin(context),
          //       ),
          //     ),
          //     Expanded(
          //       child: GestureDetector(
          //         child: Image.asset("images/icon_line_normal.png"),
          //         onTap: () => _lineLogin(context),
          //       ),
          //     ),
          //     // Expanded(child: Image.asset("images/icon_linkedin_normal.png")),
          //   ],
          // ),
          Container(
            color: colors["Black"],
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Container(
            color: colors["Black"],
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          new GestureDetector(
            onTap: () => Navigator.push(
                context,
                PageRouteBuilder(
                    opaque: false,
                    pageBuilder: ((BuildContext context, _, __) => SignupPage()),
                    transitionsBuilder: (___, Animation<double> animation, ____, Widget child) {
                      Animation<Offset> custom =
                          Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                              .animate(animation);
                      return SlideTransition(position: custom, child: child);
                    })),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.067,
              decoration: new BoxDecoration(
                  border: Border.all(
                    color: colors["Main"],
                  ),
                  borderRadius: new BorderRadius.all(Radius.circular(5.0))),
              child: new Center(
                child: new Text(
                  AppLocalizations.of(context).translate('SIGNUP'),
                  style: TextStyle(
                    color: colors["Main"],
                    fontWeight: FontWeight.bold,
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

navigate(context, page) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => page,
    ),
  );
}
