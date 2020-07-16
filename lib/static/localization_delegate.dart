import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'localization.dart';

class LocalizationDelegate extends LocalizationsDelegate<Localization> {
  @override
  bool isSupported(Locale locale) => ['en', 'ko'].contains(locale.languageCode);

  @override
  Future<Localization> load(Locale locale) {
    return SynchronousFuture<Localization>(Localization(locale));
  }

  @override
  bool shouldReload(LocalizationDelegate old) => true;
}
