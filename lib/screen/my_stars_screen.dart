import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kpop/bloc/mystars/stars_bloc.dart';
import 'package:kpop/bloc/mystars/starts_event.dart';
import 'package:kpop/bloc/mystars/starts_state.dart';
import 'package:kpop/repository/user_repository.dart';
import 'package:kpop/screen/star_charge_station_screen.dart';
import 'package:kpop/static/color.dart';
import 'package:kpop/static/localizations.dart';
import 'package:kpop/static/nav_key.dart';
import 'package:kpop/widget/back_arrow_button.dart';
import 'package:kpop/widget/history_list.dart';
import 'package:provider/provider.dart';

class MyStarsScreen extends StatefulWidget {
  @override
  _MyStarsScreenState createState() => _MyStarsScreenState();
}

class _MyStarsScreenState extends State<MyStarsScreen> {
  StarsBloc _starsBloc;

  @override
  void initState() {
    _starsBloc = StarsBloc(
        userRepository: RepositoryProvider.of<UserRepository>(context))
      ..add(StarsLoad());

    super.initState();
  }

  @override
  void dispose() {
    _starsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    RewardedVideoAdEvent rewardedVideoAdEvent =
        Provider.of<RewardedVideoAdEvent>(context);
    if (rewardedVideoAdEvent == RewardedVideoAdEvent.rewarded) {
      _starsBloc.add(StarsLoad());
    }
    return Scaffold(
      appBar: AppBar(
        leading: BackArrowButton(),
        title: Text(getLocalizations.myStars),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Container(
          color: CustomColor.light,
          child: BlocConsumer<StarsBloc, StarsState>(
            bloc: _starsBloc,
            listener: (context, state) {},
            builder: (context, state) {
              if (!(state is StarsSuccess))
                return Center(child: CircularProgressIndicator());
              StarsSuccess _state = state as StarsSuccess;
              int totalVoteStars = _state.starUsageHistory
                  .map((f) => f.starCount)
                  .toList()
                  .reduce((a, b) => a + b);
              return ListView(
                physics: ClampingScrollPhysics(),
                children: <Widget>[
                  _buildListTile(
                    title: "My Stars",
                    count: _state.star.myStarCount,
                  ),
                  _buildListTile(
                    title: "Ever Stars",
                    count: _state.star.everStarCount,
                  ),
                  _buildListTile(
                    title: "Daily Stars",
                    count: _state.star.dailyStarCount,
                  ),
                  _buildListTile(
                    title: "My Accumulated Votes",
                    count: totalVoteStars,
                    hasBorder: false,
                  ),
                  Divider(color: Colors.white.withOpacity(0.2), height: 1),
                  HistoryTile(
                    text: "Star Usage History",
                    starHistory: _state.starUsageHistory,
                  ),
                  Divider(color: Colors.white.withOpacity(0.2), height: 1),
                  HistoryTile(
                    text: "Star Accumulation History",
                    starHistory: _state.starEarnHistory,
                  ),
                  Divider(color: Colors.white.withOpacity(0.2), height: 1),
                ],
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 75,
          child: Row(
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    try {
                      if (rewardedVideoAdEvent == null ||
                          rewardedVideoAdEvent == RewardedVideoAdEvent.loaded) {
                        RewardedVideoAd.instance.show();
                      } else {
                        print("Loading...");
                      }
                    } catch (error) {
                      print(error);
                    }
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset("assets/icon/icon_new_normal.png",
                            scale: 2.5),
                        Text("See video ad"),
                        Text(
                          "Get 36 Stars",
                          style: TextStyle(
                            color: Color(0x77FFFFFF),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => NavKey.push(
                    page: StarChargeStationScreen(),
                    pageName: "/starChargeStationScreen",
                  ),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset("assets/icon/icon_star_home_normal.png",
                            scale: 2.5),
                        Text(
                          "Star Charging\nStation",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildListTile({
    String title,
    int count,
    Widget trailing,
    bool hasBorder = true,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: 20),
      child: Container(
        padding: EdgeInsets.only(top: 15, bottom: 15, right: 20),
        decoration: BoxDecoration(
          border: hasBorder
              ? Border(
                  bottom: BorderSide(color: Colors.white.withOpacity(0.1)),
                )
              : null,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(title),
                  Text(
                    "$count",
                    style: TextStyle(fontSize: 12, color: Colors.white38),
                  ),
                ],
              ),
            ),
            trailing ?? Container(),
          ],
        ),
      ),
    );
  }
}
