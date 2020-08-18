import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kpop/bloc/angel/angel_bloc.dart';
import 'package:kpop/bloc/angel/angel_event.dart';
import 'package:kpop/bloc/favorite/favorite_bloc.dart';
import 'package:kpop/bloc/favorite/favorite_event.dart';
import 'package:kpop/data/artist.dart';
import 'package:kpop/static/nav_key.dart';

class ArtistSearchList extends StatelessWidget {
  final List<Artist> artistList;
  final bool isAngel;

  const ArtistSearchList({
    Key key,
    this.artistList,
    this.isAngel,
  }) : super(key: key);
  BuildContext getContext() => NavKey.globalKey.currentState.context;

  void setAngel(Artist artist) {
    BuildContext context = getContext();
    BlocProvider.of<AngelBloc>(context).add(AngelSet(artist: artist));
  }

  void setFavorite(Artist artist) {
    BuildContext context = getContext();
    BlocProvider.of<FavoriteBloc>(context).add(FavoriteSet(artist: artist));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: artistList.length,
      itemBuilder: (context, int index) {
        Artist artist = artistList[index];
        return GestureDetector(
          onTap: isAngel ? () => setAngel(artist) : () => setFavorite(artist),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border(
                bottom:
                    BorderSide(color: Colors.white.withOpacity(0.5), width: 1),
              ),
            ),
            height: 70,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(artist.profileImage),
                    ),
                  ),
                  width: 50,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "${artist.name}",
                      ),
                      Text(
                        "${artist.voteCount}",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
