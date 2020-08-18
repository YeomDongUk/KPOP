import 'package:flutter/material.dart';
import 'package:kpop/data/music_video.dart';
import 'package:kpop/static/color.dart';

class MusicVideoTile extends StatelessWidget {
  final MusicVideo musicVideo;
  const MusicVideoTile({
    Key key,
    @required this.musicVideo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 2 - 5;
    return Container(
      width: width,
      height: width * 10 / 9,
      color: Colors.black,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Image.network(
              musicVideo.thumbnail,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: 50,
            color: CustomColor.base,
            alignment: Alignment.center,
            child: Text(
              musicVideo.title,
              style: TextStyle(fontSize: 11),
            ),
          )
        ],
      ),
    );
  }
}
