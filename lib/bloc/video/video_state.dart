import 'package:equatable/equatable.dart';
import 'package:kpop/data/music_video.dart';

abstract class VideoState extends Equatable {
  const VideoState();

  @override
  List<Object> get props => [];
}

class VideoInitial extends VideoState {}

class VideoFailure extends VideoState {}

class VideoSuccess extends VideoState {
  final List<MusicVideo> videos;
  final bool hasReachedMax;

  const VideoSuccess({
    this.videos,
    this.hasReachedMax,
  });

  VideoSuccess copyWith({
    List<MusicVideo> videos,
    bool hasReachedMax,
  }) {
    return VideoSuccess(
      videos: videos ?? this.videos,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [videos, hasReachedMax];

  @override
  String toString() =>
      'VideoSuccess { Videos: ${videos.length}, hasReachedMax: $hasReachedMax }';
}
