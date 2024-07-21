import 'package:flutter/material.dart';

class CardNews extends StatelessWidget {
  final String image; 
  const CardNews({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 200,
        height: 100,
        margin: const EdgeInsets.only(right: 10, bottom: 8),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: const Color(0xFFE2DCCA),
          image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.fill),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
