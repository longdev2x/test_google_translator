import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class HtmlRender extends StatefulWidget {
  /// The HTML data passed to the widget as a String
  final String? data;

  /// A function that defines what to do when a link is tapped
  final OnTap? onLinkTap;

  /// A function that defines what to do when an anchor link is tapped. When this value is set,
  /// the default anchor behaviour is overwritten.
  final OnTap? onAnchorTap;

  /// A function that defines what to do when CSS fails to parse
  final OnCssParseError? onCssParseError;

  /// A function that defines what to do when an image errors
  final ImageErrorListener? onImageError;

  /// A parameter that should be set when the HTML widget is expected to be
  /// flexible
  final bool? shrinkWrap;

  /// A function that defines what to do when an image is tapped
  final OnTap? onImageTap;

  /// A list of HTML tags that are the only tags that are rendered. By default, this list is empty and all supported HTML tags are rendered.
  final List<String>? tagsList;

  /// An API that allows you to override the default style for any HTML element
  final Map<String, Style>? style;

  /// Decides how to handle a specific navigation request in the WebView of an
  /// Iframe. It's necessary to use the webview_flutter package inside the app
  /// to use NavigationDelegate.
  const HtmlRender({
    Key? key,
    required this.data,
    this.onLinkTap,
    this.onAnchorTap,
    this.onCssParseError,
    this.onImageError,
    this.shrinkWrap = false,
    this.onImageTap,
    this.tagsList,
    this.style,
  }) : super(key: key);

  @override
  State<HtmlRender> createState() => _HtmlRenderState();
}

class _HtmlRenderState extends State<HtmlRender> {
  @override
  Widget build(BuildContext context) {
    return Html(
      data: widget.data ?? '',
      style: widget.style ??
          {
            '#': Style(
              margin: Margins.zero,
              padding: HtmlPaddings.zero,
            ),
          },
      onLinkTap: widget.onLinkTap,
      onAnchorTap: widget.onAnchorTap,
      onCssParseError: widget.onCssParseError,
      shrinkWrap: widget.shrinkWrap ?? false,
    );
  }
}
