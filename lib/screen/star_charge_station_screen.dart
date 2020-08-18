import 'package:flutter/material.dart';
import 'package:kpop/data/product.dart';
import 'package:kpop/screen/star_charging_screen.dart';
import 'package:kpop/static/color.dart';
import 'package:kpop/static/localizations.dart';
import 'package:kpop/static/nav_key.dart';
import 'package:kpop/static/utils.dart';

class StarChargeStationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getLocalizations.starRefillStation),
      ),
      body: SafeArea(
        child: Container(
          color: CustomColor.light,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  physics: ClampingScrollPhysics(),
                  children: <Widget>[
                    SizedBox(height: 20),
                    Builder(
                      builder: (_) {
                        Product product = Product.fromJson({
                          'productId': "0000",
                          'productName': "EverStar1000+DailyStar300",
                          'price': 1000,
                          'everStarCount': 1000,
                          'dailyStarCount': 300,
                        });
                        return Container(
                          child: ListTile(
                            leading: Image.asset(
                              "assets/icon/icon_star_60x60_normal.png",
                              width: 44,
                              height: 44,
                              color: CustomColor.main,
                            ),
                            title: Text(
                              "${product.everStarCount}[+${product.dailyStarCount}]",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              "Ever stars[+Daily starts]",
                              style: TextStyle(fontSize: 13),
                            ),
                            trailing: GestureDetector(
                              // onTap: () => NavKey.push(
                              //   page: StarChargingScreen(product),
                              //   pageName: "/starChargingScreen",
                              // ),
                              child: Container(
                                width: 80,
                                height: 35,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(
                                    width: 2,
                                    color: Colors.white,
                                  ),
                                ),
                                child: Text(
                                  "₩ ${product.price.formatting()}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Container(
                child: Text(
                  "1) This payment method is provided by Eximbay and is billed as www.eximbay.com.",
                ),
              ),
              Container(
                child: Text(
                  "2) Note: Please note that the billing descriptor will be listed as EXIMBAY.COM.",
                ),
              ),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
