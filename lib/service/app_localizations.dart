import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_mlkit_language_id/google_mlkit_language_id.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:test_google_translator/models/language_model.dart';

class AppLocalizations {
  //{languageCode, {source, resultTranslate}}
  final Map<String, Map<String, String>> _cache = {};
  Locale locale;

  AppLocalizations(this.locale);

  FutureOr<String> translateFromGoogle(String text) async {
    String? result;
    final startTime = DateTime.now(); 
    try {
      //không có thì vào catch
      LanguageModel targetLanguageModel = AppConstants.languages.firstWhere((e) => e.languageCode == locale.languageCode);
      //Check trong cache
      result = _getFromCache(targetLanguageModel.languageCode, text);
      if(result != null) {
        final time = DateTime.now().difference(startTime).inMilliseconds;
        print('zzz - Tr haved cache ${targetLanguageModel.languageName} - result: $result - Time: $time ms');
        return result;
      }

      final languageIdentifier = LanguageIdentifier(confidenceThreshold: 0.5);
      final sourceLanguageCode = await languageIdentifier.identifyLanguage(text); // trả về language code (vi)
      languageIdentifier.close();
      //không có thì vào catch
      LanguageModel sourceLanguageModel = AppConstants.languages.firstWhere((e) => e.languageCode == sourceLanguageCode);

      if(sourceLanguageModel.languageCode == targetLanguageModel.languageCode) return text;

      final translator = OnDeviceTranslator(
        sourceLanguage: sourceLanguageModel.translateLanguage,
        targetLanguage: targetLanguageModel.translateLanguage,
      );

      result = await  translator.translateText(text);
      final time = DateTime.now().difference(startTime).inMilliseconds;
      print('zzz - Tr to ${targetLanguageModel.languageName} - result: $result - Time: $time ms');

      _saveToCache(targetLanguageModel.languageCode, text, result);
      return result;
    } catch (e) {
      print("zzz Translate Error of: $text - $e");
      return text;
    }
  }

  void changeLocale(Locale locale) {
    locale = locale;
  }

  // Có thể thay bằng sql lite, hoặc cơ chế xoá bớt 1 key langugageCode khi thêm keyLanguageCode mới
  void _saveToCache(String languageCode, String text, String result) {
    if(_cache[languageCode] == null) {
      _cache[languageCode] = {text: result};
    }
    _cache[languageCode]![text] = result;
  }

  String? _getFromCache(String languageCode, String text) {
    return _cache[languageCode]?[text];
  }
}
