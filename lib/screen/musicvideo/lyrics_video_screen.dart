import 'package:flutter/material.dart';
import 'package:kpop/widget/video_list.dart';

class LyricsVideoScreen extends StatefulWidget {
  @override
  _LyricsVideoScreenState createState() => _LyricsVideoScreenState();
}

class _LyricsVideoScreenState extends State<LyricsVideoScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return VideoList(query: "korea idol lyrics 공식");
  }

  @override
  bool get wantKeepAlive => true;
}
