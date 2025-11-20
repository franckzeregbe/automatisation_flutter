import 'package:cloud_firestore/cloud_firestore.dart';

class Goal {
  final String id;
  final String title;
  final String type; // 'daily', 'weekly', 'monthly'
  final int currentProgress;
  final int target;
  final Timestamp timestamp;

  Goal({
    required this.id,
    required this.title,
    required this.type,
    required this.currentProgress,
    required this.target,
    required this.timestamp,
  });

  factory Goal.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Goal(
      id: doc.id,
      title: data['title'] ?? '',
      type: data['type'] ?? 'daily',
      currentProgress: data['currentProgress'] ?? 0,
      target: data['target'] ?? 1, // Default target to 1 to avoid division by zero
      timestamp: data['timestamp'] ?? Timestamp.now(),
    );
  }
}
