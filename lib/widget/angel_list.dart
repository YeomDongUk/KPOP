import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kpop/bloc/angel/angel_bloc.dart';
import 'package:kpop/bloc/angel/angel_state.dart';
import 'package:kpop/screen/set_artist_screen.dart';
import 'package:kpop/static/color.dart';
import 'package:kpop/static/nav_key.dart';
import 'package:kpop/widget/angel_ranking.dart';
import 'package:kpop/widget/setting_box.dart';

class AngelList extends StatelessWidget {
  final double height;

  const AngelList({Key key, this.height}) : super(key: key);
  void goSetAngelScreen() {
    NavKey.push(
      page: SetArtistScreen(
        title: "Setting Angel",
        isAngel: true,
      ),
      pageName: "/setArtistScreen",
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AngelBloc, AngelState>(
      builder: (context, state) {
        if (state is AngelSuccess) {
          return SizedBox(
            height: height * 0.33,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Image.network(
                  state.artist.bannerImage,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: AngelRanking(
                    artist: state.artist,
                    voteBoxwidth: 100,
                  ),
                ),
              ],
            ),
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
                    "assets/icon/icon_angel_230x240_normal.png",
                    scale: 2,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "There's no angel of honor yet!",
                      style: TextStyle(
                        color: CustomColor.subText,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Set up your own angel of honor right now!",
                      style: TextStyle(
                        color: CustomColor.subText,
                        fontSize: 12,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ),
                  Container(height: 35),
                  SettingBox(
                    text: "Setting up an Angel",
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
}
