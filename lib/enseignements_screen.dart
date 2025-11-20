import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'enseignement_model.dart';
import 'enseignement_detail_screen.dart';
import 'database_service.dart';

class EnseignementsScreen extends StatelessWidget {
  const EnseignementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DatabaseService _dbService = DatabaseService();

    return Scaffold(
      backgroundColor: const Color(0xFF1F2B4E),
      appBar: AppBar(
        title: const Text('Enseignements'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: StreamBuilder<List<Enseignement>>(
        stream: _dbService.getEnseignements(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Une erreur est survenue', style: TextStyle(color: Colors.white)));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Aucun enseignement trouvé', style: TextStyle(color: Colors.white)));
          }

          final enseignements = snapshot.data!;

          // 1. Envelopper la liste dans AnimationLimiter
          return AnimationLimiter(
            child: ListView.builder(
              itemCount: enseignements.length,
              itemBuilder: (context, index) {
                final enseignement = enseignements[index];
                
                // 2. Envelopper chaque item dans les widgets d'animation
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: Card(
                        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        color: const Color(0xFF2C3A5B),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(15),
                          leading: const Icon(Icons.play_circle_fill, color: Colors.pinkAccent, size: 40),
                          title: Text(enseignement.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          subtitle: Text(enseignement.speaker, style: const TextStyle(color: Colors.white70)),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EnseignementDetailScreen(enseignement: enseignement),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
