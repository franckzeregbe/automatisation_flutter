import 'package:cloud_firestore/cloud_firestore.dart';

class Enseignement {
  final String title;
  final String speaker;
  final String videoId;
  final String summary; // Un résumé textuel

  const Enseignement({
    required this.title,
    required this.speaker,
    required this.videoId,
    required this.summary,
  });

  // Factory pour créer une instance depuis un document Firestore
  factory Enseignement.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Enseignement(
      title: data['title'] ?? '',
      speaker: data['speaker'] ?? '',
      videoId: data['videoId'] ?? '',
      summary: data['summary'] ?? '',
    );
  }
}
