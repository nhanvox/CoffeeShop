import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TutorialPage extends StatefulWidget {
  const TutorialPage({super.key});

  @override
  State<TutorialPage> createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  final videoURL = "https://youtu.be/p6GTZW9ONN8?si=pC-rCfx_nstK4BGW";
  late YoutubePlayerController _ytController;

  @override
  void initState() {
    super.initState();
    final videoID = YoutubePlayer.convertUrlToId(videoURL);

    if (videoID != null) {
      _ytController = YoutubePlayerController(
        initialVideoId: videoID,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
        ),
      );
    }
  }

  @override
  void dispose() {
    _ytController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Color(0xFFFFFEF2)),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: const Color(0xFFFFFEF2),
              surfaceTintColor: const Color(0xFFFFFEF2),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: IconButton(
                    icon: const Icon(
                      Icons.more_vert,
                      color: Colors.black,
                      size: 33,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
              leading: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Builder(
                  builder: (context) {
                    return IconButton(
                      icon: const Icon(
                        Icons.menu,
                        size: 30,
                      ),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    );
                  },
                ),
              ),
              centerTitle: true,
              title: const Text(
                'Hướng dẫn sử dụng',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
              floating: true, // Giữ AppBar hiển thị khi cuộn
              pinned: true, // Giữ AppBar cố định
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    YoutubePlayer(
                      controller: _ytController,
                      showVideoProgressIndicator: true,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
