import 'package:cloud_firestore/cloud_firestore.dart';

class Testimony {
  final String id;
  final String title;
  final String content;
  final String author;
  final String authorId;
  final Timestamp timestamp;

  Testimony({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.authorId,
    required this.timestamp,
  });

  factory Testimony.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Testimony(
      id: doc.id,
      title: data['title'] ?? '',
      content: data['content'] ?? '',
      author: data['author'] ?? 'Anonyme',
      authorId: data['authorId'] ?? '',
      timestamp: data['timestamp'] ?? Timestamp.now(),
    );
  }
}
