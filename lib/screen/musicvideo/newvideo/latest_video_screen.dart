import 'package:flutter/material.dart';
import 'package:kpop/widget/video_list.dart';

class LatestVideoScreen extends StatefulWidget {
  @override
  _LatestVideoScreenState createState() => _LatestVideoScreenState();
}

class _LatestVideoScreenState extends State<LatestVideoScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return VideoList(query: "korea idol mv 공식");
  }

  @override
  bool get wantKeepAlive => true;
}
