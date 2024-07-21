import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:coffeeshop/page/search/searchpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      width: double.infinity,
      child: TextButton(
        onPressed: () {
          Navigator.push(context,
              CupertinoPageRoute(builder: (context) => const SearchPage()));
        },
        style: TextButton.styleFrom(
          backgroundColor: const Color(0xFFE3E3E3),
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: const BorderSide(
              color: Color.fromARGB(255, 226, 226, 226),
              width: 1.2,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.start, // Căn chính icon và text ở đầu
            children: [
              const Icon(
                Icons.search,
                color: Color.fromARGB(255, 130, 130, 130),
              ),
              const SizedBox(width: 5), // Khoảng cách giữa icon và text
              AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                  TyperAnimatedText('Bạn muốn ăn gì nói luôn!',
                      textStyle: const TextStyle(
                        color: Color(0xFFADB5BD),
                        fontSize: 18,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                      speed: const Duration(milliseconds: 50)),
                  TyperAnimatedText('Lẹ lên!',
                      textStyle: const TextStyle(
                        color: Color(0xFFADB5BD),
                        fontSize: 18,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                      speed: const Duration(milliseconds: 50))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
