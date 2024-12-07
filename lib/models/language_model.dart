import 'package:google_mlkit_translation/google_mlkit_translation.dart';

class LanguageModel {
  //Có thể thêm trường icon, ...
  final String languageCode;
  final String languageName;
  final TranslateLanguage translateLanguage;

  LanguageModel(this.languageCode, this.languageName, this.translateLanguage);
}

class AppConstants {
  static List<LanguageModel> languages = [
    LanguageModel('vi', 'Vietnamese', TranslateLanguage.vietnamese),
    LanguageModel('en', 'English', TranslateLanguage.english),
    LanguageModel('af', 'Afrikaans', TranslateLanguage.afrikaans),
    LanguageModel('sq', 'Albanian', TranslateLanguage.albanian),
    LanguageModel('ar', 'Arabic', TranslateLanguage.arabic),
    LanguageModel('be', 'Belarusian', TranslateLanguage.belarusian),
    LanguageModel('bn', 'Bengali', TranslateLanguage.bengali),
    LanguageModel('bg', 'Bulgarian', TranslateLanguage.bulgarian),
    LanguageModel('ca', 'Catalan', TranslateLanguage.catalan),
    LanguageModel('zh', 'Chinese', TranslateLanguage.chinese),
    LanguageModel('hr', 'Croatian', TranslateLanguage.croatian),
    LanguageModel('cs', 'Czech', TranslateLanguage.czech),
    LanguageModel('da', 'Danish', TranslateLanguage.danish),
    LanguageModel('nl', 'Dutch', TranslateLanguage.dutch),
    LanguageModel('eo', 'Esperanto', TranslateLanguage.esperanto),
    LanguageModel('et', 'Estonian', TranslateLanguage.estonian),
    LanguageModel('fi', 'Finnish', TranslateLanguage.finnish),
    LanguageModel('fr', 'French', TranslateLanguage.french),
    LanguageModel('gl', 'Galician', TranslateLanguage.galician),
    LanguageModel('ka', 'Georgian', TranslateLanguage.georgian),
    LanguageModel('de', 'German', TranslateLanguage.german),
    LanguageModel('el', 'Greek', TranslateLanguage.greek),
    LanguageModel('gu', 'Gujarati', TranslateLanguage.gujarati),
    LanguageModel('ht', 'Haitian', TranslateLanguage.haitian),
    LanguageModel('he', 'Hebrew', TranslateLanguage.hebrew),
    LanguageModel('hi', 'Hindi', TranslateLanguage.hindi),
    LanguageModel('hu', 'Hungarian', TranslateLanguage.hungarian),
    LanguageModel('is', 'Icelandic', TranslateLanguage.icelandic),
    LanguageModel('id', 'Indonesian', TranslateLanguage.indonesian),
    LanguageModel('ga', 'Irish', TranslateLanguage.irish),
    LanguageModel('it', 'Italian', TranslateLanguage.italian),
    LanguageModel('ja', 'Japanese', TranslateLanguage.japanese),
    LanguageModel('kn', 'Kannada', TranslateLanguage.kannada),
    LanguageModel('ko', 'Korean', TranslateLanguage.korean),
    LanguageModel('lv', 'Latvian', TranslateLanguage.latvian),
    LanguageModel('lt', 'Lithuanian', TranslateLanguage.lithuanian),
    LanguageModel('mk', 'Macedonian', TranslateLanguage.macedonian),
    LanguageModel('ms', 'Malay', TranslateLanguage.malay),
    LanguageModel('mt', 'Maltese', TranslateLanguage.maltese),
    LanguageModel('mr', 'Marathi', TranslateLanguage.marathi),
    LanguageModel('no', 'Norwegian', TranslateLanguage.norwegian),
    LanguageModel('fa', 'Persian', TranslateLanguage.persian),
    LanguageModel('pl', 'Polish', TranslateLanguage.polish),
    LanguageModel('pt', 'Portuguese', TranslateLanguage.portuguese),
    LanguageModel('ro', 'Romanian', TranslateLanguage.romanian),
    LanguageModel('ru', 'Russian', TranslateLanguage.russian),
    LanguageModel('sk', 'Slovak', TranslateLanguage.slovak),
    LanguageModel('sl', 'Slovenian', TranslateLanguage.slovenian),
    LanguageModel('es', 'Spanish', TranslateLanguage.spanish),
    LanguageModel('sw', 'Swahili', TranslateLanguage.swahili),
    LanguageModel('sv', 'Swedish', TranslateLanguage.swedish),
    LanguageModel('tl', 'Tagalog', TranslateLanguage.tagalog),
    LanguageModel('ta', 'Tamil', TranslateLanguage.tamil),
    LanguageModel('te', 'Telugu', TranslateLanguage.telugu),
    LanguageModel('th', 'Thai', TranslateLanguage.thai),
    LanguageModel('tr', 'Turkish', TranslateLanguage.turkish),
    LanguageModel('uk', 'Ukrainian', TranslateLanguage.ukrainian),
    LanguageModel('ur', 'Urdu', TranslateLanguage.urdu),
    LanguageModel('cy', 'Welsh', TranslateLanguage.welsh),
  ];
}
