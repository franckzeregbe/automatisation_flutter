import 'package:flutter/material.dart';
import 'enseignement_model.dart';

class EnseignementDetailScreen extends StatelessWidget {
  final Enseignement enseignement;

  const EnseignementDetailScreen({super.key, required this.enseignement});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F2B4E),
      appBar: AppBar(
        title: Text(enseignement.title),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              enseignement.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Par ${enseignement.author}',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 25),
            Text(
              enseignement.content,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
                height: 1.5, // Interligne pour une meilleure lisibilité
              ),
            ),
          ],
        ),
      ),
    );
  }
}
