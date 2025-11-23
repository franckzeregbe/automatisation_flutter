import 'package:flutter/material.dart';
import 'package:blessing/testimony_model.dart';
import 'database_service.dart';

// Pour un ID utilisateur factice. À remplacer par une vraie authentification.
const String FAKE_USER_ID = '12345';
const String FAKE_USER_NAME = 'Utilisateur Anonyme';

class TestimoniesScreen extends StatefulWidget {
  const TestimoniesScreen({super.key});

  @override
  State<TestimoniesScreen> createState() => _TestimoniesScreenState();
}

class _TestimoniesScreenState extends State<TestimoniesScreen> {
  final DatabaseService _dbService = DatabaseService();

  void _showAddTestimonyDialog() {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController contentController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2C3A5B),
          title: const Text('Partager un Témoignage', style: TextStyle(color: Colors.white)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Titre',
                    labelStyle: TextStyle(color: Colors.white70),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: contentController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Votre témoignage...',
                    labelStyle: TextStyle(color: Colors.white70),
                  ),
                  maxLines: 5,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Annuler', style: TextStyle(color: Colors.white70)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
              child: const Text('Publier', style: TextStyle(color: Colors.white)),
              onPressed: () {
                if (titleController.text.trim().isNotEmpty && contentController.text.trim().isNotEmpty) {
                  _dbService.addTestimony(
                    titleController.text.trim(),
                    contentController.text.trim(),
                    FAKE_USER_NAME, // À remplacer par le nom de l'utilisateur authentifié
                    FAKE_USER_ID, // À remplacer par l'ID de l'utilisateur authentifié
                  );
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F2B4E),
      appBar: AppBar(
        title: const Text('Témoignages de Foi'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_comment_outlined, size: 26),
            onPressed: _showAddTestimonyDialog,
          ),
        ],
      ),
      body: StreamBuilder<List<Testimony>>(
        stream: _dbService.getTestimonies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'Aucun témoignage pour le moment.\nSoyez le premier à partager le vôtre !',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
            );
          }

          var testimonies = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(15),
            itemCount: testimonies.length,
            itemBuilder: (context, index) {
              final testimony = testimonies[index];
              return Card(
                color: const Color(0xFF2C3A5B),
                margin: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: const BorderSide(color: Colors.pinkAccent, width: 1),
                ),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(testimony.title, style: const TextStyle(color: Colors.pinkAccent, fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Text(testimony.content, style: const TextStyle(color: Colors.white, fontSize: 15, height: 1.5)),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('par ${testimony.author}', style: const TextStyle(color: Colors.white70, fontStyle: FontStyle.italic)),
                          if (testimony.authorId == FAKE_USER_ID)
                            IconButton(
                              icon: const Icon(Icons.delete_sweep_outlined, color: Colors.redAccent),
                              onPressed: () => _dbService.deleteTestimony(testimony.id),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
