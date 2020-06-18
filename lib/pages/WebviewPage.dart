import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:kpop/Object/LoginToken.dart';
import 'package:kpop/Object/Star.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class WebViewPage extends StatefulWidget {
  final Star star;

  const WebViewPage({Key key, this.star}) : super(key: key);
  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  FlutterWebviewPlugin flutterWebviewPlugin = FlutterWebviewPlugin();
  Star star;
  @override
  void initState() {
    star = widget.star;
    flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged wvs) {
      print("/////////////////////////////////////////////");
      print(wvs.url);
      print("/////////////////////////////////////////////");

      if (wvs.url.contains("close.jsp") ||
          wvs.url.contains("cancel.jsp") ||
          wvs.url.contains("return.jsp")) Navigator.of(context).pop();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String loginToken = Provider.of<LoginToken>(context).loginToken;
    String url =
        " http://58.229.240.20:9070/payment?productName=${star.productName}&productPrice=${star.price}&loginToken=$loginToken&dailyStarCount=${star.dailyStarCount}&everStarCount=${star.everStarCount}";
    print(url);
    return WebviewScaffold(
      appBar: AppBar(),
      url: url,
    );
  }
}
