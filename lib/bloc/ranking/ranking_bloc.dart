import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kpop/bloc/Ranking/ranking_state.dart';
import 'package:kpop/bloc/ranking/ranking_event.dart';
import 'package:kpop/data/artist.dart';
import 'package:kpop/repository/ranking_repository.dart';
import 'package:kpop/repository/user_repository.dart';

class RankingBloc extends Bloc<RankingEvent, RankingState> {
  final UserRepository userRepository;
  RankingRepository rankingRepository = RankingRepository();

  RankingBloc({@required this.userRepository})
      : assert(userRepository != null),
        super(RankingInitial());

  @override
  Stream<RankingState> mapEventToState(
    RankingEvent event,
  ) async* {
    if (event is RankingLoad) {
      yield RankingInProgress();

      try {
        String loginToken = await userRepository.getToken();
        List<Artist> artistList = await rankingRepository.getRanking(
          loginToken: loginToken,
          typeCode: event.typeCode,
          genderCode: event.genderCode,
        );
        if (artistList == null) {
          throw Exception("에러");
        }
        yield RankingSuccess(artistList: artistList);
      } catch (error) {
        yield RankingFailure(error: error.toString());
      }
    }
  }
}
