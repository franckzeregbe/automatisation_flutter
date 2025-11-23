
import 'package:flutter/material.dart';
import 'home_screen.dart'; // Sera utilisé après une connexion réussie

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Contrôleurs pour récupérer le texte des champs
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Connexion'),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Champ pour l'e-mail
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Adresse e-mail',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 16),
            // Champ pour le mot de passe
            TextField(
              controller: passwordController,
              obscureText: true, // Masque le mot de passe
              decoration: const InputDecoration(
                labelText: 'Mot de passe',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 24),
            // Bouton de connexion
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () {
                // Logique de connexion à implémenter ici
                // Pour l'instant, naviguons directement vers la page d'accueil
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                );
              },
              child: const Text('Se connecter'),
            ),
            const SizedBox(height: 16),
            // Bouton pour s'inscrire
            TextButton(
              onPressed: () {
                // Logique pour naviguer vers un écran d'inscription (à créer)
              },
              child: const Text('Pas encore de compte ? S\'inscrire'),
            ),
          ],
        ),
      ),
    );
  }
}
