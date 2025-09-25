import 'package:flutter/material.dart';
import 'package:flutter_auto_size_text/flutter_auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';

class AppText extends StatelessWidget {
  final String text;
  final TextType type;
  final TextAlign? align;
  final Color? color;
  final FontWeight? fontweight;
  final double? fontsize;
  final int? maxLines;

  const AppText(
    this.text, {
    super.key,
    this.type = TextType.paragraph,
    this.align,
    this.color,
    this.fontweight,
    this.fontsize,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      textAlign: align,
      style: _getStyle(context).copyWith(color: color),
      maxLines: maxLines,
    );
  }

  TextStyle _getStyle(BuildContext context) {
    switch (type) {
      case TextType.title:
        return GoogleFonts.roboto(
          textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: color ?? Colors.black,
            fontWeight: fontweight ?? FontWeight.bold,
            fontSize: fontsize ?? 20,
          ),
        );
      case TextType.subtitle:
        return GoogleFonts.manrope(
          textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: color ?? Colors.black54,
            fontWeight: fontweight ?? FontWeight.w600,
            fontSize: fontsize ?? 14,
          ),
          height: 1.8,
        );
      case TextType.paragraph:
        return GoogleFonts.manrope(
          textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: color ?? Colors.black54,
            fontWeight: fontweight ?? FontWeight.w600,
            fontSize: fontsize ?? 14,
            height: 1.8,
          ),
        );
      case TextType.caption:
        return GoogleFonts.manrope(
          textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: color ?? Colors.black54,
            fontWeight: fontweight ?? FontWeight.w600,
            fontSize: fontsize ?? 14,
            height: 1.8,
          ),
        );
    }
  }
}

enum TextType { title, subtitle, paragraph, caption }
