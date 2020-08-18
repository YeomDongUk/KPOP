import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kpop/bloc/favorite/favorite_bloc.dart';
import 'package:kpop/bloc/favorite/favorite_state.dart';
import 'package:kpop/data/artist.dart';
import 'package:kpop/screen/set_artist_screen.dart';
import 'package:kpop/static/color.dart';
import 'package:kpop/static/nav_key.dart';
import 'package:kpop/widget/angel_ranking.dart';
import 'package:kpop/widget/favorite_category.dart';
import 'package:kpop/widget/setting_box.dart';

class FavoriteList extends StatelessWidget {
  final double height;

  const FavoriteList({Key key, this.height}) : super(key: key);
  void goSetAngelScreen() {
    NavKey.push(
      page: SetArtistScreen(
        title: "Setting Favorites",
        isAngel: false,
      ),
      pageName: "/setArtistScreen",
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (context, state) {
        if (state is FavoriteSuccess) {
          List<Artist> boySolo = state.artistList
              .where((artist) =>
                  artist.typeCode == "I" && artist.genderCode == "M")
              .toList();
          List<Artist> girlSolo = state.artistList
              .where((artist) =>
                  artist.typeCode == "I" && artist.genderCode != "M")
              .toList();
          List<Artist> boyGroup = state.artistList
              .where((artist) =>
                  artist.typeCode == "G" && artist.genderCode == "M")
              .toList();

          List<Artist> girlGroup = state.artistList
              .where((artist) =>
                  artist.typeCode == "G" && artist.genderCode != "M")
              .toList();

          return ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              ..._buildRanking(boySolo, "I", "M"),
              ..._buildRanking(girlSolo, "I", "G"),
              ..._buildRanking(boyGroup, "G", "M"),
              ..._buildRanking(girlGroup, "G", "G")
            ],
          );
        }
        return SizedBox(
          height: height * 0.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Image.asset(
                    "assets/icon/icon_bookmark_230x240_normal.png",
                    scale: 2,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "I don't have my favorite idol yet!",
                      style: TextStyle(
                        color: CustomColor.subText,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Set up your idol favorite!",
                      style: TextStyle(
                        color: CustomColor.subText,
                        fontSize: 12,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ),
                  Container(height: 35),
                  SettingBox(
                    text: "Setting up an Favorites",
                    onTap: goSetAngelScreen,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildRanking(
      List<Artist> artist, String typeCode, String genderCode) {
    artist.sort((pre, next) => next.starCount.compareTo(pre.starCount));

    return [
      if (artist.isNotEmpty)
        FavoriteCategory(typeCode: typeCode, genderCode: genderCode),
      ...artist.map((artist) {
        return AngelRanking(
          artist: artist,
          voteBoxwidth: 100,
        );
      }).toList()
    ];
  }
}
