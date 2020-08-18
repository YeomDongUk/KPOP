import 'package:equatable/equatable.dart';
import 'package:kpop/data/artist.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();
}

class FavoriteLoad extends FavoriteEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => '';
}

class FavoriteSet extends FavoriteEvent {
  final Artist artist;

  const FavoriteSet({this.artist});
  @override
  List<Object> get props => [artist];

  @override
  String toString() => 'Arist: ${artist.toMap()}';
}

class FavoriteRemove extends FavoriteEvent {
  final Artist artist;

  const FavoriteRemove({this.artist});

  @override
  List<Object> get props => [artist];

  @override
  String toString() => 'Remove Favorite';
}
