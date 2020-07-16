import 'package:flutter/material.dart';
import 'package:kpop/static/color.dart';
import 'package:share/share.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Container(
          color: CustomColor.light,
          child: ListView.separated(
            itemCount: 3,
            physics: ClampingScrollPhysics(),
            separatorBuilder: (context, index) =>
                Divider(color: Color(0X33FFFFFF), thickness: 0.1),
            itemBuilder: (context, index) {
              if (index == 0)
                return _buildMenus("Language Settings", () => null);
              else if (index == 1)
                return _buildMenus("Music Video", () => null);
              else
                return _buildMenus(
                    "Share this app",
                    () => Share.share(
                        "https://play.google.com/store/apps/details?id=com.hanbando.kpop"));
            },
          ),
        ),
      ),
    );
  }

  Container _buildMenus(String title, Function() onTap) {
    return Container(
      child: ListTile(
        title: Text(title),
        onTap: onTap,
      ),
      decoration: BoxDecoration(
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
