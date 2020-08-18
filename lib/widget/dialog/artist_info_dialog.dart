import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kpop/bloc/angel/angel_bloc.dart';
import 'package:kpop/bloc/angel/angel_event.dart';
import 'package:kpop/bloc/angel/angel_state.dart';
import 'package:kpop/bloc/favorite/favorite_bloc.dart';
import 'package:kpop/bloc/favorite/favorite_event.dart';
import 'package:kpop/bloc/favorite/favorite_state.dart';
import 'package:kpop/data/artist.dart';
import 'package:kpop/static/color.dart';

class ArtistInfoDialog extends StatefulWidget {
  final Artist artist;

  const ArtistInfoDialog({Key key, this.artist}) : super(key: key);
  @override
  _ArtistInfoDialogState createState() => _ArtistInfoDialogState();
}

class _ArtistInfoDialogState extends State<ArtistInfoDialog> {
  Artist _artist;

  @override
  void initState() {
    _artist = widget.artist;
    super.initState();
  }

  bool isAngel(AngelState state) {
    if (state is AngelSuccess) {
      if (state.artist == _artist) {
        return true;
      }
      return false;
    } else {
      return false;
    }
  }

  bool isFavorite(FavoriteState state) {
    if (state is FavoriteSuccess) {
      if (state.artistList.contains(_artist)) {
        return true;
      }
      return false;
    } else {
      return false;
    }
  }

  void setAngel() =>
      BlocProvider.of<AngelBloc>(context).add(AngelSet(artist: _artist));
  void removeAngel() => BlocProvider.of<AngelBloc>(context).add(AngelRemove());

  void setFavorite() =>
      BlocProvider.of<FavoriteBloc>(context).add(FavoriteSet(artist: _artist));
  void removeFavorite() => BlocProvider.of<FavoriteBloc>(context)
      .add(FavoriteRemove(artist: _artist));
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      backgroundColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 50,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                BlocBuilder<AngelBloc, AngelState>(
                  builder: (context, state) {
                    return GestureDetector(
                      onTap: isAngel(state)
                          ? () => removeAngel()
                          : () => setAngel(),
                      child: Image.asset(
                        "assets/icon/icon_angel_230x240_normal.png",
                        color: isAngel(state) ? CustomColor.main : Colors.black,
                        scale: 4,
                      ),
                    );
                  },
                ),
                BlocBuilder<FavoriteBloc, FavoriteState>(
                  builder: (context, state) {
                    return GestureDetector(
                      onTap: isFavorite(state)
                          ? () => removeFavorite()
                          : () => setFavorite(),
                      child: Image.asset(
                        "assets/icon/icon_cupid_normal.png",
                        color:
                            isFavorite(state) ? CustomColor.main : Colors.black,
                        scale: 2.5,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          ClipOval(
            child: SizedBox(
              width: 100,
              height: 100,
              child: Image.network(
                _artist.profileImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(left: 5, right: 5),
                child: Text(
                  _artist.name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              if (_artist.group != null)
                Text(
                  _artist.group["name"],
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
