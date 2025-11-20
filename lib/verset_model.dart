class Verset {
  final String book;
  final int chapter;
  final int verse;
  final String text;

  Verset({required this.book, required this.chapter, required this.verse, required this.text});

  // Factory pour créer une instance depuis un objet JSON
  factory Verset.fromJson(Map<String, dynamic> json) {
    return Verset(
      book: json['book'] ?? '',
      chapter: json['chapter'] ?? 0,
      verse: json['verse'] ?? 0,
      text: json['text'] ?? '',
    );
  }
}
