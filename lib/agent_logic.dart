
String getReponseSpirituelle(String input) {
  final String lowerInput = input.toLowerCase();

  // On recrée la map de réponses, comme dans le code JavaScript
  const Map<String, String> reponses = {
    'guerison': 'Il a pris nos infirmités, et il s'est chargé de nos maladies. (Matthieu 8:17)',
    'famille': 'Moi et ma maison, nous servirons l'Éternel. (Josué 24:15)',
    'foi': 'Ayant les regards sur Jésus, le chef et le consommateur de la foi. (Hébreux 12:2)',
    'combat': 'Revêtez-vous de toutes les armes de Dieu, afin de pouvoir tenir ferme contre les ruses du diable. (Éphésiens 6:11)',
    'paix': 'Je vous laisse la paix, je vous donne ma paix. (Jean 14:27)',
  };

  // On détermine le thème en cherchant des mots-clés
  String theme = 'foi'; // Thème par défaut
  if (lowerInput.contains('guéri') || lowerInput.contains('maladie')) {
    theme = 'guerison';
  } else if (lowerInput.contains('famille') || lowerInput.contains('enfant')) {
    theme = 'famille';
  } else if (lowerInput.contains('combat') || lowerInput.contains('peur')) {
    theme = 'combat';
  } else if (lowerInput.contains('paix') || lowerInput.contains('triste')) {
    theme = 'paix';
  }

  // On retourne la réponse correspondante
  // La signature sera gérée différemment en Flutter, on se concentre sur la réponse ici.
  return reponses[theme]!;
}
