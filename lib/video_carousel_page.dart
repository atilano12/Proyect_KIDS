import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoCarouselPage extends StatefulWidget {
  final String subjectTitle;
  final List<String> videoLinks;

  VideoCarouselPage({required this.subjectTitle, required this.videoLinks});

  @override
  _VideoCarouselPageState createState() => _VideoCarouselPageState();
}

class _VideoCarouselPageState extends State<VideoCarouselPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    // Inicializa el controlador del reproductor de YouTube con el primer enlace
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.videoLinks[0]) ?? '',
    );
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
        title: Text(widget.subjectTitle),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.videoLinks.length,
                itemBuilder: (context, index) {
                  final videoId = YoutubePlayer.convertUrlToId(
                      widget.videoLinks[index]);
                  return GestureDetector(
                    onTap: () {
                      if (videoId != null) {
                        _controller.load(videoId);
                      } else {
                        // Manejar el caso en que el enlace no sea válido
                        print('Enlace de video no válido');
                      }
                    },
                    child: Card(
                      child: ListTile(
                        title: Text('Video ${index + 1}'),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
