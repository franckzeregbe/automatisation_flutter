import 'package:flutter/material.dart';
import 'dart:async';

// 1. Structure de données pour une question
class Question {
  final String questionText;
  final List<String> answers;
  final int correctAnswerIndex;

  Question(this.questionText, this.answers, this.correctAnswerIndex);
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  // 2. Liste de questions enrichie
  final List<Question> _questions = [
    Question(
      "Qui a construit l'arche pour survivre au Déluge ?",
      ["Moïse", "Noé", "Abraham", "David"],
      1, // Noé est la bonne réponse
    ),
    Question(
      "Qui a été jeté dans la fosse aux lions ?",
      ["Daniel", "Jonas", "Paul", "Joseph"],
      0, // Daniel est la bonne réponse
    ),
    Question(
      "Combien de plaies Dieu a-t-il envoyées sur l'Égypte ?",
      ["7", "12", "10", "5"],
      2, // 10 est la bonne réponse
    ),
    Question(
      "Quel prophète a été avalé par un grand poisson ?",
      ["Élie", "Jérémie", "Ésaïe", "Jonas"],
      3, // Jonas est la bonne réponse
    ),
    Question(
      "De quel arbre Adam et Ève ont-ils mangé le fruit défendu ?",
      ["L'arbre de Vie", "Le Figuier", "L'arbre de la connaissance du bien et du mal", "Le Chêne"],
      2, 
    ),
    Question(
      "Qui était le premier roi d'Israël ?",
      ["David", "Saül", "Salomon", "Samuel"],
      1, 
    ),
    Question(
      "Comment s'appelait la femme de Moïse ?",
      ["Rachel", "Léa", "Séphora", "Rebecca"],
      2,
    ),
    Question(
      "Lequel de ces hommes n'était pas l'un des douze apôtres originaux ?",
      ["Pierre", "Jean", "Matthieu", "Paul"],
      3, 
    ),
  ];

  int _currentQuestionIndex = 0;
  int? _selectedAnswerIndex;
  bool _isAnswered = false;

  void _handleAnswer(int index) {
    if (_isAnswered) return; // Empêche de changer de réponse

    setState(() {
      _selectedAnswerIndex = index;
      _isAnswered = true;
    });

    // Passe à la question suivante après un court délai
    Timer(const Duration(seconds: 2), _nextQuestion);
  }

  void _nextQuestion() {
    setState(() {
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
      } else {
        // Recommence le quiz à la fin
        _currentQuestionIndex = 0;
      }
      _selectedAnswerIndex = null;
      _isAnswered = false;
    });
  }

  Color _getAnswerColor(int index) {
    if (!_isAnswered) {
      return Colors.white.withOpacity(0.1); // Couleur par défaut
    }
    if (index == _questions[_currentQuestionIndex].correctAnswerIndex) {
      return Colors.green.withOpacity(0.5); // Bonne réponse
    }
    if (index == _selectedAnswerIndex) {
      return Colors.red.withOpacity(0.5); // Mauvaise réponse choisie
    }
    return Colors.white.withOpacity(0.1);
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = _questions[_currentQuestionIndex];

    return Scaffold(
      backgroundColor: const Color(0xFF1F2B4E),
      appBar: AppBar(
        title: const Text('Quiz Biblique'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // La question
            Text(
              currentQuestion.questionText,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),

            // Les réponses
            ...List.generate(currentQuestion.answers.length, (index) {
              return InkWell(
                onTap: () => _handleAnswer(index),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: _getAnswerColor(index),
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                  ),
                  child: Text(
                    currentQuestion.answers[index],
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
