import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kpop/bloc/hof/hof_state.dart';
import 'package:kpop/bloc/hof/hof_event.dart';
import 'package:kpop/data/artist.dart';
import 'package:kpop/repository/hof_repository.dart';
import 'package:kpop/repository/user_repository.dart';

class HofBloc extends Bloc<HofEvent, HofState> {
  final UserRepository userRepository;
  HofRepository _hofRepository = HofRepository();

  HofBloc({@required this.userRepository})
      : assert(userRepository != null),
        super(HofInitial());

  @override
  Stream<HofState> mapEventToState(
    HofEvent event,
  ) async* {
    if (event is HofMonthlyLoad) {
      yield HofInProgress();

      try {
        String loginToken = await userRepository.getToken();
        List<Artist> artistList = await _hofRepository.getMonthlyHof(
          loginToken: loginToken,
          typeCode: event.typeCode,
          genderCode: event.genderCode,
        );
        if (artistList == null) {
          throw Exception("에러");
        }
        yield HofSuccess(artistList: artistList);
      } catch (error) {
        yield HofFailure(error: error.toString());
      }
    } else if (event is HofDailyLoad) {
      yield HofInProgress();

      try {
        String loginToken = await userRepository.getToken();
        List<Artist> artistList = await _hofRepository.getDailyHof(
          loginToken: loginToken,
          typeCode: event.typeCode,
          genderCode: event.genderCode,
          month: event.month,
        );
        if (artistList == null) {
          throw Exception("에러");
        }
        yield HofSuccess(artistList: artistList);
      } catch (error) {
        yield HofFailure(error: error.toString());
      }
    }
  }
}
