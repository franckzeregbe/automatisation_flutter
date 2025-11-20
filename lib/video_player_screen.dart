import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'videos_screen.dart'; // Pour importer la classe Video

class VideoPlayerScreen extends StatefulWidget {
  final Video video;

  const VideoPlayerScreen({super.key, required this.video});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    // On initialise le contrôleur avec l'ID de la vidéo et des options
    _controller = YoutubePlayerController(
      initialVideoId: widget.video.youtubeId,
      flags: const YoutubePlayerFlags(
        autoPlay: true, // Lance la vidéo automatiquement
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F2B4E),
      appBar: AppBar(
        title: Text(widget.video.title),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        // Le widget YoutubePlayerUI affiche le lecteur vidéo et ses contrôles
        child: YoutubePlayerBuilder(
          player: YoutubePlayer(
            controller: _controller,
          ),
          builder: (context, player) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [player], // Affiche le lecteur
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Très important pour libérer les ressources
    super.dispose();
  }
}
