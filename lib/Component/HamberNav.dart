import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kpop/Object/app_localizations.dart';
import 'package:kpop/pages/BoardPage/NoticePage.dart';
import 'package:kpop/pages/BoardPage/EventPage.dart';
import 'package:kpop/pages/MusicVideo.dart';
import 'package:kpop/pages/MystarsPage.dart';
import 'package:kpop/Color.dart';
import 'package:kpop/Object/Navigate.dart';
import 'package:kpop/pages/SettingsPage/SettingsPage.dart';
import '../Object/registTypeCode.dart';
import '../Object/User.dart' as UserProfile;

class HamberNav extends StatelessWidget {
  HamberNav({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width * 0.824;
    return SizedBox(
      width: width,
      child: Drawer(
        child: Container(
          decoration: BoxDecoration(
            color: colors["Base"],
          ),
          child: SafeArea(
            bottom: true,
            child: Container(
              color: colors["DeepBase"],
              child: ListView(
                physics: ClampingScrollPhysics(),
                children: <Widget>[
                  AppBar(
                    backgroundColor: colors["Sub"],
                    title: Text(AppLocalizations.of(context).translate("Menu")),
                    centerTitle: false,
                    elevation: 1.0,
                    leading: Builder(
                      builder: (context) => new IconButton(
                        icon: Image.asset("images/icon_backarrow_normal.png"),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    child: Flex(
                      direction: Axis.horizontal,
                      // mainAxisAlignment: MainAxisAlignment.start,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: colors["White"], width: 2),
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: UserProfile.userProfile.registTypeCode !=
                                  "EMAIL"
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(40.0),
                                  child: FadeInImage.assetNetwork(
                                    fit: BoxFit.cover,
                                    width: 75,
                                    height: 75,
                                    placeholder: "images/progress.gif",
                                    image: UserProfile.userProfile.profileImage,
                                  ),
                                )
                              : Container(
                                  width: 75,
                                  height: 75,
                                  decoration: BoxDecoration(
                                    color: colors["Base"],
                                    shape: BoxShape.circle,
                                  ),
                                ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Flex(
                              direction: Axis.vertical,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    // Text(
                                    //   "Lv.${UserProfile.userProfile.level} ",
                                    //   style: TextStyle(
                                    //     color: colors["Main"],
                                    //     // fontSize: 15,
                                    //     fontWeight: FontWeight.w500,
                                    //   ),
                                    // ),
                                    Text(
                                      " ${UserProfile.userProfile.nickname}",
                                      style: TextStyle(
                                        color: colors["White"],
                                        // fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                // Container(height: 10),
                                // Container(
                                //   height: 10,
                                //   color: colors["Main"],
                                // ),
                                Container(height: 10),
                                Container(
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          "ID: ",
                                          style:
                                              TextStyle(color: colors["White"]),
                                        ),
                                        UserProfile.userProfile
                                                    .registTypeCode !=
                                                "EMAIL"
                                            ? Container(
                                                child: Image.asset(
                                                  registTypeCode[UserProfile
                                                      .userProfile
                                                      .registTypeCode],
                                                  scale: 8,
                                                ),
                                              )
                                            : Container(),
                                        Text(
                                          UserProfile.userProfile
                                                      .registTypeCode !=
                                                  "EMAIL"
                                              ? UserProfile
                                                  .userProfile.registTypeCode
                                                  .toLowerCase()
                                              : UserProfile.userProfile.id,
                                          style:
                                              TextStyle(color: colors["White"]),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(height: 5),
                                Container(
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Text(
                                      "Joined: ${UserProfile.userProfile.registDt}",
                                      style: TextStyle(color: colors["White"]),
                                    ),
                                  ),
                                ),
                                Container(height: 5),
                                Container(
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Text(
                                      "Accumulated Votes: ${UserProfile.userProfile.totalVote}",
                                      style: TextStyle(
                                        color: colors["White"],
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 100,
                          // color: colors["White"],
                          alignment: Alignment.topRight,
                          // child: Image.asset(
                          //   "images/icon_setting_normal.png",
                          //   scale: 3.5,
                          // ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      child: ListTile(
                        title: Text(
                          AppLocalizations.of(context).translate("Home"),
                          style: TextStyle(color: colors["White"]),
                        ),
                        onTap: () => Navigator.popUntil(
                          context,
                          ModalRoute.withName("/MainPage"),
                          // ModalRoute.of(context).
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFF10151A),
                      ),
                    ),
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  MyMenus(
                    title: AppLocalizations.of(context).translate("MyStars"),
                    onTap: () {
                      navigate(context, new MystarsPage());
                    },
                  ),
                  // MyMenus(
                  //   title:
                  //       AppLocalizations.of(context).translate("MyActivities"),
                  // ),
                  Menus(
                    title: AppLocalizations.of(context).translate("Notice"),
                    ontaped: () {
                      navigate(context, new NoticePage());
                    },
                  ),
                  Menus(
                    title: AppLocalizations.of(context).translate("Events"),
                    ontaped: () {
                      navigate(context, new EventPage());
                    },
                  ),
                  // Menus(
                  //   title: AppLocalizations.of(context).translate("Board"),
                  // ),
                  // Menus(
                  //   title: AppLocalizations.of(context).translate("IdolQuiz"),
                  // ),
                  // Menus(
                  //   title: AppLocalizations.of(context).translate("Stars"),
                  // ),
                  // Menus(
                  //   title: AppLocalizations.of(context).translate("ItemStore"),
                  // ),
                  Menus(
                    title: AppLocalizations.of(context).translate("MusicVideo"),
                    ontaped: () {
                      Navigator.of(context).pop();
                      String currentPage = ModalRoute.of(context).settings.name;
                      print(currentPage);
                      if (currentPage != "/MusicVideo")
                        navigate(context, new MusicVideo());
                    },
                  ),
                  Menus(
                    title: AppLocalizations.of(context).translate("Settings"),
                    ontaped: () {
                      navigate(context, new SettingsPage());
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Menus extends Container {
  final Function ontaped;
  final String title;
  final TextStyle menuStyle = new TextStyle(color: colors["White"]);
  Menus({Key key, this.title, this.ontaped});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        title: Text(title, style: menuStyle),
        onTap: ontaped,
      ),
      // color: Color(0xFF10151A),
      decoration: BoxDecoration(
        color: Color(0xFF10151A),
        border: Border(
          top: BorderSide(
            color: Color(0X33FFFFFF),
            width: 0.2,
          ),
        ),
      ),
    );
  }
}

class MyMenus extends Container {
  final Function onTap;
  final String title;
  MyMenus({Key key, this.title, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF111820),
        border: Border(
          bottom: BorderSide(
            color: Color(0X33FFFFFF),
            width: 0.5,
          ),
        ),
      ),
      // color: colors["Base"],
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            color: colors["Main"],
          ),
        ),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          color: colors["Main"],
          size: 35,
        ),
        onTap: onTap,
      ),
    );
  }
}
