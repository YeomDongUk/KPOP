import 'package:flutter/material.dart';
import 'package:kpop/Color.dart';
import 'package:kpop/Object/Artist.dart';
import 'package:kpop/Object/Navigate.dart';
import 'package:kpop/pages/MusicPage/LatestPage.dart';

class ArtistPage extends StatelessWidget {
  ArtistPage({Key key}) : super(key: key);
  final ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: colors["Light"],
      padding: EdgeInsets.all(5),
      child: GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 5.0,
        crossAxisSpacing: 5.0,
        controller: _controller,
        physics: const ClampingScrollPhysics(),
        children: artist.map((result) {
          return GestureDetector(
            child: new Container(
              color: colors["Black"],
              margin: new EdgeInsets.all(1.0),
              child: Container(
                child: Stack(
                  children: <Widget>[
                    Image.asset(
                      result['image'],
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      bottom: -0.2,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 40,
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        color: Color(0xBB000000),
                        child: Text(
                          result['singer'].toUpperCase(),
                          maxLines: 1,
                          style:
                              TextStyle(color: colors["White"], fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            onTap: () {
              navigate(
                context,
                Container(
                  color: colors["Base"],
                  child: SafeArea(
                    child: Scaffold(
                      appBar:
                          AppBar(title: Text(result["singer"].toUpperCase())),
                      body: Container(
                        height: MediaQuery.of(context).size.height,
                        color: colors["Light"],
                        child: LatestPage(
                          query: result['singer'],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}

class ArtistListPage extends StatefulWidget {
  @override
  _ArtistListPageState createState() => _ArtistListPageState();
}

class _ArtistListPageState extends State<ArtistListPage> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
