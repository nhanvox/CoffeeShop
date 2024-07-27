import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemKeyword extends StatelessWidget {
  final String itemname;
  const ItemKeyword({super.key, required this.itemname});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFF2A4261), width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
        ),
        child: Text(
          itemname,
          textAlign: TextAlign.center,
          style: GoogleFonts.getFont(
            'Quicksand',
            color: const Color(0xFF2A4261),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
