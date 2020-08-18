import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kpop/bloc/auth/auth_event.dart';
import 'package:kpop/bloc/auth/auth_state.dart';
import 'package:kpop/repository/user_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository userRepository;

  AuthBloc({@required this.userRepository})
      : assert(userRepository != null),
        super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AuthStarted) {
      final bool hasToken = await userRepository.hasToken();
      if (hasToken) {
        String loginToken = await userRepository.getToken();
        Map<String, dynamic> map =
            await userRepository.autoSignIn(loginToken: loginToken);
        if (map != null) {
          await userRepository.persistToken(map['loginToken']);
          yield AuthSuccess(userInfo: map['userInfo']);
        } else {
          yield AuthFailure();
        }
      } else {
        yield AuthFailure();
      }
    }

    if (event is AuthLoggedIn) {
      yield AuthInProgress();
      await userRepository.persistToken(event.token);
      yield AuthSuccess(userInfo: event.user);
    }

    if (event is AuthLoggedOut) {
      yield AuthInProgress();
      await userRepository.deleteToken();
      yield AuthFailure();
    }
  }
}
