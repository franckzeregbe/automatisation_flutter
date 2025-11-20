import 'package:cloud_firestore/cloud_firestore.dart';

class Hymne {
  final int number;
  final String title;
  final String lyrics;

  const Hymne({
    required this.number,
    required this.title,
    required this.lyrics,
  });

  // Factory pour créer une instance depuis un document Firestore
  factory Hymne.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Hymne(
      number: data['number'] ?? 0,
      title: data['title'] ?? '',
      lyrics: data['lyrics'] ?? '',
    );
  }
}
