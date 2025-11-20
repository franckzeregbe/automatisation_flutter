import 'package:flutter/material.dart';

class NoteEditScreen extends StatefulWidget {
  const NoteEditScreen({super.key});

  @override
  State<NoteEditScreen> createState() => _NoteEditScreenState();
}

class _NoteEditScreenState extends State<NoteEditScreen> {
  final _textController = TextEditingController();

  void _saveNote() {
    // On ferme l'écran et on renvoie le contenu du champ de texte à l'écran précédent
    Navigator.pop(context, _textController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F2B4E),
      appBar: AppBar(
        title: const Text('Nouvelle Note'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        // Un champ de texte qui prend toute la place disponible
        child: TextField(
          controller: _textController,
          autofocus: true, // Le clavier apparaît automatiquement
          style: const TextStyle(color: Colors.white, fontSize: 18),
          maxLines: null, // Permet d'écrire sur plusieurs lignes
          keyboardType: TextInputType.multiline,
          decoration: const InputDecoration(
            hintText: 'Écrivez votre note ici...',
            hintStyle: TextStyle(color: Colors.white54),
            border: InputBorder.none, // Pas de bordure pour une sensation de page blanche
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _saveNote,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF2575FC),
        child: const Icon(Icons.save),
      ),
    );
  }
}
