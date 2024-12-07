import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_google_translator/screens/another_screen.dart';
import 'package:test_google_translator/widgets/app_text.dart';
import 'package:test_google_translator/models/language_model.dart';
import 'package:test_google_translator/cubit/localization_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final LocalizationCubit _localizationCubit;

  @override
  void initState() {
    super.initState();
    _localizationCubit = context.read<LocalizationCubit>();
  }

  void _switchLanguage(Locale locale) {
    _localizationCubit.changeLanguage(locale);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppGTText(text: 'Xin chào'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Row(children: [],),
          AppGTText(text: 'Tuyệt vời', style: _style(),),
          const SizedBox(height: 20),
          AppGTText(text: 'Sức khoẻ', style: _style()),
          const SizedBox(height: 20),
          BlocBuilder<LocalizationCubit, LocalizationState>(
            builder: (context, state) => DropdownButton<String>(
              items: AppConstants.languages
                  .map((e) => DropdownMenuItem<String>(
                        value: e.languageCode,
                        child: Text(e.languageName),
                      ))
                  .toList(),
              value: state.locale.languageCode,
              onChanged: (value) {
                if (value != null) {
                  _switchLanguage(
                    Locale(value),
                  );
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: ElevatedButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AnotherScreen(),
              )),
          child: const Text('Another Screen')),
    );
  }

  TextStyle _style({double? fontSize, FontWeight? fontWeight}) => TextStyle(
    fontSize: fontSize?? 20,
    fontWeight: fontWeight ?? FontWeight.bold,
  );
}
