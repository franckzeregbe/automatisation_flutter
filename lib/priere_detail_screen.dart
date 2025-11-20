import 'package:flutter/material.dart';
import 'prieres_screen.dart'; // On importe la définition de la classe Priere

class PriereDetailScreen extends StatelessWidget {
  final Priere priere;

  const PriereDetailScreen({super.key, required this.priere});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F2B4E),
      appBar: AppBar(
        title: Text(priere.titre),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              priere.titre,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              priere.contenu,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 18,
                height: 1.5, // Interligne pour une meilleure lisibilité
              ),
            ),
          ],
        ),
      ),
    );
  }
}
