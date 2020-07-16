import 'package:flutter/material.dart';
import 'package:kpop/data/user.dart';
import 'package:kpop/screen/event_screen.dart';
import 'package:kpop/screen/musicvideo/music_video_screen.dart';
import 'package:kpop/screen/my_stars_screen.dart';
import 'package:kpop/screen/notice_screen.dart';
import 'package:kpop/screen/setting_screen.dart';
import 'package:kpop/static/color.dart';
import 'package:kpop/static/localizations.dart';
import 'package:kpop/static/nav_key.dart';

import 'back_arrow_button.dart';

class SideMenu extends StatelessWidget {
  final User user;

  SideMenu({Key key, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: CustomColor.base,
        child: SafeArea(
          bottom: true,
          child: Container(
            color: CustomColor.deepBase,
            child: ListView(
              physics: ClampingScrollPhysics(),
              children: <Widget>[
                AppBar(
                  backgroundColor: CustomColor.sub,
                  title: Text(getLocalizations.menu),
                  centerTitle: false,
                  elevation: 1.0,
                  leading: BackArrowButton(),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    children: <Widget>[
                      _buildProfileImage(),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text(user.nickname),
                            Text("ID:${user.id}"),
                            Text("Joined: ${user.registDt}"),
                            Text("Accumulated Votes:${user.totalVote}"),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => NavKey.popUntil(destination: "/"),
                  child: Container(
                    height: 48,
                    color: Colors.transparent,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    alignment: Alignment.centerLeft,
                    child: Text("Home"),
                  ),
                ),
                GestureDetector(
                  onTap: () => NavKey.push(
                      page: MyStarsScreen(), pageName: "/myStarsScreen"),
                  child: _buildPrimaryMenu("My Stars"),
                ),
                _buildNormalMenu("Notice", context),
                _buildNormalMenu("Events", context),
                _buildNormalMenu("Music Video", context),
                _buildNormalMenu("Settings", context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _buildProfileImage() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 2),
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: user.registTypeCode != "EMAIL"
          ? ClipRRect(
              borderRadius: BorderRadius.circular(40.0),
              child: FadeInImage.assetNetwork(
                fit: BoxFit.cover,
                width: 75,
                height: 75,
                placeholder: "images/progress.gif",
                image: user.profileImage,
              ),
            )
          : Container(
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                color: CustomColor.base,
                shape: BoxShape.circle,
              ),
            ),
    );
  }

  void goPage(String page, context) {
    switch (page) {
      case "Notice":
        NavKey.push(page: NoticeScreen(), pageName: "/noticeScreen");
        break;
      case "Events":
        NavKey.push(page: EventScreen(), pageName: "/eventScreen");
        break;
      case "Music Video":
        if (ModalRoute.of(context).settings.name == "/musicVideoScreen") {
          NavKey.pop();
        } else {
          NavKey.push(
            page: MusicVideoScreen(user: user),
            pageName: "/musicVideoScreen",
          );
        }

        break;
      case "Settings":
        NavKey.push(page: SettingScreen(), pageName: "/settingScreen");
        break;
      default:
    }
  }

  GestureDetector _buildNormalMenu(String menu, BuildContext context) {
    return GestureDetector(
      onTap: () => goPage(menu, context),
      child: Container(
        decoration: BoxDecoration(
          color: CustomColor.light,
          border: Border(
            top: BorderSide(
              color: Color(0x33FFFFFF),
              width: 0.2,
            ),
          ),
        ),
        child: ListTile(
          title: Text(menu),
        ),
      ),
    );
  }

  Container _buildPrimaryMenu(String menu) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF111820),
        border: Border(
          top: BorderSide(
            color: Color(0x33FFFFFF),
            width: 0.2,
          ),
        ),
      ),
      child: ListTile(
        title: Text(
          menu,
          style: TextStyle(color: CustomColor.main),
        ),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          color: CustomColor.main,
          size: 35,
        ),
      ),
    );
  }
}
