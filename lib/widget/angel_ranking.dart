import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kpop/data/artist.dart';
import 'package:kpop/data/dialog.dart';
import 'package:kpop/repository/user_repository.dart';
import 'package:kpop/static/color.dart';
import 'package:kpop/static/nav_key.dart';
import 'package:kpop/widget/aritst_profile_image_box.dart';
import 'package:kpop/widget/dialog/artist_info_dialog.dart';

class AngelRanking extends StatelessWidget {
  final Artist artist;
  final double voteBoxwidth;

  const AngelRanking({
    Key key,
    @required this.artist,
    @required this.voteBoxwidth,
  })  : assert(artist != null),
        assert(voteBoxwidth != null),
        super(key: key);

  void openArtistInfoDialog() {
    showDialog(
      context: NavKey.globalKey.currentState.overlay.context,
      builder: (_) => ArtistInfoDialog(artist: artist),
    );
  }

  @override
  Widget build(BuildContext context) {
    UserRepository userRepository =
        RepositoryProvider.of<UserRepository>(context);
    return GestureDetector(
      onTap: openArtistInfoDialog,
      child: Container(
        height: 80,
        color: CustomColor.rankingColor[0],
        padding: EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ArtistProfileImageBox(
              profileImage: artist.profileImage,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: "${artist.rank}st  ",
                            style: TextStyle(color: Color(0xFF748192))),
                        TextSpan(text: "${artist.name} "),
                        TextSpan(
                          text:
                              artist.group != null ? artist.group['name'] : "",
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                  LayoutBuilder(
                    builder: (_, __) {
                      return Container(
                        height: 20,
                        width: __.maxWidth / 2 +
                            ((__.maxWidth / 2) * voteBoxwidth),
                        padding: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: CustomColor.main),
                          borderRadius: BorderRadius.circular(11),
                          color: CustomColor.voteBar,
                        ),
                        alignment: Alignment.centerRight,
                        child: Text(
                          '${artist.starCount}',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(width: 20),
            GestureDetector(
              onTap: () => openVoteDialog(
                userRepository: userRepository,
                singerUid: artist.uid,
              ),
              child: Container(
                color: Colors.transparent,
                child: Image.asset(
                  "assets/icon/icon_vote_select.png",
                  width: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
