import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:kpop/data/user.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthSuccess extends AuthState {
  final User userInfo;

  AuthSuccess({@required this.userInfo});
}

class AuthFailure extends AuthState {}

class AuthInProgress extends AuthState {}
