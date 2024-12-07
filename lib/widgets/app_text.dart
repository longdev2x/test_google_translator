import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_google_translator/cubit/localization_cubit.dart';
import 'package:test_google_translator/service/text_extension.dart';

//Thiết kế tương tự với RichText...
class AppGTText extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const AppGTText({
    super.key,
    required this.text,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, LocalizationState>(
      builder: (context, state) {
        return FutureBuilder<String>(
            future: tg(text),
            initialData: text,
            builder: (_, snapshot) {
              return Text(
                snapshot.data ?? text,
                style: style,
              );
            });
      },
    );
  }
}
