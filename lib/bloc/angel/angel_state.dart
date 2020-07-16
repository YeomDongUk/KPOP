import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:kpop/data/artist.dart';

abstract class AngelState extends Equatable {
  const AngelState();

  @override
  List<Object> get props => [];
}

class AngelInitial extends AngelState {}

class AngelSuccess extends AngelState {
  final Artist artist;
  const AngelSuccess({@required this.artist});
  @override
  List<Object> get props => [artist];

  @override
  String toString() => 'AngelSuccess { artist: $artist }';
}

class AngelEmpty extends AngelState {}

class AngelFailure extends AngelState {
  final String error;

  const AngelFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'AngelFailure { error: $error }';
}

class AngelInProgress extends AngelState {}
