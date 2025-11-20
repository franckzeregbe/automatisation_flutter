import 'package:flutter/material.dart';
import 'bible_service.dart';
import 'verset_model.dart';

class VersetBibliqueScreen extends StatefulWidget {
  const VersetBibliqueScreen({super.key});

  @override
  State<VersetBibliqueScreen> createState() => _VersetBibliqueScreenState();
}

class _VersetBibliqueScreenState extends State<VersetBibliqueScreen> {
  final BibleService _bibleService = BibleService();
  Verset? _verset;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchVerset();
  }

  Future<void> _fetchVerset() async {
    setState(() {
      _isLoading = true;
    });
    final verset = await _bibleService.getRandomVerset();
    setState(() {
      _verset = verset;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F2B4E),
      appBar: AppBar(
        title: const Text('Verset du Jour'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // La carte contenant le verset
            Card(
              color: const Color(0xFF2C3A5B),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              elevation: 5,
              child: AnimatedSize(
                duration: const Duration(milliseconds: 300),
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : _verset == null
                          ? const Text('Impossible de charger le verset.', style: TextStyle(color: Colors.white, fontSize: 18))
                          : Column(
                              children: [
                                Text(
                                  '"${_verset!.text}"',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 20, color: Colors.white, fontStyle: FontStyle.italic, height: 1.5),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  '${_verset!.book} ${_verset!.chapter}:${_verset!.verse}',
                                  style: const TextStyle(fontSize: 16, color: Colors.pinkAccent, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            // Le bouton pour rafraîchir
            ElevatedButton.icon(
              onPressed: _fetchVerset,
              icon: const Icon(Icons.refresh),
              label: const Text('Nouveau Verset'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
