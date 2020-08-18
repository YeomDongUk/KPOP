import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kpop/bloc/Ranking/ranking_state.dart';
import 'package:kpop/bloc/ranking/ranking_bloc.dart';
import 'package:kpop/bloc/ranking/ranking_event.dart';
import 'package:kpop/widget/artist_list.dart';
import 'package:provider/provider.dart';

class GroupArtistScreen extends StatefulWidget {
  @override
  _GroupArtistScreenState createState() => _GroupArtistScreenState();
}

class _GroupArtistScreenState extends State<GroupArtistScreen>
    with AutomaticKeepAliveClientMixin<GroupArtistScreen> {
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
        typeCode: "G",
      ),
    );
    return BlocBuilder<RankingBloc, RankingState>(
      builder: (context, state) {
        if (state is RankingSuccess)
          return ArtistList(artistList: state.artistList);
        else
          return Container();
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
