import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextMonserats extends StatelessWidget {
  final String text;
  final Color? color;
  final FontWeight? fontWeight;
  final double? fontSize;
  final int? maxLine;
  final TextAlign? textAlign;
  final double height;
  final TextOverflow? overflow;

  const TextMonserats(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.fontSize,
    this.maxLine,
    this.textAlign,
    this.overflow,
    this.height = 1.75,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.getFont(
        'Montserrat',
        color: color,
        fontWeight: fontWeight ?? FontWeight.w600,
        fontSize: fontSize ?? 14,
        height: height,
      ),
      overflow: overflow,
      maxLines: maxLine,
      textAlign: textAlign,
    );
  }
}
