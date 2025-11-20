import 'package:flutter/material.dart';
import 'grid_item.dart';

// 1. Importer tous les écrans, anciens et nouveaux
import 'enseignements_screen.dart';
import 'hymnes_screen.dart';
import 'evenements_screen.dart';
import 'dons_screen.dart';
import 'verset_biblique_screen.dart';
import 'notes_screen.dart'; // NOUVEAU
import 'goals_screen.dart'; // NOUVEAU
import 'testimonies_screen.dart'; // NOUVEAU
import 'gamification_screen.dart'; // NOUVEAU

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Liste des éléments du menu, mise à jour avec les nouvelles sections
    final List<Map<String, dynamic>> items = [
      {
        'icon': Icons.book_outlined,
        'title': 'Enseignements',
        'onTap': () => Navigator.push(context, MaterialPageRoute(builder: (context) => const EnseignementsScreen())),
      },
      {
        'icon': Icons.music_note_outlined,
        'title': 'Hymnes et Louanges',
        'onTap': () => Navigator.push(context, MaterialPageRoute(builder: (context) => const HymnesScreen())),
      },
      {
        'icon': Icons.event_outlined,
        'title': 'Événements',
        'onTap': () => Navigator.push(context, MaterialPageRoute(builder: (context) => const EvenementsScreen())),
      },
      {
        'icon': Icons.auto_stories_outlined,
        'title': 'Verset Biblique',
        'onTap': () => Navigator.push(context, MaterialPageRoute(builder: (context) => const VersetBibliqueScreen())),
      },
      {
        'icon': Icons.note_alt_outlined,
        'title': 'Mes Notes',
        'onTap': () => Navigator.push(context, MaterialPageRoute(builder: (context) => const NotesScreen())),
      },
      {
        'icon': Icons.flag_outlined,
        'title': 'Mes Objectifs',
        'onTap': () => Navigator.push(context, MaterialPageRoute(builder: (context) => const GoalsScreen())),
      },
      {
        'icon': Icons.campaign_outlined,
        'title': 'Témoignages',
        'onTap': () => Navigator.push(context, MaterialPageRoute(builder: (context) => const TestimoniesScreen())),
      },
      {
        'icon': Icons.military_tech_outlined,
        'title': 'Mon Progrès',
        'onTap': () => Navigator.push(context, MaterialPageRoute(builder: (context) => const GamificationScreen())),
      },
      {
        'icon': Icons.favorite_border_outlined,
        'title': 'Dons et Offrandes',
        'onTap': () => Navigator.push(context, MaterialPageRoute(builder: (context) => const DonsScreen())),
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF1F2B4E),
      appBar: AppBar(
        title: const Text('Accueil', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 18,
            mainAxisSpacing: 18,
            childAspectRatio: 1.1, 
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return GridItem(
              icon: items[index]['icon'],
              title: items[index]['title'],
              onTap: items[index]['onTap'],
            );
          },
        ),
      ),
    );
  }
}
