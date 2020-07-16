import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kpop/api/api.dart';
import 'package:kpop/bloc/angel/angel_state.dart';
import 'package:kpop/bloc/angel/angel_event.dart';
import 'package:kpop/data/artist.dart';
import 'package:kpop/repository/user_repository.dart';

class AngelBloc extends Bloc<AngelEvent, AngelState> {
  final UserRepository userRepository;

  AngelBloc({@required this.userRepository}) : assert(userRepository != null);
  @override
  AngelInitial get initialState => AngelInitial();

  @override
  Stream<AngelState> mapEventToState(
    AngelEvent event,
  ) async* {
    String loginToken = await userRepository.getToken();

    if (event is AngelLoad) {
      try {
        Artist artist = await Api.getAngel(
          loginToken: loginToken,
        );
        if (artist == null) {
          throw Exception("유효하지 않은 로그인토큰 입니다.");
        } else if (artist.uid == null) {
          yield AngelEmpty();
        } else {
          yield AngelSuccess(artist: artist);
        }
      } catch (error) {
        yield AngelFailure(error: error.toString());
      }
    }
    if (event is AngelSet) {
      yield AngelInProgress();
      try {
        Artist artist = await Api.setAngel(
          loginToken: loginToken,
          singerUid: event.artist.uid,
        );
        if (artist == null) {
          throw Exception("유효하지 않은 로그인토큰 입니다.");
        } else {
          yield AngelSuccess(artist: artist);
        }
      } catch (error) {
        yield AngelFailure(error: error.toString());
      }
    }

    if (event is AngelRemove) {
      yield AngelInProgress();
      try {
        bool result = await Api.removeAngel(
          loginToken: loginToken,
        );
        if (result == null) {
          throw Exception("유효하지 않은 로그인토큰 입니다.");
        } else {
          yield AngelEmpty();
        }
      } catch (error) {
        yield AngelFailure(error: error.toString());
      }
    }
  }
}
