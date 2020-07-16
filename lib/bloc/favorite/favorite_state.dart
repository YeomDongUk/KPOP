import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:kpop/data/artist.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

class FavoriteInitial extends FavoriteState {}

class FavoriteSuccess extends FavoriteState {
  final List<Artist> artistList;
  const FavoriteSuccess({@required this.artistList});

  @override
  List<Object> get props => [artistList];

  @override
  String toString() => 'FavoriteSuccess { artistList: ${artistList.length} }';
}

class FavoriteEmpty extends FavoriteState {}

class FavoriteFailure extends FavoriteState {
  final String error;

  const FavoriteFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LoginFailure { error: $error }';
}

class FavoriteInProgress extends FavoriteState {}
