import 'package:flutter/material.dart';
import 'package:test_google_translator/widgets/app_text.dart';

class AnotherScreen extends StatelessWidget {
  const AnotherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppGTText(text: 'Màn hình thứ 2'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppGTText(text: 'Đây là đoạn văn chỉ gồm ngôn ngữ là tiếng Việt Nam, viết dài chút để test cho chính xác hay không', style: _style(),),
          const SizedBox(height: 20),
          AppGTText(text: 'Câu này about English Language để xem sao 한국어 추가', style: _style()),
          const SizedBox(height: 20),
        ],
      ),
    );
  }


  TextStyle _style({double? fontSize, FontWeight? fontWeight}) => TextStyle(
    fontSize: fontSize?? 20,
    fontWeight: fontWeight ?? FontWeight.bold,
  );
}
