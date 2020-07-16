import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kpop/bloc/auth/auth_bloc.dart';
import 'package:kpop/bloc/auth/auth_event.dart';
import 'package:kpop/bloc/login/login_event.dart';
import 'package:kpop/bloc/login/login_state.dart';
import 'package:kpop/repository/user_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthBloc authenticationBloc;

  LoginBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null);

  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginInProgress();

      try {
        Map<String, dynamic> map = await userRepository.authenticate(
          id: event.id,
          password: event.password,
        );
        if (map == null) {
          throw Exception("아이디 또는 비밀번호가 틀렸습니다.");
        }
        authenticationBloc
            .add(AuthLoggedIn(token: map['loginToken'], user: map['userInfo']));
        yield LoginInitial();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
