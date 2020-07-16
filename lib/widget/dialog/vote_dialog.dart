import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kpop/api/api.dart';
import 'package:kpop/bloc/angel/angel_bloc.dart';
import 'package:kpop/bloc/angel/angel_event.dart';
import 'package:kpop/bloc/auth/auth_bloc.dart';
import 'package:kpop/bloc/auth/auth_event.dart';
import 'package:kpop/bloc/favorite/favorite_bloc.dart';
import 'package:kpop/bloc/favorite/favorite_event.dart';
import 'package:kpop/data/dialog.dart';
import 'package:kpop/data/star.dart';
import 'package:kpop/repository/user_repository.dart';
import 'package:kpop/static/color.dart';
import 'package:kpop/static/nav_key.dart';

class VoteDialog extends StatelessWidget {
  final Star star;
  final int singerUid;
  final TextStyle normalTextStyle =
      TextStyle(fontSize: 20, color: CustomColor.base);
  final TextStyle starTextStyle = TextStyle(
      color: CustomColor.base, fontSize: 13, fontWeight: FontWeight.w200);
  final TextEditingController teController = TextEditingController();

  VoteDialog({Key key, @required this.star, @required this.singerUid})
      : super(key: key);

  void voteToArtist() async {
    BuildContext context = NavKey.globalKey.currentState.context;
    try {
      bool result = await Api.voteToArtist(
        loginToken: RepositoryProvider.of<UserRepository>(
                NavKey.globalKey.currentState.context)
            .loginToken,
        singerUid: singerUid,
        starCount: int.parse(teController.text),
      );
      if (result) {
        BlocProvider.of<AngelBloc>(context).add(AngelLoad());
        BlocProvider.of<FavoriteBloc>(context).add(FavoriteLoad());
        NavKey.pop();
      } else if (!result) {
        openToastMessage(text: "스타 갯수 부족");
      } else {
        throw Exception("error");
      }
    } catch (error) {
      openToastMessage(text: "로그인 토큰 만료");
      BlocProvider.of<AuthBloc>(context).add(AuthLoggedOut());
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      contentPadding: EdgeInsets.all(10),
      content: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Text(
                "Star to stars",
                style: normalTextStyle,
              ),
            ),
            SizedBox(height: 10),
            Divider(color: Colors.black),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: CustomColor.base, width: 0.5),
                borderRadius: BorderRadius.circular(3),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _buildStarRow("My Star", star.myStarCount),
                  Divider(color: Colors.black, height: 0),
                  _buildStarRow("Ever Star", star.everStarCount),
                  Divider(color: Colors.black, height: 0),
                  _buildStarRow("Daily Star", star.dailyStarCount),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: CustomColor.base, width: 0.5),
                borderRadius: BorderRadius.circular(3),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _buildStarSelector("1", "10"),
                  Divider(color: Colors.black, height: 0),
                  _buildStarSelector("50", "100"),
                  Divider(color: Colors.black, height: 0),
                  _buildStarSelector("ALL", "Daily ALL"),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: CustomColor.base, width: 0.5),
                borderRadius: BorderRadius.circular(3),
              ),
              alignment: Alignment.center,
              child: TextField(
                controller: teController,
                style: normalTextStyle,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                _buildButton("Confirm"),
                Spacer(flex: 1),
                _buildButton("Cancel"),
              ],
            )
          ],
        ),
      ),
    );
  }

  Expanded _buildButton(String str) {
    return Expanded(
      flex: 5,
      child: GestureDetector(
        onTap: str == "Cancel"
            ? () => NavKey.globalKey.currentState.pop()
            : voteToArtist,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: CustomColor.base,
            borderRadius: BorderRadius.circular(3),
          ),
          child: Text(
            str,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }

  Padding _buildStarRow(String text, int count) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            text,
            style: normalTextStyle,
          ),
          Text(
            "$count",
            style: normalTextStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildStarSelector(String count, String count2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(child: _buildSartCount(count)),
        Container(
          height: 44,
          width: 1,
          color: Colors.black.withOpacity(0.5),
        ),
        Expanded(child: _buildSartCount(count2)),
      ],
    );
  }

  Widget _buildSartCount(String count) {
    return GestureDetector(
      onTap: () => setStarCount(count),
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Image.asset(
              "assets/icon/icon_star_60x60_normal.png",
              scale: 3,
              color: CustomColor.main,
            ),
            Text(
              "x $count",
              style: starTextStyle,
            ),
          ],
        ),
      ),
    );
  }

  void setStarCount(String count) {
    if (count == "ALL") {
      teController.text = "${star.myStarCount}";
    } else if (count == "Daily ALL") {
      teController.text = "${star.dailyStarCount}";
    } else {
      teController.text = count;
    }
  }

  void confirm() {
    // if(_star.)
  }
}
