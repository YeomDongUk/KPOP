import 'package:flutter/material.dart';

class ArtistProfileImageBox extends StatelessWidget {
  final String profileImage;
  const ArtistProfileImageBox({
    Key key,
    @required this.profileImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 20),
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        image: new DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(profileImage),
        ),
      ),
    );
  }
}
