import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'hymne_model.dart';
import 'hymne_detail_screen.dart';
import 'database_service.dart';

class HymnesScreen extends StatefulWidget {
  const HymnesScreen({super.key});

  @override
  State<HymnesScreen> createState() => _HymnesScreenState();
}

class _HymnesScreenState extends State<HymnesScreen> {
  final DatabaseService _dbService = DatabaseService();
  late Stream<List<Hymne>> _hymnesStream;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _hymnesStream = _dbService.getHymnes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F2B4E),
      appBar: AppBar(
        title: const Text('Hymnes et Louanges'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Rechercher par titre ou numéro...',
                hintStyle: const TextStyle(color: Colors.white54),
                prefixIcon: const Icon(Icons.search, color: Colors.white54),
                filled: true,
                fillColor: const Color(0xFF2C3A5B),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Hymne>>(
              stream: _hymnesStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(child: Text('Une erreur est survenue', style: TextStyle(color: Colors.white)));
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Aucun hymne trouvé', style: TextStyle(color: Colors.white)));
                }

                final filteredHymnes = snapshot.data!.where((hymne) {
                  final titleLower = hymne.title.toLowerCase();
                  final numberString = hymne.number.toString();
                  return titleLower.contains(_searchQuery) || numberString.contains(_searchQuery);
                }).toList();

                if (filteredHymnes.isEmpty) {
                    return const Center(child: Text('Aucun résultat pour cette recherche', style: TextStyle(color: Colors.white)));
                }

                return AnimationLimiter(
                  child: ListView.builder(
                    itemCount: filteredHymnes.length,
                    itemBuilder: (context, index) {
                      final hymne = filteredHymnes[index];
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: Card(
                              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                              color: const Color(0xFF2C3A5B),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: const Color(0xFF1F2B4E),
                                  child: Text('${hymne.number}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                ),
                                title: Text(hymne.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 16),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HymneDetailScreen(hymne: hymne),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
