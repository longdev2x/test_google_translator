import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_google_translator/service/app_localizations.dart';
import 'package:test_google_translator/main.dart';

part 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  LocalizationCubit(AppLocalizations appLocalizations)
      : super(
          LocalizationState(locale: appLocalizations.locale),
        );

  void changeLanguage(Locale locale) {
    AppLocalizations appLocalizations = getIt<AppLocalizations>();
    if (appLocalizations.locale != locale) {
      getIt<AppLocalizations>().locale = locale;

      emit(state.copyWith(locale: locale));

      print('zzz - change to - ${locale.languageCode}');
      
      //Lưu vào sharePreferences ...
      //...
    }
  }
}
