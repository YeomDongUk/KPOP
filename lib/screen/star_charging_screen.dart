import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kpop/data/product.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:kpop/repository/user_repository.dart';

class StarChargingScreen extends StatefulWidget {
  final Product product;

  StarChargingScreen(this.product);
  @override
  _StarChargingScreenState createState() =>
      _StarChargingScreenState(this.product);
}

class _StarChargingScreenState extends State<StarChargingScreen> {
  final Product product;
  FlutterWebviewPlugin flutterWebviewPlugin = FlutterWebviewPlugin();

  _StarChargingScreenState(this.product);

  @override
  void initState() {
    flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged wvs) {
      print(wvs.url);

      if (wvs.url.contains("close.jsp") ||
          wvs.url.contains("cancel.jsp") ||
          wvs.url.contains("return.jsp")) Navigator.of(context).pop();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String loginToken =
        RepositoryProvider.of<UserRepository>(context).loginToken;
    String url = "http://58.229.240.20:9070/payment?" +
        "productName=${product.productName}" +
        "&productPrice=${product.price}" +
        "&loginToken=$loginToken" +
        "&dailyStarCount=${product.dailyStarCount}" +
        "&everStarCount=${product.everStarCount}";
    return WebviewScaffold(
      appBar: AppBar(
        title: Text("Star Charge"),
      ),
      url: url,
    );
  }
}
