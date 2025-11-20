import 'package:flutter/material.dart';

class DonsScreen extends StatelessWidget {
  const DonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F2B4E),
      appBar: AppBar(
        title: const Text('Dons et Offrandes'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.favorite_outline,
              color: Colors.pinkAccent,
              size: 60,
            ),
            const SizedBox(height: 20),
            const Text(
              'Soutenez notre mission',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Votre générosité nous permet de continuer à partager la Parole de Dieu, d\'organiser des événements et de maintenir cette application pour le bénéfice de tous. Chaque don, petit ou grand, a un impact direct sur notre communauté.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              'Comment contribuer ?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            _buildContributionMethod(
              title: 'Virement bancaire',
              details: 'Vous pouvez envoyer votre don directement sur le compte de l\'église.\nIBAN : FR76 XXXX XXXX XXXX XXXX XXXX\nBIC : XXXXXXX',
            ),
            const SizedBox(height: 15),
            _buildContributionMethod(
              title: 'En personne',
              details: 'Il est possible de faire une offrande lors de nos cultes et rassemblements hebdomadaires.',
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              icon: const Icon(Icons.credit_card),
              label: const Text('Faire un don en ligne'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              onPressed: () {
                // Pour l'instant, cette action est décorative.
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('La fonctionnalité de don en ligne sera bientôt disponible !'),
                    backgroundColor: Colors.blueAccent,
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            const Text(
              '"Que chacun donne comme il l\'a résolu en son coeur, sans tristesse ni contrainte; car Dieu aime celui qui donne avec joie."\n- 2 Corinthiens 9:7',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white54,
                fontSize: 14,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget pour afficher une méthode de contribution
  Widget _buildContributionMethod({required String title, required String details}) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF2C3A5B),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            details,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 15,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
