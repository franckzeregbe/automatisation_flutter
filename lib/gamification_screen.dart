import 'package:flutter/material.dart';
import 'package:blessing/user_model.dart';
import 'database_service.dart';

// Pour un ID utilisateur factice. À remplacer par une vraie authentification.
const String FAKE_USER_ID = '12345';
const String FAKE_USER_NAME = 'Vous';

class GamificationScreen extends StatelessWidget {
  const GamificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DatabaseService dbService = DatabaseService();

    return Scaffold(
      backgroundColor: const Color(0xFF1F2B4E),
      appBar: AppBar(
        title: const Text('Mon Progrès Spirituel'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: StreamBuilder<AppUser>(
        stream: dbService.getUser(FAKE_USER_ID),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final user = snapshot.data!;
          final xpForNextLevel = (user.level) * 100;
          final currentLevelXp = user.xp - ((user.level - 1) * 100);
          final progress = currentLevelXp / 100;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                _buildLevelCard(user, progress, currentLevelXp, 100),
                const SizedBox(height: 30),
                _buildBadgesSection(),
                const SizedBox(height: 30),
                _buildLeaderboardPreview(user),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLevelCard(AppUser user, double progress, int currentLevelXp, int xpToNext) {
    return Card(
      color: const Color(0xFF2C3A5B),
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Text('Niveau ${user.level}', style: const TextStyle(color: Colors.pinkAccent, fontSize: 32, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text('${user.xp} XP Total', style: const TextStyle(color: Colors.white70, fontSize: 16)),
            const SizedBox(height: 20),
            LinearProgressIndicator(
              value: progress,
              minHeight: 12,
              backgroundColor: Colors.white12,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.pinkAccent),
              borderRadius: BorderRadius.circular(6),
            ),
            const SizedBox(height: 10),
            Text('$currentLevelXp / $xpToNext XP pour le prochain niveau', style: const TextStyle(color: Colors.white, fontSize: 14)),
          ],
        ),
      ),
    );
  }

  Widget _buildBadgesSection() {
    // Les badges peuvent être débloqués en fonction des actions de l'utilisateur.
    // Pour le moment, ceci est une maquette.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Badges Récents', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        Wrap(
          spacing: 15,
          runSpacing: 15,
          children: [
            _buildBadge(Icons.article, 'Apprenti Scribe', '1ère note ajoutée'),
            _buildBadge(Icons.favorite, 'Coeur de Prière', '1ère prière partagée'),
            _buildBadge(Icons.flag, 'Visionnaire', '1er objectif créé'),
            _buildBadge(Icons.campaign, 'Porte-Voix', '1er témoignage'),
            _buildBadge(Icons.star, 'Explorateur', 'Niveau 5 atteint'),
          ],
        ),
      ],
    );
  }

  Widget _buildBadge(IconData icon, String title, String subtitle) {
    return Chip(
      avatar: Icon(icon, color: Colors.pinkAccent, size: 22),
      label: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      backgroundColor: const Color(0xFF2C3A5B),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      side: const BorderSide(color: Colors.white24),
    );
  }

  Widget _buildLeaderboardPreview(AppUser user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Classement (Top 3)', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        // Maquette du classement. Une vraie implémentation nécessiterait une requête Firestore.
        Card(color: const Color(0xFF2C3A5B), child: ListTile(leading: const Text('🥇', style: TextStyle(fontSize: 22)), title: const Text('Utilisateur A', style: TextStyle(color: Colors.white)), trailing: const Text('560 XP', style: TextStyle(color: Colors.amber)))),
        Card(color: const Color(0xFF2C3A5B), child: ListTile(leading: const Text('🥈', style: TextStyle(fontSize: 22)), title: const Text('Utilisateur B', style: TextStyle(color: Colors.white)), trailing: const Text('480 XP', style: TextStyle(color: Colors.grey)))),
        Card(color: const Color(0xFF2C3A5B), child: ListTile(leading: const Text('🥉', style: TextStyle(fontSize: 22)), title: Text(FAKE_USER_NAME, style: const TextStyle(color: Colors.white)), trailing: Text('${user.xp} XP', style: const TextStyle(color: Colors.brown)))),
      ],
    );
  }
}
