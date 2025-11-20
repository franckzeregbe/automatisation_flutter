import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'verset_model.dart';

class BibleService {
  // Charger tous les versets du fichier JSON
  Future<List<Verset>> _loadVersets() async {
    final String response = await rootBundle.loadString('assets/bible/bible.json');
    final List<dynamic> data = json.decode(response);
    return data.map((json) => Verset.fromJson(json)).toList();
  }

  // Obtenir un verset aléatoire
  Future<Verset> getRandomVerset() async {
    List<Verset> allVersets = await _loadVersets();
    final random = Random();
    return allVersets[random.nextInt(allVersets.length)];
  }
}
