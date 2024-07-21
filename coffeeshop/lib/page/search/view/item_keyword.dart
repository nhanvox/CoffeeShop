import 'package:flutter/material.dart';

class ItemKeyword extends StatelessWidget {
  final String itemname;
  const ItemKeyword({super.key, required this.itemname});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Color(0xFF2A4261), width: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      ),
      child: Text(
        itemname,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Color(0xFF2A4261),
          fontSize: 15,
          fontFamily: 'Quicksand',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
