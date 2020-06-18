import 'dart:io';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:kpop/Component/Body.dart';
import 'package:kpop/Color.dart';
import 'package:kpop/Component/HamberNav.dart';
import 'package:kpop/Object/User.dart' as UserProfile;
import 'package:kpop/Object/app_localizations.dart';
import 'package:kpop/pages/LoginPage/LoginPage.dart';
import 'package:kpop/pages/MystarsPage.dart';

class MainPage extends StatefulWidget {
  final user;
  MainPage({this.user});

  @override
  _MainPage createState() => _MainPage();
}

/* !!!!!!!!!!!!!!!!!!!!!!!!!! 메인 페이지 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!! */
class _MainPage extends State<MainPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin<MainPage> {
  static MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['flutterio', 'beautiful apps'],
    contentUrl: 'https://flutter.io',
    // birthday: DateTime.now(),
    childDirected: false,
    // designedForFamilies: false,
    testDevices: <String>[], // Android emulators are considered test devices
  );

  List<String> titles;
  int selectedSex = 0;
  var title;
  TabController _tabController;

  void _handleTabSelection() {
    if (!_tabController.indexIsChanging)
      setState(() {
        this.title = titles[_tabController.index];
      });
  }

  void selectBoy() {
    if (selectedSex != 0)
      setState(() {
        selectedSex = 0;
      });
  }

  void selectGirl() {
    if (selectedSex != 1)
      setState(() {
        selectedSex = 1;
      });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
    UserProfile.userProfile = UserProfile.User.fromJson(widget.user);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      title = AppLocalizations.of(context).translate("Solo");
      titles = [
        AppLocalizations.of(context).translate("Solo"),
        AppLocalizations.of(context).translate("Group"),
        AppLocalizations.of(context).translate("HallofFame"),
        AppLocalizations.of(context).translate("AngelofHonor"),
      ];
      setState(() {
        _tabController.addListener(_handleTabSelection);
      });
    });

    FirebaseAdMob.instance
        .initialize(
      appId: Platform.isAndroid
          ? "ca-app-pub-6851381815350121~9667779953"
          : "ca-app-pub-6851381815350121~3465333689",
    )
        .then((onValue) {
      print("1");
    });

    RewardedVideoAd.instance
        .load(
          adUnitId: RewardedVideoAd.testAdUnitId,
          // Platform.isAndroid
          //     ? "ca-app-pub-6851381815350121/5625373412"
          //     : "ca-app-pub-6851381815350121/3368188810",
          targetingInfo: targetingInfo,
        )
        .catchError((e) => print("error:$e"));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(title ?? "Hi"),
        textTheme: TextTheme(
          title: TextStyle(
            color: colors["White"],
            fontSize: 20.0,
          ),
        ),
        backgroundColor: colors["Base"],
        centerTitle: false,
        elevation: 0.0,
        leading: new Builder(
          builder: (context) {
            return GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Container(
                // margin: EdgeInsets.only(top: 5, bottom: 5),
                // width: 10,
                // color: colors["Main"],
                child: Image.asset(
                  "images/icon_list_normal.png",
                  // width: 0,
                  scale: 2.5,
                ),
              ),
            );
          },
        ),
        actions: <Widget>[
          GesList(
            imgsrc: "images/icon_man_normal.png",
            color: selectedSex == 0 ? Colors.blueAccent : null,
            tapped: selectBoy,
          ),
          GesList(
            imgsrc: "images/icon_female_normal.png",
            color: selectedSex == 1 ? Colors.red : null,
            tapped: selectGirl,
          ),
          GesList(
            imgsrc: "images/icon_mystar_normal.png",
            tapped: () {
              navigate(context, MystarsPage());
            },
          ),
          Container(width: 10),
        ],
        bottom: TabBar(
          indicatorColor: colors["Main"],
          indicatorWeight: 3,
          unselectedLabelColor: colors["White"],
          labelColor: colors["Main"],
          labelStyle: TextStyle(fontSize: 12.5),
          labelPadding: EdgeInsets.all(0),
          tabs: [
            Tab(
              icon: ImageIcon(
                AssetImage("images/icon_solo_normal.png"),
                size: 50,
              ),
            ),
            Tab(
              icon: ImageIcon(
                AssetImage(
                  "images/icon_group_normal.png",
                ),
                size: 50,
              ),
            ),
            Tab(
              icon: ImageIcon(
                AssetImage(
                  "images/icon_trophy_normal.png",
                ),
                size: 50,
              ),
            ),
            Tab(
              icon: ImageIcon(
                AssetImage(
                  "images/icon_angel_normal.png",
                ),
                size: 50,
              ),
            ),
          ],
          controller: _tabController,
        ),
      ),
      drawer: HamberNav(),
      body: Body(
        pgc: _tabController,
        sex: selectedSex,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class GesList extends GestureDetector {
  GesList({Key key, this.imgsrc, this.tapped, this.color});
  final imgsrc;
  final tapped;
  final color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: Image.asset(
          imgsrc,
          color: color,
          width: 40,
        ),
      ),
      onTap: tapped,
    );
  }
}
