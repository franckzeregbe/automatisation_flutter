import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:automatisation_flutter/note_model.dart';
import 'database_service.dart';
// Pour un ID utilisateur factice. À remplacer par une vraie authentification.
const String FAKE_USER_ID = '12345';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final DatabaseService _dbService = DatabaseService();
  final TextEditingController _noteController = TextEditingController();

  void _addNote() {
    if (_noteController.text.trim().isEmpty) return;
    _dbService.addNote(_noteController.text.trim(), FAKE_USER_ID);
    _noteController.clear();
    FocusScope.of(context).unfocus();
  }

  void _deleteNote(String noteId) {
    _dbService.deleteNote(noteId, FAKE_USER_ID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F2B4E),
      appBar: AppBar(
        title: const Text('Mes Notes'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Note>>(
              stream: _dbService.getNotes(FAKE_USER_ID),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      'Aucune note pour le moment.\nAjoutez-en une ci-dessous !',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                  );
                }

                var notes = snapshot.data!;

                return ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    final note = notes[index];
                    return Card(
                      color: const Color(0xFF2C3A5B),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        title: Text(note.content, style: const TextStyle(color: Colors.white, fontSize: 15)),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                          onPressed: () => _deleteNote(note.id),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          _buildNoteInput(),
        ],
      ),
    );
  }

  Widget _buildNoteInput() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        color: const Color(0xFF2C3A5B),
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _noteController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Nouvelle note...',
                    hintStyle: TextStyle(color: Colors.white54),
                    border: InputBorder.none,
                  ),
                  maxLines: null,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add_circle, color: Colors.pinkAccent, size: 30),
                onPressed: _addNote,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
