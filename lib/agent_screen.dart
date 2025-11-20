import 'package:flutter/material.dart';
import 'agent_logic.dart';

class AgentScreen extends StatefulWidget {
  const AgentScreen({super.key});

  @override
  State<AgentScreen> createState() => _AgentScreenState();
}

class _AgentScreenState extends State<AgentScreen> {
  // Contrôleur pour récupérer le texte de l'utilisateur
  final _textController = TextEditingController();
  // Variable pour stocker la réponse à afficher
  String _reponse = 'Posez une question sur un thème (guérison, famille, foi, combat, paix) et recevez un verset.';

  void _chercherReponse() {
    // Si le champ de texte n'est pas vide
    if (_textController.text.isNotEmpty) {
      // On appelle la logique importée
      final reponseTrouvee = getReponseSpirituelle(_textController.text);
      // On met à jour l'état pour rafraîchir l'interface avec la nouvelle réponse
      setState(() {
        _reponse = reponseTrouvee;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // On utilise le même fond que la page d'accueil
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Barre de navigation supérieure avec un bouton retour
              AppBar(
                title: const Text('Agent Spirituel'),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Zone d'affichage de la réponse
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Text(
                          _reponse,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.white, fontSize: 18.0, fontStyle: FontStyle.italic),
                        ),
                      ),
                      const SizedBox(height: 30),
                      // Champ de saisie pour l'utilisateur
                      TextField(
                        controller: _textController,
                        decoration: InputDecoration(
                          hintText: 'Posez votre question ici...',
                          hintStyle: TextStyle(color: Colors.white70),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 20),
                      // Bouton pour envoyer la question
                      ElevatedButton(
                        onPressed: _chercherReponse,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF2575FC),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                        ),
                        child: const Text('Recevoir la parole', style: TextStyle(fontSize: 16)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
