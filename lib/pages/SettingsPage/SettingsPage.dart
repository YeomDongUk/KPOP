import 'package:flutter/material.dart';
import 'package:kpop/Color.dart';
import 'package:kpop/Component/HamberNav.dart';
import 'package:kpop/Object/app_localizations.dart';
import 'package:kpop/pages/LoginPage/LoginPage.dart';
import 'package:kpop/pages/SettingsPage/LanguageSetting.dart';
import 'package:share/share.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: colors["Base"],
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              AppLocalizations.of(context).translate("Settings"),
            ),
            centerTitle: false,
          ),
          body: Container(
            color: colors["Light"],
            child: Column(
              children: <Widget>[
                Menus(
                  title:
                      "${AppLocalizations.of(context).translate("Language")} ${AppLocalizations.of(context).translate("Settings")}",
                  ontaped: () {
                    navigate(context, new LanguageSetting());
                  },
                ),
                Menus(
                  title: AppLocalizations.of(context).translate("MusicVideo"),
                ),
                Menus(
                  title: AppLocalizations.of(context).translate("ShareThisApp"),
                  ontaped: () {
                    Share.share(
                        'https://play.google.com/store/apps/details?id=com.hanbando.kpop');
                  },
                ),
                Container(
                  color: Color(0X33FFFFFF),
                  height: 0.2,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
