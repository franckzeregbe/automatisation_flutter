import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:blessing/goal_model.dart';
import 'database_service.dart';

// Pour un ID utilisateur factice. À remplacer par une vraie authentification.
const String FAKE_USER_ID = '12345';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key});

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  final DatabaseService _dbService = DatabaseService();

  void _showAddGoalDialog() {
    final TextEditingController titleController = TextEditingController();
    String selectedType = 'daily';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2C3A5B),
          title: const Text('Nouvel Objectif', style: TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Titre de l\'objectif',
                  labelStyle: TextStyle(color: Colors.white70),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.pinkAccent)),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
                ),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                initialValue: selectedType,
                dropdownColor: const Color(0xFF2C3A5B),
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                   labelText: 'Type d\'objectif',
                   labelStyle: TextStyle(color: Colors.white70),
                   focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.pinkAccent)),
                   enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
                ),
                items: const [
                  DropdownMenuItem(value: 'daily', child: Text('Quotidien')),
                  DropdownMenuItem(value: 'weekly', child: Text('Hebdomadaire')),
                  DropdownMenuItem(value: 'monthly', child: Text('Mensuel')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    selectedType = value;
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Annuler', style: TextStyle(color: Colors.white70)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
              child: const Text('Ajouter', style: TextStyle(color: Colors.white)),
              onPressed: () {
                if (titleController.text.trim().isNotEmpty) {
                  int target = 1;
                  if (selectedType == 'weekly') target = 7;
                  if (selectedType == 'monthly') target = 30;
                  _dbService.addGoal(titleController.text.trim(), selectedType, target, FAKE_USER_ID);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F2B4E),
      appBar: AppBar(
        title: const Text('Mes Objectifs'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, size: 30),
            onPressed: _showAddGoalDialog,
          ),
        ],
      ),
      body: StreamBuilder<List<Goal>>(
        stream: _dbService.getGoals(FAKE_USER_ID),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'Aucun objectif défini.\nCliquez sur le \'+\' pour en ajouter un.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
            );
          }

          var goals = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(15),
            itemCount: goals.length,
            itemBuilder: (context, index) {
              final goal = goals[index];
              double progress = (goal.currentProgress / goal.target).clamp(0.0, 1.0);

              return Card(
                color: const Color(0xFF2C3A5B),
                margin: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(goal.title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.redAccent, size: 24),
                            onPressed: () => _dbService.deleteGoal(goal.id, FAKE_USER_ID),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.white24,
                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.pinkAccent),
                        minHeight: 8,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${goal.currentProgress} / ${goal.target}', style: const TextStyle(color: Colors.white70, fontSize: 14)),
                          ElevatedButton(
                            onPressed: () {
                              if (goal.currentProgress < goal.target) {
                                _dbService.updateGoalProgress(goal.id, FAKE_USER_ID, goal.currentProgress + 1, goal.currentProgress + 1 >= goal.target);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            ),
                            child: const Text('✓ Fait', style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
