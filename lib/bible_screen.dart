import 'package:flutter/material.dart';
import 'book_screen.dart';

class BibleScreen extends StatelessWidget {
  BibleScreen({super.key});

  // Liste complète des livres de la Bible
  final Map<String, List<String>> _bibleBooks = {
    "Ancien Testament": [
      "Genèse", "Exode", "Lévitique", "Nombres", "Deutéronome", "Josué", "Juges", "Ruth", 
      "1 Samuel", "2 Samuel", "1 Rois", "2 Rois", "1 Chroniques", "2 Chroniques", "Esdras", 
      "Néhémie", "Esther", "Job", "Psaumes", "Proverbes", "Ecclésiaste", "Cantique des Cantiques", 
      "Ésaïe", "Jérémie", "Lamentations", "Ézéchiel", "Daniel", "Osée", "Joël", "Amos", 
      "Abdias", "Jonas", "Michée", "Nahum", "Habacuc", "Sophonie", "Aggée", "Zacharie", "Malachie"
    ],
    "Nouveau Testament": [
      "Matthieu", "Marc", "Luc", "Jean", "Actes", "Romains", "1 Corinthiens", "2 Corinthiens", 
      "Galates", "Éphésiens", "Philippiens", "Colossiens", "1 Thessaloniciens", "2 Thessaloniciens", 
      "1 Timothée", "2 Timothée", "Tite", "Philémon", "Hébreux", "Jacques", "1 Pierre", "2 Pierre", 
      "1 Jean", "2 Jean", "3 Jean", "Jude", "Apocalypse"
    ]
  };

  // 1. On définit la liste des livres actuellement disponibles
  final List<String> _activeBooks = ["Genèse", "Exode"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F2B4E),
      appBar: AppBar(
        title: const Text('La Bible'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: _bibleBooks.keys.length,
        itemBuilder: (context, index) {
          String testament = _bibleBooks.keys.elementAt(index);
          List<String> books = _bibleBooks[testament]!;
          return ExpansionTile(
            title: Text(
              testament,
              style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            initiallyExpanded: true, // Garde les sections ouvertes par défaut
            children: books.map((book) {
              // 2. On vérifie si le livre fait partie de notre liste active
              bool isClickable = _activeBooks.contains(book);
              return ListTile(
                title: Text(
                  book,
                  style: TextStyle(color: isClickable ? Colors.white : Colors.grey),
                ),
                trailing: isClickable ? const Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 16) : null,
                onTap: () {
                  // 3. On autorise la navigation si le livre est cliquable
                  if (isClickable) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookScreen(bookName: book),
                      ),
                    );
                  }
                  // Rien ne se passe si le livre n'est pas actif
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
