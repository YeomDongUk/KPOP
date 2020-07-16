import 'package:flutter/material.dart';
import 'package:kpop/widget/video_list.dart';

class TvShowVideoScreen extends StatefulWidget {
  @override
  _TvShowVideoScreenState createState() => _TvShowVideoScreenState();
}

class _TvShowVideoScreenState extends State<TvShowVideoScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return VideoList(query: "korea idol tvshow 공식");
  }

  @override
  bool get wantKeepAlive => true;
}
