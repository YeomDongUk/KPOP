import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kpop/api/api.dart';
import 'package:kpop/bloc/mystars/starts_event.dart';
import 'package:kpop/bloc/mystars/starts_state.dart';
import 'package:kpop/data/my_star_detail.dart';
import 'package:kpop/repository/user_repository.dart';

class StarsBloc extends Bloc<StarsEvent, StarsState> {
  final UserRepository userRepository;

  StarsBloc({@required this.userRepository}) : assert(userRepository != null);
  @override
  StarsInitial get initialState => StarsInitial();

  @override
  Stream<StarsState> mapEventToState(
    StarsEvent event,
  ) async* {
    String loginToken = await userRepository.getToken();

    if (event is StarsLoad) {
      try {
        MyStarDetail myStarDetail = await Api.getMyStarDetail(
          loginToken: loginToken,
        );
        yield StarsSuccess(
          star: myStarDetail.star,
          starEarnHistory: myStarDetail.starEarnHistory,
          starUsageHistory: myStarDetail.starUsageHistory,
        );
      } catch (error) {
        yield StarsFailure(error: error.toString());
      }
    }
  }
}
