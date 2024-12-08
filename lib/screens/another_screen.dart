import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:test_google_translator/widgets/app_text.dart';

class AnotherScreen extends StatefulWidget {
  const AnotherScreen({super.key});

  @override
  State<AnotherScreen> createState() => _AnotherScreenState();
}

class _AnotherScreenState extends State<AnotherScreen> {
  bool isExpanded = false;
  int maxLines = 6;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppGTText(text: 'Màn hình html'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // AppGTText(text: 'Đây là đoạn văn chỉ gồm ngôn ngữ là tiếng Việt Nam, viết dài chút để test cho chính xác hay không', style: _style(),),
            // const SizedBox(height: 20),
            // AppGTText(text: 'Câu này about English Language để xem sao 한국어 추가', style: _style()),
            // const SizedBox(height: 20),
            AnimatedCrossFade(
              firstChild: AppHTMLGTText(
                data: fakeHtml,
                style: {
                  "*": Style(
                    maxLines: maxLines,
                    fontSize: FontSize(14),
                    margin: Margins.all(0),
                    padding: HtmlPaddings.zero,
                    // Show only a limited number of lines
                  ),
                  "img": Style(
                    width: Width(MediaQuery.of(context).size.width),
                    height: Height(MediaQuery.of(context).size.width),
                  ),
                },
              ),
              secondChild: AppHTMLGTText(
                data: fakeHtml,
                style: {
                  "*": Style(
                    fontSize: FontSize(14),
                    padding: HtmlPaddings.zero,
                    margin: Margins.all(0),
                  ),
                  "img": Style(
                    width: Width(MediaQuery.of(context).size.width),
                    height: Height(MediaQuery.of(context).size.width),
                  ),
                },
              ),
              crossFadeState: isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 200),
            ),

            GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: AppGTText(text: isExpanded ? 'Thu gọn' : 'Mở rộng'),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle _style({double? fontSize, FontWeight? fontWeight}) => TextStyle(
        fontSize: fontSize ?? 20,
        fontWeight: fontWeight ?? FontWeight.bold,
      );
}
