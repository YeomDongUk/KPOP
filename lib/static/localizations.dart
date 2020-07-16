import 'package:flutter/material.dart';
import 'package:kpop/static/localization.dart';
import 'package:kpop/static/nav_key.dart';

Localization get getLocalizations => Localizations.of<Localization>(
    NavKey.globalKey.currentState.context, Localization);
