import 'package:flutter/material.dart';
import 'package:kpop/data/artist.dart';
import 'package:kpop/static/color.dart';

import 'aritst_profile_image_box.dart';

class ArtistRanking extends StatelessWidget {
  final Color color;
  final Artist artist;
  final int ranking;
  const ArtistRanking({
    Key key,
    this.color,
    this.artist,
    this.ranking,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: EdgeInsets.all(10),
      color: color,
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            alignment: Alignment.center,
            child: Text(
              '${ranking ?? artist.rank}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          ArtistProfileImageBox(profileImage: artist.profileImage),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        artist.name,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      margin: EdgeInsets.only(right: 10),
                    ),
                    Text(
                      "${artist.group == null ? "" : artist.group['name']}",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${artist.starCount.toString()} points",
                  style: TextStyle(
                    color: CustomColor.subText,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            width: 28,
            height: 28,
            child: Image.asset(
              "assets/icon/icon_rightarrow_gray_thin_normal.png",
            ),
          ),
        ],
      ),
    );
  }
}
