import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kpop/bloc/angel/angel_bloc.dart';
import 'package:kpop/bloc/angel/angel_event.dart';
import 'package:kpop/bloc/favorite/favorite_bloc.dart';
import 'package:kpop/bloc/favorite/favorite_event.dart';
import 'package:kpop/bloc/ranking/ranking_bloc.dart';
import 'package:kpop/data/user.dart';
import 'package:kpop/repository/user_repository.dart';
import 'package:kpop/screen/angel_of_honor_screen.dart';
import 'package:kpop/screen/group_artist_screen.dart';
import 'package:kpop/screen/hall_of_fame_screen.dart';
import 'package:kpop/screen/my_stars_screen.dart';
import 'package:kpop/screen/solo_artist_screen.dart';
import 'package:kpop/static/color.dart';
import 'package:kpop/static/localizations.dart';
import 'package:kpop/static/nav_key.dart';
import 'package:kpop/widget/action_menu.dart';
import 'package:kpop/widget/nav_bar.dart';
import 'package:kpop/widget/side_menu.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final User userInfo;

  const HomeScreen({Key key, this.userInfo}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  int selectedSex = 0;

  @override
  initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this);
    BlocProvider.of<AngelBloc>(context).add(AngelLoad());
    BlocProvider.of<FavoriteBloc>(context).add(FavoriteLoad());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void changeSex(int index) {
    if (selectedSex != index) setState(() => selectedSex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(user: widget.userInfo),
      appBar: AppBar(
        centerTitle: false,
        title: TitleText(
          tabController: _controller,
        ),
        leading: NavBar(),
        actions: <Widget>[
          ActionMenu(
            imgsrc: "assets/icon/icon_male_normal.png",
            color: selectedSex == 0 ? Colors.blueAccent : null,
            onTap: () => changeSex(0),
          ),
          ActionMenu(
            imgsrc: "assets/icon/icon_female_normal.png",
            color: selectedSex == 1 ? Colors.red : null,
            onTap: () => changeSex(1),
          ),
          ActionMenu(
            imgsrc: "assets/icon/icon_mystar_normal.png",
            color: Colors.white,
            onTap: () =>
                NavKey.push(page: MyStarsScreen(), pageName: "/myStarsScreen"),
          )
        ],
        bottom: TabBar(
          controller: _controller,
          labelColor: CustomColor.main,
          unselectedLabelColor: Colors.white,
          indicatorColor: CustomColor.main,
          indicatorWeight: 3,
          tabs: <Widget>[
            _buildTab("assets/icon/icon_solo_normal.png"),
            _buildTab("assets/icon/icon_group_normal.png"),
            _buildTab("assets/icon/icon_trophy_normal.png"),
            _buildTab("assets/icon/icon_angel_normal.png"),
          ],
        ),
      ),
      body: SafeArea(
        child: MultiProvider(
          providers: [
            Provider<String>.value(value: selectedSex == 0 ? "M" : "F"),
          ],
          child: TabBarView(
            controller: _controller,
            children: <Widget>[
              BlocProvider<RankingBloc>(
                create: (_) => RankingBloc(
                    userRepository:
                        RepositoryProvider.of<UserRepository>(context)),
                child: SoloArtistScreen(),
              ),
              BlocProvider<RankingBloc>(
                create: (_) => RankingBloc(
                    userRepository:
                        RepositoryProvider.of<UserRepository>(context)),
                child: GroupArtistScreen(),
              ),
              HallOfFameScreen(),
              AngelOfHonorScreen(),
            ],
          ),
        ),
      ),
    );
  }

  Tab _buildTab(String imgSrc) {
    return Tab(
      icon: ImageIcon(
        AssetImage(imgSrc),
        size: 50,
      ),
    );
  }
}

class TitleText extends StatefulWidget {
  final TabController tabController;
  const TitleText({
    Key key,
    this.tabController,
  }) : super(key: key);

  @override
  _TitleTextState createState() => _TitleTextState();
}

class _TitleTextState extends State<TitleText> {
  String title = "";
  List<String> titles;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        title = getLocalizations.solo;
      });
      titles = [
        getLocalizations.solo,
        getLocalizations.group,
        getLocalizations.hallofFame,
        getLocalizations.angelofHonor,
      ];
      widget.tabController.addListener(listener);
    });

    super.initState();
  }

  void listener() {
    if (widget.tabController.indexIsChanging && mounted)
      setState(() => this.title = titles[widget.tabController.index]);
  }

  @override
  Widget build(BuildContext context) {
    return Text(title);
  }
}
