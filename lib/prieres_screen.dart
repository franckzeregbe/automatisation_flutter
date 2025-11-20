import 'package:flutter/material.dart';
import 'priere_detail_screen.dart';

// On définit la structure d'une Prière (titre et contenu)
class Priere {
  final String titre;
  final String contenu;
  Priere(this.titre, this.contenu);
}

class PrieresScreen extends StatelessWidget {
  PrieresScreen({super.key});

  // Liste de prières enrichie
  final List<Priere> _prieres = [
    Priere(
      "Prière du Matin",
      "Seigneur, en ce début de journée, je me tourne vers Toi. Merci pour le repos de cette nuit et pour le souffle de vie que Tu renouvelles en moi. Guide mes pas, mes paroles et mes pensées. Que tout ce que je fais aujourd'hui soit pour Ta gloire. Amen."
    ),
    Priere(
      "Prière du Soir",
      "Père miséricordieux, merci pour cette journée qui s'achève. Pardonne mes manquements et mes péchés. Je Te confie ma famille, mes amis et moi-même pour cette nuit. Garde-nous sous Ta protection et accorde-nous un sommeil paisible. Amen."
    ),
    Priere(
      "Prière de Gratitude",
      "Père céleste, je Te remercie pour toutes Tes bénédictions. Pour ma famille, mes amis, ma santé et pour Ton amour infini. Aide-moi à ne jamais tenir Tes dons pour acquis et à avoir un cœur rempli de gratitude en tout temps. Amen."
    ),
    Priere(
      "Prière pour la Famille",
      "Seigneur, je Te confie ma famille. Protège-la, bénis-la et garde-la unie dans Ton amour. Donne-nous la patience, la compréhension et la force de nous soutenir mutuellement. Que notre foyer soit un reflet de Ton amour. Amen."
    ),
    Priere(
      "Prière pour la Direction",
      "Esprit Saint, Toi qui illumines mon chemin, je me présente devant Toi. J'ai besoin de Ta sagesse et de Ta direction pour les décisions que je dois prendre. Ouvre mes yeux, mon esprit et mon cœur pour que je puisse suivre la voie que Tu as tracée pour moi. Amen."
    ),
    Priere(
      "Prière pour la Paix",
      "Dieu de paix, je Te prie pour notre monde. Apporte Ta paix là où il y a des conflits, Ton réconfort là où il y a de la peine, et Ton espérance là où règne le désespoir. Fais de moi un instrument de Ta paix. Amen."
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F2B4E),
      appBar: AppBar(
        title: const Text('Prières'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: _prieres.length,
        itemBuilder: (context, index) {
          final priere = _prieres[index];
          return Card(
            color: Colors.white.withOpacity(0.1),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: const EdgeInsets.symmetric(vertical: 5.0),
            child: ListTile(
              title: Text(
                priere.titre,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 16),
              onTap: () {
                // Navigation vers l'écran de détail en passant l'objet prière
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PriereDetailScreen(priere: priere),
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
