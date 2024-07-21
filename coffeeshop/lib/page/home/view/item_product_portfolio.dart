import 'package:flutter/material.dart';

class ItemsPP extends StatelessWidget {
  final Map category;
   final Function(String) onCategorySelected;
  const ItemsPP({
    super.key,
    required this.category, required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
          backgroundColor: const Color(0xFFE3E3E3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: () {
          onCategorySelected(category['_id']);
        },
        child: Text(
          category['name'],
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.w500,
            height: 0,
          ),
        ),
      ),
    );
  }
}
