import 'package:flutter/material.dart';

class CardNews extends StatelessWidget {
  final String image;
  const CardNews({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          width: 180,
          height: 90,
          // margin: const EdgeInsets.only(right: 30, bottom: 8),
          // clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            // color: const Color(0xFFE2DCCA),
            image: DecorationImage(image: AssetImage(image), fit: BoxFit.fill),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ),
    );
  }
}
