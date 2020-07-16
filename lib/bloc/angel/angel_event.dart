import 'package:equatable/equatable.dart';
import 'package:kpop/data/artist.dart';

abstract class AngelEvent extends Equatable {
  const AngelEvent();
}

class AngelLoad extends AngelEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => '';
}

class AngelSet extends AngelEvent {
  final Artist artist;

  const AngelSet({this.artist});
  @override
  List<Object> get props => [artist];

  @override
  String toString() => 'Arist: ${artist.toMap()}';
}

class AngelRemove extends AngelEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'Remove Angel';
}
