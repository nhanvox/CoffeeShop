import 'package:coffeeshop/model/notify.dart';
import 'package:coffeeshop/page/login/view/components/quicksand.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardNotify extends StatelessWidget {
  final Notify notify;
  const CardNotify({super.key, required this.notify});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        height: 95,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Container(
              width: 70.0,
              height: 70.0,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    notify.role == 1
                        ? 'assets/images/avatar_default.png'
                        : 'assets/images/notify_system.png',
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    notify.content,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.getFont(
                      'Quicksand',
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextQuicksand(
                    notify.datetime,
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
