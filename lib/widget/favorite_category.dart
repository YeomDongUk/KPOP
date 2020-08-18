import 'package:flutter/material.dart';
import 'package:kpop/static/localizations.dart';

class FavoriteCategory extends StatelessWidget {
  final String typeCode;
  final String genderCode;
  const FavoriteCategory({
    Key key,
    this.typeCode,
    this.genderCode,
  }) : super(key: key);

  String convertCategory() {
    if (typeCode != "G") {
      if (genderCode == "M") {
        return "${getLocalizations.boy} ${getLocalizations.individual}";
      } else {
        return "${getLocalizations.girl} ${getLocalizations.individual}";
      }
    } else {
      if (genderCode == "M") {
        return "${getLocalizations.boys} ${getLocalizations.group}";
      } else {
        return "${getLocalizations.girls} ${getLocalizations.group}";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      alignment: Alignment.centerLeft,
      child: Text(convertCategory()),
    );
  }
}
