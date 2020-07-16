import 'package:kpop/data/user.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthStarted extends AuthEvent {}

class AuthLoggedIn extends AuthEvent {
  final String token;
  final User user;
  const AuthLoggedIn({@required this.token, @required this.user});

  @override
  List<Object> get props => [token];

  @override
  String toString() => 'AuthLoggedIn { token: $token , user:${user.toMap()}';
}

class AuthLoggedOut extends AuthEvent {}
