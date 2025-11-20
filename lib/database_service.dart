import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:automatisation_flutter/note_model.dart';
import 'package:automatisation_flutter/goal_model.dart';
import 'package:automatisation_flutter/testimony_model.dart';
import 'package:automatisation_flutter/user_model.dart'; // Importer le modèle utilisateur
import 'hymne_model.dart';
import 'enseignement_model.dart';
import 'evenement_model.dart';
import 'priere_model.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ... [méthodes existantes]
  Stream<List<Enseignement>> getEnseignements() {
    return _db.collection('enseignements').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Enseignement.fromFirestore(doc)).toList());
  }

  Stream<List<Hymne>> getHymnes() {
    return _db.collection('hymnes').orderBy('number').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Hymne.fromFirestore(doc)).toList());
  }

  Stream<List<Evenement>> getEvenements() {
    return _db.collection('evenements').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Evenement.fromFirestore(doc)).toList());
  }


  // NOTES
  Future<void> addNote(String content, String userId) {
    awardXP(userId, 5); // Récompense pour l'ajout d'une note
    return _db.collection('users').doc(userId).collection('notes').add({
      'content': content,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<List<Note>> getNotes(String userId) {
    return _db.collection('users').doc(userId).collection('notes').orderBy('timestamp', descending: true).snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Note.fromFirestore(doc)).toList());
  }

  Future<void> deleteNote(String noteId, String userId) {
    return _db.collection('users').doc(userId).collection('notes').doc(noteId).delete();
  }

  // PRIÈRES
  Stream<List<Priere>> getPrieres(String category) {
    return _db.collection('prieres').where('category', isEqualTo: category).orderBy('timestamp', descending: true).snapshots().map((snapshot) => snapshot.docs.map((doc) => Priere.fromFirestore(doc)).toList());
  }

  Future<void> addPriere(String text, String title, String category, String userId) {
     awardXP(userId, 10); // Récompense pour l'ajout d'une prière
    return _db.collection('prieres').add({
      'text': text,
      'title': title,
      'category': category,
      'amens': 0,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> incrementAmen(String priereId) {
    final docRef = _db.collection('prieres').doc(priereId);
    return _db.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);
      final newAmens = (snapshot.data()!['amens'] ?? 0) + 1;
      transaction.update(docRef, {'amens': newAmens});
    });
  }
  
  // OBJECTIFS
  Future<void> addGoal(String title, String type, int target, String userId) {
    awardXP(userId, 15); // Récompense pour la création d'un objectif
    return _db.collection('users').doc(userId).collection('goals').add({
      'title': title,
      'type': type,
      'target': target,
      'currentProgress': 0,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<List<Goal>> getGoals(String userId) {
    return _db.collection('users').doc(userId).collection('goals').orderBy('timestamp', descending: true).snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Goal.fromFirestore(doc)).toList());
  }

  Future<void> updateGoalProgress(String goalId, String userId, int newProgress, bool isCompleted) {
    if (isCompleted) {
      awardXP(userId, 25); // Récompense pour l'accomplissement d'un objectif
    }
    final docRef = _db.collection('users').doc(userId).collection('goals').doc(goalId);
    return docRef.update({'currentProgress': newProgress});
  }

  Future<void> deleteGoal(String goalId, String userId) {
    return _db.collection('users').doc(userId).collection('goals').doc(goalId).delete();
  }

  // TÉMOIGNAGES
  Future<void> addTestimony(String title, String content, String author, String authorId) {
    awardXP(authorId, 30); // Récompense pour le partage d'un témoignage
    return _db.collection('testimonies').add({
      'title': title,
      'content': content,
      'author': author,
      'authorId': authorId,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<List<Testimony>> getTestimonies() {
    return _db.collection('testimonies').orderBy('timestamp', descending: true).snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Testimony.fromFirestore(doc)).toList());
  }

  Future<void> deleteTestimony(String testimonyId) {
    return _db.collection('testimonies').doc(testimonyId).delete();
  }

  // GAMIFICATION & USER
  Stream<AppUser> getUser(String userId) {
    return _db.collection('users').doc(userId).snapshots().map((doc) => AppUser.fromFirestore(doc));
  }

  Future<void> awardXP(String userId, int amount) {
    final userRef = _db.collection('users').doc(userId);
    return _db.runTransaction((transaction) async {
      final snapshot = await transaction.get(userRef);
      if (!snapshot.exists) {
        // Si l'utilisateur n'existe pas, on le crée
        transaction.set(userRef, {'name': 'Nouvel Utilisateur', 'xp': amount});
      } else {
        final newXp = (snapshot.data()!['xp'] ?? 0) + amount;
        transaction.update(userRef, {'xp': newXp});
      }
    });
  }
}
