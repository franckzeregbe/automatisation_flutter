import 'package:flutter/material.dart';
import 'evenement_model.dart';

class EvenementDetailScreen extends StatelessWidget {
  final Evenement evenement;

  const EvenementDetailScreen({super.key, required this.evenement});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F2B4E),
      appBar: AppBar(
        title: Text(evenement.title),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color(0xFF2C3A5B),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    evenement.title,
                    style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  _buildDetailRow(Icons.calendar_today, 'Date', evenement.date),
                  const Divider(color: Colors.white24, height: 20),
                  _buildDetailRow(Icons.location_on, 'Lieu', evenement.location),
                ],
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              'À propos de l\'événement',
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              evenement.description,
              textAlign: TextAlign.justify,
              style: const TextStyle(color: Colors.white70, fontSize: 16, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }

  // Widget pour afficher une ligne de détail (icône, label, valeur)
  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.pinkAccent, size: 20),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: Colors.white54, fontSize: 14)),
            const SizedBox(height: 3),
            Text(value, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }
}
