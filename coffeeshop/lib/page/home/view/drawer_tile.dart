import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final Function() press;
  final bool isActive;
  final String title;
  final IconData icon;

  const DrawerTile({
    super.key,
    required this.isActive,
    required this.press,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width * 0.55;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            height: 56,
            width: isActive ? screenWidth : 0,
            child: Container(
              decoration: const BoxDecoration(
                  color: Color(0xFFFF725E),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
            ),
          ),
          ListTile(
            leading: Icon(icon, size: 30),
            title: Text(title),
            onTap: press,
          ),
        ],
      ),
    );
  }
}
