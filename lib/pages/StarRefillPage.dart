import 'package:flutter/material.dart';
import 'package:kpop/Color.dart';
import 'package:kpop/Object/app_localizations.dart';

class StarRefillPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate("StarChargingStation")),
      ),
      body: Container(
        color: colors['Base'],
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            color: colors["Light"],
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                    physics: ClampingScrollPhysics(),
                    children: <Widget>[
                      SizedBox(height: 20),
                      Container(
                        child: ListTile(
                          leading: Image.asset(
                            "images/icon_star_60x60_normal.png",
                            width: 44,
                            height: 44,
                            color: colors['Main'],
                          ),
                          title: Text(
                            "1000[+300]",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "Ever stars[+Daily starts]",
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                          trailing: Container(
                            width: 70,
                            height: 35,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: Colors.white,
                              ),
                            ),
                            child: Text(
                              "1,000",
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  child: Text(
                    "1) This payment method is provided by Eximbay and is billed as www.eximbay.com.",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Container(
                  child: Text(
                    "2) Note: Please note that the billing descriptor will be listed as EXIMBAY.COM.",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
