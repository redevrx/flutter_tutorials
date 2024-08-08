import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class GenshinVideoApp extends StatefulWidget {
  const GenshinVideoApp({super.key});

  @override
  State<GenshinVideoApp> createState() => _GenshinVideoAppState();
}

class _GenshinVideoAppState extends State<GenshinVideoApp> {
  final _videoList = [
    'assets/videos/video1.mp4',
    'assets/videos/video2.mp4',
    'assets/videos/video3.mp4',
    'assets/videos/video4.mp4',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: [
            backgroundImage(),

            /// main content
            Material(
              color: Colors.blue.withOpacity(.3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          VideoCard(path: _videoList[0]),
                          gap(),
                          VideoCard(path: _videoList[1]),
                          gap(),
                          VideoCard(path: _videoList[2]),
                          gap(),
                          VideoCard(path: _videoList[3])
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox gap() => const SizedBox(
        width: 4,
      );

  Image backgroundImage() {
    return Image.asset(
      'assets/images/genshin_background.png',
      height: double.infinity,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }
}

class VideoCard extends StatefulWidget {
  const VideoCard({super.key, required this.path});

  final String path;

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  late VideoPlayerController _controller;
  bool isShow = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.path)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (_controller.value.isPlaying) {
          await _controller.pause();
          setState(() {
            isShow = false;
          });
        } else {
          await _controller.play();
          setState(() {
            isShow = true;
          });
        }
      },
      child: Center(
        child: ClipRect(
          child: Align(
            alignment: Alignment.center,
            widthFactor: 0.8,
            heightFactor: 0.8,
            child: SizedBox(
              width: 400,
              height: 460,
              child: AspectRatio(
                aspectRatio: 9 / 16,
                child: VideoPlayer(_controller),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
