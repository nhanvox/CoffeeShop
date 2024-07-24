import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextQuicksand extends StatelessWidget {
  final String text;
  final Color? color;
  final FontWeight? fontWeight;
  final double? fontSize;
  final int? maxLine;
  final TextAlign? textAlign;
  final double height;
  final TextOverflow? overflow;

  const TextQuicksand(
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
        'Quicksand',
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
