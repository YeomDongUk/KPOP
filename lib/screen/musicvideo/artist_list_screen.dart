import 'package:flutter/material.dart';
import 'package:kpop/static/artist.dart';

class ArtistListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.all(5.0),
      child: GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 5.0,
        crossAxisSpacing: 5.0,
        physics: ClampingScrollPhysics(),
        children: artistList
            .map((map) => Container(
                  color: Colors.black,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Image.asset(map['image']),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          color: Color(0xBB000000),
                          alignment: Alignment.center,
                          child: Text(
                            map['singer'].toUpperCase(),
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }
}
