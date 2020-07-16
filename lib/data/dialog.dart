import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kpop/bloc/auth/auth_bloc.dart';
import 'package:kpop/bloc/auth/auth_event.dart';
import 'package:kpop/data/star.dart';
import 'package:kpop/repository/user_repository.dart';
import 'package:kpop/static/nav_key.dart';
import 'package:kpop/widget/dialog/vote_dialog.dart';

Future openVoteDialog({
  GlobalKey<ScaffoldState> key,
  UserRepository userRepository,
  int singerUid,
}) async {
  openCircleIndicator();
  Star star = await userRepository.getMyStar();
  NavKey.pop();
  if (star == null) {
    openToastMessage(text: "로그인 토큰 만료");
    return BlocProvider.of<AuthBloc>(NavKey.globalKey.currentState.context)
        .add(AuthLoggedOut());
  }
  return showDialog(
    context: NavKey.globalKey.currentState.overlay.context,
    builder: (context) => VoteDialog(
      star: star,
      singerUid: singerUid,
    ),
  );
}

Future<void> openCircleIndicator() {
  return showDialog(
    context: NavKey.globalKey.currentState.overlay.context,
    barrierDismissible: false,
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );
}

void openToastMessage({String text}) {
  showDialog(
    context: NavKey.globalKey.currentState.overlay.context,
    child: Dialog(
      backgroundColor: Colors.black.withOpacity(0),
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
        textAlign: TextAlign.center,
      ),
    ),
  );
}
