import 'package:flutter/material.dart';
import 'hymne_model.dart';

class HymneDetailScreen extends StatelessWidget {
  final Hymne hymne;

  const HymneDetailScreen({super.key, required this.hymne});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F2B4E),
      appBar: AppBar(
        title: Text(hymne.title),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Chant N°${hymne.number}',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              hymne.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            Text(
              hymne.lyrics,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                height: 1.6, // Interligne pour les strophes
              ),
            ),
          ],
        ),
      ),
    );
  }
}
