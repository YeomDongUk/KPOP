import 'package:flutter/material.dart';
import 'package:kpop/data/artist.dart';
import 'package:kpop/static/color.dart';
import 'package:kpop/widget/artist_ranking.dart';

class ArtistList extends StatelessWidget {
  final List<Artist> artistList;
  final Widget leading;
  final bool isDaily;

  const ArtistList({
    Key key,
    this.artistList,
    this.leading,
    this.isDaily = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        if (leading != null) leading,
        SizedBox(
          height: height * 0.33,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Image.network(
                artistList[0].bannerImage,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ArtistRanking(
                  ranking: isDaily ? 1 : null,
                  artist: artistList[0],
                  color: CustomColor.rankingColor[0],
                ),
              ),
            ],
          ),
        ),
        ...List.generate(artistList.length - 1, (int index) {
          return ArtistRanking(
            ranking: isDaily ? 1 : null,
            artist: artistList[index + 1],
            color: index < 3
                ? CustomColor.rankingColor[index]
                : CustomColor.rankingColor[3],
          );
        }),
      ],
    );
  }
}
