import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController controller;
  Future<void> initalizeVideoPlayer;

  @override
  void initState() {
    controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');
    initalizeVideoPlayer = controller.initialize();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video Player Demo"),
      ),
      body: Stack(
        children: [
          Center(
            child: FutureBuilder(
                future: initalizeVideoPlayer,
                builder: (BuildContext context, AsyncSnapshot snapShot) {
                  if (snapShot.connectionState == ConnectionState.done) {
                    return AspectRatio(
                      aspectRatio: controller.value.aspectRatio,
                      child: VideoPlayer(controller),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ),
          Center(
            child: ButtonTheme(
              height: 100.0,
              minWidth: 100.0,
              child: RaisedButton(
                padding: EdgeInsets.all(60.0),
                color: Colors.transparent,
                textColor: Colors.white,
                onPressed: () {
                  setState(() {
                    if (controller.value.isPlaying) {
                      controller.pause();
                    } else {
                      controller.play();
                    }
                  });
                },
                child: Icon(
                  controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
