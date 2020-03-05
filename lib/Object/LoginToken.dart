import 'package:shared_preferences/shared_preferences.dart';

String loginToken;
Future<Null> tokenSave(String tokenValue) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('loginToken', tokenValue);
  loginToken = tokenValue;
}

Future<String> getLoginToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String tokenValue = prefs.getString('loginToken');
  loginToken = tokenValue;
  return tokenValue;
}

String pushToken;
