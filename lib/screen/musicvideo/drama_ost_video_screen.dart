import 'package:flutter/material.dart';
import 'package:kpop/widget/video_list.dart';

class DramaOstVideoScreen extends StatefulWidget {
  @override
  _DramaOstVideoScreenState createState() => _DramaOstVideoScreenState();
}

class _DramaOstVideoScreenState extends State<DramaOstVideoScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return VideoList(query: "korea drama ost 공식");
  }

  @override
  bool get wantKeepAlive => true;
}
