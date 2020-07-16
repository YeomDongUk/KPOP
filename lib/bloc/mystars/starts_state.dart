import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:kpop/data/star.dart';
import 'package:kpop/data/star_history.dart';

abstract class StarsState extends Equatable {
  const StarsState();

  @override
  List<Object> get props => [];
}

class StarsInitial extends StarsState {}

class StarsSuccess extends StarsState {
  final Star star;
  final List<StarHistory> starEarnHistory;
  final List<StarHistory> starUsageHistory;
  const StarsSuccess({
    @required this.starEarnHistory,
    @required this.starUsageHistory,
    @required this.star,
  });
  @override
  List<Object> get props => [star, starEarnHistory, starUsageHistory];

  @override
  String toString() =>
      'StarsSuccess { star: $star, starEarnHistory:$starEarnHistory, starUsageHistory:$starUsageHistory }';
}

class StarsFailure extends StarsState {
  final String error;

  const StarsFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'StarsFailure { error: $error }';
}

class StarsInProgress extends StarsState {}
