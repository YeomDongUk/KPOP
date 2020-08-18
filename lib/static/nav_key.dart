import 'package:flutter/material.dart';

class NavKey {
  static GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();
  static NavigatorObserver navigatorObserver = NavigatorObserver();
  static Future<dynamic> push(
      {@required Widget page, @required String pageName}) async {
    return await NavKey.globalKey.currentState.push(
      MaterialPageRoute(
        builder: (_) => page,
        settings: RouteSettings(name: pageName),
      ),
    );
  }

  static pushReplace({@required Widget page, @required String pageName}) async {
    return await NavKey.globalKey.currentState.pushReplacement(
      MaterialPageRoute(
        builder: (_) => page,
        settings: RouteSettings(name: pageName),
      ),
    );
  }

  static void popUntil({@required String destination}) {
    NavKey.globalKey.currentState.popUntil(ModalRoute.withName(destination));
  }

  static void pop() {
    NavKey.globalKey.currentState.pop();
  }
}
