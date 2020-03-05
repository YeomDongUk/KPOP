import 'package:flutter/material.dart';
import 'package:kpop/pages/MainPage.dart';

navigateReplace(BuildContext context, dynamic page) {
  if (page.runtimeType == MainPage)
    return Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        settings: RouteSettings(name: "/MainPage"),
        builder: (context) => page,
      ),
    );
  return Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => page,
    ),
  );
}

navigate(context, Widget page) {
  String pageName = page.runtimeType.toString();
  return Navigator.push(
    context,
    MaterialPageRoute(
      settings: RouteSettings(name: "/$pageName"),
      builder: (BuildContext context) => page,
    ),
  );
}
