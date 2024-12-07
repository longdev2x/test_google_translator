import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:test_google_translator/service/app_localizations.dart';

extension TextExtension on Widget {
  AppLocalizations get _appLocalizations => GetIt.instance.get<AppLocalizations>();

  Future<String> tg(String text) async =>
      await _appLocalizations.translateFromGoogle(text);
}
