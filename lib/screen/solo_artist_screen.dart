import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kpop/bloc/Ranking/ranking_state.dart';
import 'package:kpop/bloc/ranking/ranking_bloc.dart';
import 'package:kpop/bloc/ranking/ranking_event.dart';
import 'package:kpop/widget/artist_list.dart';
import 'package:provider/provider.dart';

class SoloArtistScreen extends StatefulWidget {
  @override
  _SoloArtistScreenState createState() => _SoloArtistScreenState();
}

class _SoloArtistScreenState extends State<SoloArtistScreen>
    with AutomaticKeepAliveClientMixin<SoloArtistScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    BlocProvider.of<RankingBloc>(context).add(
      RankingLoad(
        genderCode: Provider.of<String>(context, listen: false),
        typeCode: "I",
      ),
    );
    print(Provider.of<String>(context));
    return BlocBuilder<RankingBloc, RankingState>(
      builder: (context, state) {
        if (state is RankingSuccess) {
          return Container(
            child: ArtistList(artistList: state.artistList),
          );
        }
        return Container();
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
