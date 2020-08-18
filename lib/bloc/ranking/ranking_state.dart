import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:kpop/data/artist.dart';

abstract class RankingState extends Equatable {
  const RankingState();

  @override
  List<Object> get props => [];
}

class RankingInitial extends RankingState {}

class RankingSuccess extends RankingState {
  final List<Artist> artistList;
  const RankingSuccess({@required this.artistList});
}

class RankingFailure extends RankingState {
  final String error;

  const RankingFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LoginFailure { error: $error }';
}

class RankingInProgress extends RankingState {}
