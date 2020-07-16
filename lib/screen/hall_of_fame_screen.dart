import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kpop/bloc/hof/hof_bloc.dart';
import 'package:kpop/repository/user_repository.dart';
import 'package:kpop/widget/bot_nav_bar.dart';

import 'halloffame/hof_daily_screen.dart';
import 'halloffame/hof_monthly_screen.dart';

class HallOfFameScreen extends StatefulWidget {
  @override
  _HallOfFameScreenState createState() => _HallOfFameScreenState();
}

class _HallOfFameScreenState extends State<HallOfFameScreen>
    with AutomaticKeepAliveClientMixin {
  PageController _pageController;
  @override
  void initState() {
    _pageController = PageController(initialPage: 0, keepPage: true);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: <Widget>[
        Expanded(
          child: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: <Widget>[
              BlocProvider<HofBloc>(
                create: (_) => HofBloc(
                  userRepository:
                      RepositoryProvider.of<UserRepository>(context),
                ),
                child: HofMonthlyScreen(typeCode: "I"),
              ),
              BlocProvider<HofBloc>(
                create: (_) => HofBloc(
                  userRepository:
                      RepositoryProvider.of<UserRepository>(context),
                ),
                child: HofMonthlyScreen(typeCode: "G"),
              ),
              BlocProvider<HofBloc>(
                create: (_) => HofBloc(
                  userRepository:
                      RepositoryProvider.of<UserRepository>(context),
                ),
                child: HofDailyScreen(typeCode: "I"),
              ),
              BlocProvider<HofBloc>(
                create: (_) => HofBloc(
                  userRepository:
                      RepositoryProvider.of<UserRepository>(context),
                ),
                child: HofDailyScreen(typeCode: "G"),
              ),
            ],
          ),
        ),
        BotNavBar(pageController: _pageController),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
