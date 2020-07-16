import 'package:flutter/material.dart';
import 'package:kpop/widget/video_list.dart';

class PopularVideoScreen extends StatefulWidget {
  @override
  _PopularVideoScreenState createState() => _PopularVideoScreenState();
}

class _PopularVideoScreenState extends State<PopularVideoScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return VideoList(query: "korea idol popular 공식");
  }

  @override
  bool get wantKeepAlive => true;
}
