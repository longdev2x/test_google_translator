import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:test_google_translator/service/app_localizations.dart';
import 'package:test_google_translator/screens/home_screen.dart';
import 'package:test_google_translator/models/language_model.dart';
import 'package:test_google_translator/cubit/localization_cubit.dart';

final getIt = GetIt.instance;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  getIt.registerSingleton<AppLocalizations>(
    AppLocalizations(
      Locale(AppConstants.languages[0].languageCode),
    ),
  );

  runApp(MultiBlocProvider(providers: [
    BlocProvider.value(value: LocalizationCubit(getIt<AppLocalizations>()))
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, LocalizationState>(
      builder: (context, state) => MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        // localizationsDelegates: [],
        // supportedLocales: [],
        // locale: state.locale,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
