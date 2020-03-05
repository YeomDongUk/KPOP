import 'package:flutter/material.dart';
import 'package:kpop/Color.dart';
import 'package:kpop/Component/HamberNav.dart';
import 'package:kpop/Object/app_localizations.dart';

// AppLocalizations
class LanguageSetting extends StatelessWidget {
  final List<String> languages = [
    "System Default",
    "한국어",
    "English",
    "简体中文,",
    "繁体中文",
    "日本語",
    "Indonesia",
    ""
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      color: colors["Base"],
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "${AppLocalizations.of(context).translate("Language")} ${AppLocalizations.of(context).translate("Settings")}",
            ),
            centerTitle: false,
          ),
          body: Container(
            color: colors['Light'],
            child: ListView.builder(
              itemCount: languages.length,
              itemBuilder: (context, index) {
                return Menus(
                  title: languages[index],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
