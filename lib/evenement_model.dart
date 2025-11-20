import 'package:cloud_firestore/cloud_firestore.dart';

class Evenement {
  final String title;
  final String date;
  final String location;
  final String description;

  Evenement({
    required this.title,
    required this.date,
    required this.location,
    required this.description,
  });

  // Factory pour créer une instance depuis un document Firestore
  factory Evenement.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Evenement(
      title: data['title'] ?? '',
      // Pour la date, Firestore utilise un Timestamp. Nous le convertissons en String.
      // Ici, on suppose que la date est stockée en String pour la simplicité.
      // Idéalement, on utiliserait un Timestamp et on le formaterait.
      date: data['date'] ?? '',
      location: data['location'] ?? '',
      description: data['description'] ?? '',
    );
  }
}
