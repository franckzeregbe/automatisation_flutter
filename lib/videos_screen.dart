import 'package:flutter/material.dart';
import 'video_player_screen.dart';

// Définition de la structure pour une vidéo
class Video {
  final String title;
  final String category;
  final String youtubeId;

  Video({required this.title, required this.category, required this.youtubeId});
}

class VideosScreen extends StatelessWidget {
  VideosScreen({super.key});

  // Liste d'exemples de vidéos enrichie
  final List<Video> _videos = [
    Video(
      title: "Introduction à la Méditation Chrétienne",
      category: "Spiritualité",
      youtubeId: "v_p9_T_iDpg",
    ),
    Video(
      title: "Étude Biblique : L'Épître aux Romains",
      category: "Études Bibliques",
      youtubeId: "O_AllB4G3dE",
    ),
    Video(
      title: "Louange et Adoration en Direct",
      category: "Musique",
      youtubeId: "3_J_y-i7Y0A",
    ),
    Video(
      title: "Le pouvoir du Pardon",
      category: "Témoignages",
      youtubeId: "88B_r_X-SJQ", 
    ),
    Video(
      title: "L'histoire de Pâques pour les enfants",
      category: "Pour les Enfants",
      youtubeId: "Wnbo2qa_e_I",
    ),
    Video(
      title: "Compilation de Louange Francophone",
      category: "Musique",
      youtubeId: "y3b_D3pGR_c",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F2B4E),
      appBar: AppBar(
        title: const Text('Vidéos'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: _videos.length,
        itemBuilder: (context, index) {
          final video = _videos[index];
          return Card(
            color: Colors.white.withOpacity(0.1),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: const EdgeInsets.symmetric(vertical: 5.0),
            child: ListTile(
              leading: const Icon(Icons.play_circle_outline, color: Colors.white70, size: 40),
              title: Text(
                video.title,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                video.category,
                style: const TextStyle(color: Colors.white60),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VideoPlayerScreen(video: video),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
