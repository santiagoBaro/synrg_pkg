// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:synrg/src/visual_elements/size.dart';

///
class SynrgText extends StatelessWidget {
  ///
  const SynrgText({
    required this.text,
    super.key,
    this.style,
    this.maxLines,
    this.textAlign,
    this.strutStyle,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.textScaler,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
    this.padding = const EdgeInsets.all(SynrgSize.x1),
  });

  factory SynrgText.headexr(
    String text, {
    TextAlign textAlign = TextAlign.start,
  }) {
    return SynrgText(
      text: text,
      textAlign: textAlign,
      style: const TextStyle(
        fontSize: SynrgSize.x5,
      ),
      padding: const EdgeInsets.only(
        top: SynrgSize.x2,
        left: SynrgSize.x1,
        right: SynrgSize.x1,
        bottom: SynrgSize.x1,
      ),
    );
  }

  final String text;
  final TextStyle? style;
  final EdgeInsetsGeometry padding;
  final int? maxLines;
  final TextAlign? textAlign;
  final StrutStyle? strutStyle;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final double? textScaleFactor;
  final TextScaler? textScaler;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;
  final Color? selectionColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Text(
        text,
        style: style,
        maxLines: maxLines,
        textAlign: textAlign,
        strutStyle: strutStyle,
        textDirection: textDirection,
        softWrap: softWrap,
        overflow: overflow,
        locale: locale,
        textScaleFactor: textScaleFactor,
        textScaler: textScaler,
        semanticsLabel: semanticsLabel,
        textWidthBasis: textWidthBasis,
        textHeightBehavior: textHeightBehavior,
        selectionColor: selectionColor,
      ),
    );
  }
}
