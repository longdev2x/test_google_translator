import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:test_google_translator/cubit/localization_cubit.dart';
import 'package:test_google_translator/service/text_extension.dart';
import 'package:html/parser.dart' as htmlParser;
import 'package:html/dom.dart' as dom;
import 'package:test_google_translator/widgets/html_render.dart';

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

class AppHTMLGTText extends StatelessWidget {
  final String data;
  //Phần dưới để truyền cho HTML render
  final OnTap? onLinkTap;
  final OnTap? onAnchorTap;
  final OnCssParseError? onCssParseError;
  final ImageErrorListener? onImageError;
  final bool? shrinkWrap;
  final OnTap? onImageTap;
  final List<String>? tagsList;
  final Map<String, Style>? style;

  const AppHTMLGTText({
    super.key,
    required this.data,
    //Phần dưới để truyền cho HTML render
    this.onLinkTap,
    this.onAnchorTap,
    this.onCssParseError,
    this.onImageError,
    this.shrinkWrap = false,
    this.onImageTap,
    this.tagsList,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, LocalizationState>(
      builder: (context, state) {
        return FutureBuilder<String>(
            future: _translateHtml(data),
            initialData: data,
            builder: (_, snapshot) {
              return HtmlRender(
                data: snapshot.data,
                onAnchorTap: onAnchorTap,
                onCssParseError: onCssParseError,
                onImageError: onImageError,
                onImageTap: onImageTap,
                onLinkTap: onLinkTap,
                shrinkWrap: shrinkWrap,
                style: style,
                tagsList: tagsList,
              );
            });
      },
    );
  }

  //List thẻ không nên dịch
  static final _nonTranslatableTags = ['img', 'a', 'script', 'style', 'anchor'];

  Future<String> _translateHtml(String htmlContent) async {
    //convert htmlString thành document, sẽ làm việc với document
    final document = htmlParser.parse(htmlContent);
    print('eeeee1 - ${document.body?.text}');

    // Duyệt qua body của document -> List<Dom.Element>
    // Future.wait để chạy song song
    // map() sẽ biến đổi thành: [Future(a), Future(b), Future(c)]
    // Future.wait() sẽ đợi tất cả chúng hoàn thành
    await Future.wait(document.body?.children.map((element) => _forAndTranslate(element)) ?? []);


    //return lại htmlContent sau khi đã dịch
    print('eeeee5 - ${document.body?.innerHtml}');
    return document.body?.innerHtml ?? htmlContent;
  }

  /// Hàm đệ quy duyệt qua DOM
  Future<void> _forAndTranslate(dom.Element element) async {
    // Nếu gặp thẻ img, style.. dừng lại, không dịch
    if (_nonTranslatableTags.contains(element.localName)) {
      return;
    }

    //Nếu không duyệt qua tất cả các Node trong Element
    for (final node in element.nodes) {
      // Nếu là `TextNode` thì dịch
      if (node.nodeType == dom.Node.TEXT_NODE && node.text != null && node.text!.isNotEmpty) {
        node.text = await tg(node.text!); // Dịch nội dung và gán lại
      } else if (node is dom.Element) {
        // Nếu là Element, gọi đệ quy
        await _forAndTranslate(node);
      }
    }
  }
}

const String fakeHtml =
    "<h2 style=\"text-align: justify\">Áo thun nam mùa hè - Thoải mái và phong cách<\/h2><p style=\"text-align: justify\"><strong>Chất liệu:<\/strong><\/p><ul><li><strong>Cotton 100%<\/strong>: Mềm mại, thoáng mát, thấm hút mồ hôi tốt, giúp bạn luôn cảm thấy thoải mái trong những ngày hè nóng bức.<\/li><li><strong>Cotton pha<\/strong>: Chất liệu pha trộn giữa cotton và các loại sợi tổng hợp khác như polyester, spandex giúp tăng độ co giãn, bền bỉ và dễ dàng giặt ủi.<\/li><li><strong>Cotton pique<\/strong>: Chất liệu dệt thoi với những mắt vải nhỏ li ti tạo độ thông thoáng tối ưu, thích hợp cho những hoạt động thể thao hoặc di chuyển nhiều.<\/li><\/ul><p style=\"text-align: justify\"><strong>Kiểu dáng:<\/strong><\/p><ul><li><strong>Áo thun trơn<\/strong>: Kiểu dáng đơn giản, basic, dễ dàng phối đồ với quần jean, quần short, kaki,... phù hợp cho mọi hoàn cảnh.<\/li><li><strong>Áo thun in<\/strong>: In hình, logo, họa tiết,... tạo điểm nhấn cho trang phục, thể hiện cá tính riêng của bạn.<\/li><li><strong>Áo thun polo<\/strong>: Cổ bẻ, có khuy cài, mang đến vẻ lịch sự, thanh lịch, phù hợp cho môi trường công sở hoặc những dịp quan trọng.<\/li><li><strong>Áo thun croptop<\/strong>: Ngắn hơn so với áo thun thông thường, khoe vòng eo thon gọn, thích hợp cho các bạn nam có thân hình cân đối.<\/li><li><div class=\"se-component se-image-container __se__float-none\" style=\"box-sizing: border-box; border: 0px solid rgb(229, 231, 235); --tw-border-spacing-x: 0; --tw-border-spacing-y: 0; --tw-translate-x: 0; --tw-translate-y: 0; --tw-rotate: 0; --tw-skew-x: 0; --tw-skew-y: 0; --tw-scale-x: 1; --tw-scale-y: 1; --tw-pan-x: ; --tw-pan-y: ; --tw-pinch-zoom: ; --tw-scroll-snap-strictness: proximity; --tw-gradient-from-position: ; --tw-gradient-via-position: ; --tw-gradient-to-position: ; --tw-ordinal: ; --tw-slashed-zero: ; --tw-numeric-figure: ; --tw-numeric-spacing: ; --tw-numeric-fraction: ; --tw-ring-inset: ; --tw-ring-offset-width: 0px; --tw-ring-offset-color: #fff; --tw-ring-color: rgba(59,130,246,.5); --tw-ring-offset-shadow: 0 0 #0000; --tw-ring-shadow: 0 0 #0000; --tw-shadow: 0 0 #0000; --tw-shadow-colored: 0 0 #0000; --tw-blur: ; --tw-brightness: ; --tw-contrast: ; --tw-grayscale: ; --tw-hue-rotate: ; --tw-invert: ; --tw-saturate: ; --tw-sepia: ; --tw-drop-shadow: ; --tw-backdrop-blur: ; --tw-backdrop-brightness: ; --tw-backdrop-contrast: ; --tw-backdrop-grayscale: ; --tw-backdrop-hue-rotate: ; --tw-backdrop-invert: ; --tw-backdrop-opacity: ; --tw-backdrop-saturate: ; --tw-backdrop-sepia: ; --tw-contain-size: ; --tw-contain-layout: ; --tw-contain-paint: ; --tw-contain-style: \"><figure style=\"box-sizing: border-box; border: 0px solid rgb(229, 231, 235); --tw-border-spacing-x: 0; --tw-border-spacing-y: 0; --tw-translate-x: 0; --tw-translate-y: 0; --tw-rotate: 0; --tw-skew-x: 0; --tw-skew-y: 0; --tw-scale-x: 1; --tw-scale-y: 1; --tw-pan-x: ; --tw-pan-y: ; --tw-pinch-zoom: ; --tw-scroll-snap-strictness: proximity; --tw-gradient-from-position: ; --tw-gradient-via-position: ; --tw-gradient-to-position: ; --tw-ordinal: ; --tw-slashed-zero: ; --tw-numeric-figure: ; --tw-numeric-spacing: ; --tw-numeric-fraction: ; --tw-ring-inset: ; --tw-ring-offset-width: 0px; --tw-ring-offset-color: #fff; --tw-ring-color: rgba(59,130,246,.5); --tw-ring-offset-shadow: 0 0 #0000; --tw-ring-shadow: 0 0 #0000; --tw-shadow: 0 0 #0000; --tw-shadow-colored: 0 0 #0000; --tw-blur: ; --tw-brightness: ; --tw-contrast: ; --tw-grayscale: ; --tw-hue-rotate: ; --tw-invert: ; --tw-saturate: ; --tw-sepia: ; --tw-drop-shadow: ; --tw-backdrop-blur: ; --tw-backdrop-brightness: ; --tw-backdrop-contrast: ; --tw-backdrop-grayscale: ; --tw-backdrop-hue-rotate: ; --tw-backdrop-invert: ; --tw-backdrop-opacity: ; --tw-backdrop-saturate: ; --tw-backdrop-sepia: ; --tw-contain-size: ; --tw-contain-layout: ; --tw-contain-paint: ; --tw-contain-style: ; margin: 0px;\"><img src=\"https:\/\/taka-shop-bucket.s3.ap-southeast-1.amazonaws.com\/1714997846868_vn-11134207-7r98o-lsqrfx7q4pmse8.jpg\" alt=\"\" data-rotate=\"\" data-proportion=\"true\" data-size=\",\" data-align=\"none\" data-percentage=\"auto,auto\" data-file-name=\"vn-11134207-7r98o-lsqrfx7q4pmse8.jpg\" data-file-size=\"211790\" data-origin=\",\" style=\"box-sizing: border-box; border: 0px solid rgb(229, 231, 235); --tw-border-spacing-x: 0; --tw-border-spacing-y: 0; --tw-translate-x: 0; --tw-translate-y: 0; --tw-rotate: 0; --tw-skew-x: 0; --tw-skew-y: 0; --tw-scale-x: 1; --tw-scale-y: 1; --tw-pan-x: ; --tw-pan-y: ; --tw-pinch-zoom: ; --tw-scroll-snap-strictness: proximity; --tw-gradient-from-position: ; --tw-gradient-via-position: ; --tw-gradient-to-position: ; --tw-ordinal: ; --tw-slashed-zero: ; --tw-numeric-figure: ; --tw-numeric-spacing: ; --tw-numeric-fraction: ; --tw-ring-inset: ; --tw-ring-offset-width: 0px; --tw-ring-offset-color: #fff; --tw-ring-color: rgba(59,130,246,.5); --tw-ring-offset-shadow: 0 0 #0000; --tw-ring-shadow: 0 0 #0000; --tw-shadow: 0 0 #0000; --tw-shadow-colored: 0 0 #0000; --tw-blur: ; --tw-brightness: ; --tw-contrast: ; --tw-grayscale: ; --tw-hue-rotate: ; --tw-invert: ; --tw-saturate: ; --tw-sepia: ; --tw-drop-shadow: ; --tw-backdrop-blur: ; --tw-backdrop-brightness: ; --tw-backdrop-contrast: ; --tw-backdrop-grayscale: ; --tw-backdrop-hue-rotate: ; --tw-backdrop-invert: ; --tw-backdrop-opacity: ; --tw-backdrop-saturate: ; --tw-backdrop-sepia: ; --tw-contain-size: ; --tw-contain-layout: ; --tw-contain-paint: ; --tw-contain-style: ; display: block; vertical-align: middle;\"><\/figure><\/div><\/li><li><br><\/li><\/ul><p style=\"text-align: justify\"><strong>Màu sắc:<\/strong><\/p><ul><li><strong>Màu trơn<\/strong>: Trắng, đen, xám, xanh navy,... dễ dàng phối đồ và không bao giờ lỗi mốt.<\/li><li><strong>Màu sắc tươi sáng<\/strong>: Vàng, cam, đỏ,... tạo điểm nhấn cho trang phục, giúp bạn thêm nổi bật.<\/li><li><strong>Màu họa tiết<\/strong>: In hoa, in hình,... thể hiện cá tính và phong cách riêng của bạn.<\/li><\/ul><p style=\"text-align: justify\"><strong>Kích thước:<\/strong><\/p><ul><li><strong>S, M, L, XL, XXL<\/strong>: Phù hợp với mọi vóc dáng cơ thể.<\/li><\/ul><p style=\"text-align: justify\"><strong>Lưu ý khi chọn mua áo thun nam mùa hè:<\/strong><\/p><ul><li><strong>Chọn chất liệu phù hợp với sở thích và nhu cầu sử dụng.<\/strong><\/li><li><strong>Chọn kiểu dáng phù hợp với vóc dáng và phong cách cá nhân.<\/strong><\/li><li><strong>Chọn màu sắc ưa thích và dễ dàng phối đồ.<\/strong><\/li><li><strong>Chọn kích thước phù hợp để đảm bảo sự thoải mái khi mặc.<\/strong><\/li><\/ul><p style=\"text-align: justify\"><strong>Ngoài ra, bạn cũng nên lưu ý đến một số yếu tố khác như thương hiệu, giá cả, chế độ bảo hành,... để lựa chọn được sản phẩm ưng ý nhất.<\/strong><\/p><p style=\"text-align: justify\"><strong>Chúc bạn mua sắm vui vẻ!<\/strong><\/p>";
