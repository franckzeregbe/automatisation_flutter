import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'evenement_model.dart';
import 'evenement_detail_screen.dart';
import 'database_service.dart';

class EvenementsScreen extends StatelessWidget {
  const EvenementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DatabaseService _dbService = DatabaseService();

    return Scaffold(
      backgroundColor: const Color(0xFF1F2B4E),
      appBar: AppBar(
        title: const Text('Événements'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: StreamBuilder<List<Evenement>>(
        stream: _dbService.getEvenements(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Une erreur est survenue', style: TextStyle(color: Colors.white)));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Aucun événement à venir', style: TextStyle(color: Colors.white)));
          }

          final evenements = snapshot.data!;

          return AnimationLimiter(
            child: ListView.builder(
              itemCount: evenements.length,
              itemBuilder: (context, index) {
                final evenement = evenements[index];
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
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EvenementDetailScreen(evenement: evenement),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  evenement.date,
                                  style: const TextStyle(color: Colors.pinkAccent, fontSize: 13, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  evenement.title,
                                  style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    const Icon(Icons.location_on, color: Colors.white54, size: 16),
                                    const SizedBox(width: 5),
                                    Text(evenement.location, style: const TextStyle(color: Colors.white70, fontSize: 14)),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                const Align(
                                  alignment: Alignment.centerRight,
                                  child: Text('Voir les détails →', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          ),
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
