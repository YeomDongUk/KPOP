import 'dart:async';
import 'package:kpop/api/youtube_api.dart';
import 'package:kpop/bloc/video/video_event.dart';
import 'package:kpop/bloc/video/video_state.dart';
import 'package:kpop/data/music_video.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  final YoutubeApi youtubeApi = YoutubeApi();
  final String query;
  String _nextPageToken;
  VideoBloc({this.query});

  @override
  get initialState => VideoInitial();

  @override
  Stream<Transition<VideoEvent, VideoState>> transformEvents(
    Stream<VideoEvent> events,
    TransitionFunction<VideoEvent, VideoState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<VideoState> mapEventToState(VideoEvent event) async* {
    final currentState = state;
    if (event is VideoFetched && !_hasReachedMax(currentState)) {
      try {
        if (currentState is VideoInitial) {
          List<MusicVideo> videos = await _fetchVideos();
          yield VideoSuccess(videos: videos, hasReachedMax: false);
          return;
        }
        if (currentState is VideoSuccess) {
          List<MusicVideo> videos = await _fetchVideos();
          print("aa");
          yield videos.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : VideoSuccess(
                  videos: currentState.videos + videos,
                  hasReachedMax: false,
                );
        }
      } catch (error) {
        print(error);
        yield VideoFailure();
      }
    }
  }

  bool _hasReachedMax(VideoState state) =>
      state is VideoSuccess && state.hasReachedMax;

  Future<List<MusicVideo>> _fetchVideos() async {
    try {
      Map<String, dynamic> map = (await youtubeApi.search(
          query: query, nextPageToken: _nextPageToken));
      this._nextPageToken = map['nextPageToken'];
      print(this._nextPageToken);
      return map['musicVideoList'];
    } catch (error) {
      print(error);
      return [];
    }
  }
}
