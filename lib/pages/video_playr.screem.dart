import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;

  VideoPlayerScreen({required this.videoUrl});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;
  double _volume = 1.0; // Volumen inicial al máximo

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
      });
    _controller.addListener(() {
      setState(() {
        _isPlaying = _controller.value.isPlaying;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player'),
        actions: [
          IconButton(
            icon: Icon(Icons.volume_up),
            onPressed: () {
              // Toggle mute or unmute
              setState(() {
                _volume = (_volume == 0.0) ? 1.0 : 0.0;
                _controller.setVolume(_volume);
              });
            },
          ),
        ],
      ),
      backgroundColor: Colors.black, // Fondo negro para toda la pantalla
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_controller.value.isInitialized)
            Container(
              color: Colors.black,
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            )
          else
            Center(
              child: CircularProgressIndicator(),
            ),
          VideoProgressIndicator(
            _controller,
            allowScrubbing: true,
            colors: VideoProgressColors(
              backgroundColor: Colors.grey,
              playedColor: Colors.blue,
              bufferedColor: Colors.lightGreen,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.replay_10),
                onPressed: () {
                  _controller.seekTo(
                    _controller.value.position - Duration(seconds: 10),
                  );
                },
              ),
              IconButton(
                icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                onPressed: () {
                  _isPlaying ? _controller.pause() : _controller.play();
                },
              ),
              IconButton(
                icon: Icon(Icons.forward_10),
                onPressed: () {
                  _controller.seekTo(
                    _controller.value.position + Duration(seconds: 10),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
