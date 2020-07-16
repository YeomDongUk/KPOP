import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:kpop/data/artist.dart';

abstract class HofState extends Equatable {
  const HofState();

  @override
  List<Object> get props => [];
}

class HofInitial extends HofState {}

class HofSuccess extends HofState {
  final List<Artist> artistList;
  const HofSuccess({@required this.artistList});
}

class HofFailure extends HofState {
  final String error;

  const HofFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LoginFailure { error: $error }';
}

class HofInProgress extends HofState {}
