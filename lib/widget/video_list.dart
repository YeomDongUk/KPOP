import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kpop/bloc/video/video_bloc.dart';
import 'package:kpop/bloc/video/video_event.dart';
import 'package:kpop/bloc/video/video_state.dart';
import 'package:kpop/static/color.dart';
import 'package:kpop/widget/music_video_tile.dart';

class VideoList extends StatefulWidget {
  final String query;

  const VideoList({Key key, this.query}) : super(key: key);
  @override
  _VideoListState createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  final ScrollController _scrollController = ScrollController();
  final double _scrollThreshold = 200.0;
  bool hasReachedMax = false;
  VideoBloc _videoBloc;
  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    _videoBloc = VideoBloc(query: widget.query);
    // ..add(VideoFetched());
    super.initState();
  }

  @override
  void dispose() {
    _videoBloc.close();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _videoBloc.add(VideoFetched());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColor.light,
      child: BlocBuilder(
          bloc: _videoBloc,
          builder: (context, state) {
            if (state is VideoSuccess) {
              return ListView.separated(
                controller: _scrollController,
                separatorBuilder: (context, index) => SizedBox(height: 10),
                itemCount: state.hasReachedMax
                    ? state.videos.length ~/ 2
                    : state.videos.length ~/ 2 + 1,
                itemBuilder: (context, index) {
                  if (index != state.videos.length ~/ 2)
                    return Row(
                      children: <Widget>[
                        MusicVideoTile(musicVideo: state.videos[index * 2]),
                        SizedBox(width: 10),
                        MusicVideoTile(musicVideo: state.videos[index * 2 + 1]),
                      ],
                    );
                  return Container(
                    alignment: Alignment.center,
                    child: Center(
                      child: SizedBox(
                        width: 33,
                        height: 33,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                },
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
