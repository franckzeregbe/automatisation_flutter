import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String id;
  final String name;
  final int xp;
  // Le niveau peut être calculé à partir de l'XP, donc pas besoin de le stocker
  // final int level;

  AppUser({
    required this.id,
    required this.name,
    required this.xp,
  });

  int get level => (xp / 100).floor() + 1;

  factory AppUser.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return AppUser(
      id: doc.id,
      name: data['name'] ?? 'Utilisateur',
      xp: data['xp'] ?? 0,
    );
  }
}
