import 'package:equatable/equatable.dart';

abstract class StarsEvent extends Equatable {
  const StarsEvent();
}

class StarsLoad extends StarsEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => '';
}

class StarsAddStar extends StarsEvent {
  // final Artist artist;

  const StarsAddStar();
  @override
  List<Object> get props => [];

  @override
  String toString() => 'Add Star: ';
}
