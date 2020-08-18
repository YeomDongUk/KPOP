import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginButtonPressed extends LoginEvent {
  final String id;
  final String password;

  const LoginButtonPressed({
    @required this.id,
    @required this.password,
  });

  @override
  List<Object> get props => [id, password];

  @override
  String toString() =>
      'LoginButtonPressed { username: $id, password: $password }';
}
