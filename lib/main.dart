import 'package:kpop/Object/LoginToken.dart';
import 'package:provider/provider.dart';
import './Object/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kpop/pages/SplashPage.dart';
import 'package:kpop/Color.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() => runApp(new KpopFlutter());

class KpopFlutter extends StatefulWidget {
  @override
  _KpopFlutterState createState() => _KpopFlutterState();
  static void setLocale(BuildContext context, Locale newLocale) {
    _KpopFlutterState state = context.findAncestorStateOfType();

    state.changeLocale(newLocale);

    // setState(() {
    //   state.locale = newLocale;
    // });
  }
}

class _KpopFlutterState extends State<KpopFlutter> {
  Locale locale;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  changeLocale(newLocale) {
    setState(() {
      locale = newLocale;
    });
  }

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.getToken().then((token) {
      print("token:$token");
    });
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      pushToken = token;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginToken(),
        )
      ],
      child: MaterialApp(
        title: 'kpop',
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          primaryColor: colors["Base"],
        ),
        home: Container(
          color: Colors.white,
          child: SplashPage(),
        ),
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: new Locale("en", "US"),
        supportedLocales: [
          const Locale('en', 'US'),
          const Locale('ko', 'KR'),
        ],
      ),
    );
  }
}
