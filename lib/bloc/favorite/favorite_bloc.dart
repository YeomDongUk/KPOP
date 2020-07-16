import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kpop/api/api.dart';
import 'package:kpop/bloc/favorite/favorite_event.dart';
import 'package:kpop/data/artist.dart';
import 'package:kpop/repository/user_repository.dart';
import 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final UserRepository userRepository;

  FavoriteBloc({@required this.userRepository})
      : assert(userRepository != null);
  @override
  FavoriteInitial get initialState => FavoriteInitial();

  @override
  Stream<FavoriteState> mapEventToState(
    FavoriteEvent event,
  ) async* {
    String loginToken = await userRepository.getToken();

    if (event is FavoriteLoad) {
      try {
        List<Artist> artistList = await Api.getFavorite(
          loginToken: loginToken,
        );
        if (artistList == null) {
          throw Exception("유효하지 않은 로그인토큰 입니다.");
        } else if (artistList.isEmpty) {
          yield FavoriteEmpty();
        } else {
          yield FavoriteSuccess(artistList: artistList);
        }
      } catch (error) {
        yield FavoriteFailure(error: error.toString());
      }
    }
    if (event is FavoriteSet) {
      try {
        List<Artist> artistList = [];
        if (state is FavoriteSuccess) {
          artistList = (state as FavoriteSuccess).artistList;
        }
        Artist artist = await Api.setFavorite(
          loginToken: loginToken,
          singerUid: event.artist.uid,
        );
        if (artist == null) {
          throw Exception("유효하지 않은 로그인토큰 입니다.");
        }
        yield FavoriteSuccess(artistList: [...artistList, artist]);
      } catch (error) {
        yield FavoriteFailure(error: error.toString());
      }
    }
    if (event is FavoriteRemove) {
      try {
        if (state is FavoriteSuccess) {
          FavoriteSuccess _state = state as FavoriteSuccess;
          List<Artist> aritstList = List<Artist>.from(_state.artistList);
          aritstList.remove(event.artist);
          bool result = await Api.removeFavorite(
            loginToken: loginToken,
            singerUid: event.artist.uid,
          );
          if (aritstList.isEmpty) {
            yield FavoriteEmpty();
          } else {
            yield FavoriteSuccess(artistList: aritstList);
          }
          if (result == null) {
            throw Exception("유효하지 않은 로그인토큰 입니다.");
          }
        }
      } catch (error) {
        yield FavoriteFailure(error: error.toString());
      }
    }
  }
}
