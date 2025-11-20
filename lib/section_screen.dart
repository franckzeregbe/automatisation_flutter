import 'package:flutter/material.dart';

// Un écran générique pour afficher le contenu d'une section
class SectionScreen extends StatelessWidget {
  // Il reçoit le titre de la section pour savoir quoi afficher
  final String title;

  const SectionScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // On garde une cohérence visuelle avec le reste de l'app
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Barre de navigation avec le titre de la section et un bouton retour
              AppBar(
                title: Text(title),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              Expanded(
                child: Center(
                  child: Text(
                    'Contenu pour "$title" à venir.',
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
