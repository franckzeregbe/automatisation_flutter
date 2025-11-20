import 'package:flutter/material.dart';
import 'home_screen.dart';

// 1. Importer Firebase Core
import 'package:firebase_core/firebase_core.dart';
// IMPORTANT : Ce fichier sera généré par la CLI de FlutterFire
import 'firebase_options.dart';

// 2. Transformer main() en fonction asynchrone
void main() async {
  // 3. Assurer l'initialisation des widgets avant toute autre chose
  WidgetsFlutterBinding.ensureInitialized();
  
  // 4. Initialiser Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Religieuse',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // Définir une police par défaut si nécessaire
        // fontFamily: 'VotrePolice',
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false, // Cache la bannière de debug
    );
  }
}
