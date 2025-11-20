import 'package:flutter/material.dart';
import 'dart:convert'; // Pour le JSON
import 'package:flutter/services.dart'; // Pour charger les assets

// 1. Structures de données pour modéliser la Bible
class BibleBook {
  final String name;
  final List<BibleChapter> chapters;
  BibleBook({required this.name, required this.chapters});

  factory BibleBook.fromJson(Map<String, dynamic> json) {
    var chapterList = json['chapters'] as List;
    List<BibleChapter> chapters = chapterList.map((i) => BibleChapter.fromJson(i)).toList();
    return BibleBook(name: json['book'], chapters: chapters);
  }
}

class BibleChapter {
  final int chapterNumber;
  final List<BibleVerse> verses;
  BibleChapter({required this.chapterNumber, required this.verses});

  factory BibleChapter.fromJson(Map<String, dynamic> json) {
    var verseList = json['verses'] as List;
    List<BibleVerse> verses = verseList.map((i) => BibleVerse.fromJson(i)).toList();
    return BibleChapter(chapterNumber: json['chapter'], verses: verses);
  }
}

class BibleVerse {
  final int verseNumber;
  final String text;
  BibleVerse({required this.verseNumber, required this.text});

  factory BibleVerse.fromJson(Map<String, dynamic> json) {
    return BibleVerse(verseNumber: json['verse'], text: json['text']);
  }
}

// 2. L'écran qui affiche le contenu du livre
class BookScreen extends StatefulWidget {
  final String bookName;
  const BookScreen({super.key, required this.bookName});

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  Future<BibleBook>? _bookFuture;

  @override
  void initState() {
    super.initState();
    _bookFuture = _loadBook();
  }

  // MODIFIÉ : Charge dynamiquement le fichier JSON en fonction du nom du livre
  Future<BibleBook> _loadBook() async {
    // On convertit le nom du livre en nom de fichier (ex: "Exode" -> "exode")
    String fileName = widget.bookName.toLowerCase();

    // Cas particulier pour les noms qui ne correspondent pas directement (ex: accents)
    if (widget.bookName == "Genèse") {
      fileName = "genesis";
    }

    final path = 'assets/bible/$fileName.json';

    try {
      final String response = await rootBundle.loadString(path);
      final data = await json.decode(response);
      return BibleBook.fromJson(data);
    } catch (e) {
      // Gère l'erreur si le fichier n'est pas trouvé ou est invalide
      throw Exception('Impossible de charger le livre depuis \'$path\'');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F2B4E),
      appBar: AppBar(
        title: Text(widget.bookName),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FutureBuilder<BibleBook>(
        future: _bookFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Erreur de chargement: ${snapshot.error}", style: const TextStyle(color: Colors.red)));
          }
          if (!snapshot.hasData) {
            return const Center(child: Text("Livre non trouvé."));
          }

          final book = snapshot.data!;
          return ChapterList(book: book); // Affiche la liste des chapitres
        },
      ),
    );
  }
}

// 3. Widget qui affiche la liste des chapitres
class ChapterList extends StatelessWidget {
  final BibleBook book;
  const ChapterList({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: book.chapters.length,
      itemBuilder: (context, index) {
        final chapter = book.chapters[index];
        return ListTile(
          title: Text('Chapitre ${chapter.chapterNumber}', style: const TextStyle(color: Colors.white)),
          trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 16),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChapterView(chapter: chapter, bookName: book.name),
              ),
            );
          },
        );
      },
    );
  }
}

// 4. Widget qui affiche le contenu d'un chapitre
class ChapterView extends StatelessWidget {
  final BibleChapter chapter;
  final String bookName; // On reçoit le nom du livre pour l'afficher dans l'AppBar
  const ChapterView({super.key, required this.chapter, required this.bookName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F2B4E),
      appBar: AppBar(
        title: Text('$bookName - Chapitre ${chapter.chapterNumber}'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: chapter.verses.length,
        itemBuilder: (context, index) {
          final verse = chapter.verses[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text(
              '${verse.verseNumber} ${verse.text}',
              style: const TextStyle(color: Colors.white, fontSize: 16, height: 1.5),
            ),
          );
        },
      ),
    );
  }
}
