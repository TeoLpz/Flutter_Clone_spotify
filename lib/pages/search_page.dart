import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String searchQuery = '';
  List<String> allResults = [
    'Pop Hits',
    'Rock Classics',
    'Chill Vibes',
    'Jazz Essentials',
    'Hip-Hop Beats',
    'Workout Mix',
    'Top 50 Global',
    'Indie Anthems',
    'Acoustic Sessions',
    'Party Playlist'
  ];
  List<String> filteredResults = [];

  @override
  void initState() {
    super.initState();
    filteredResults = allResults; // Mostrar todos los resultados inicialmente
  }

  void updateSearchResults(String query) {
    setState(() {
      searchQuery = query;
      filteredResults = allResults
          .where((result) => result
              .toLowerCase()
              .contains(query.toLowerCase())) // Filtrar resultados
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'Buscar',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Campo de búsqueda
            TextField(
              onChanged: updateSearchResults,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: '¿Qué quieres escuchar?',
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[900],
                prefixIcon: const Icon(Icons.search, color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Lista de resultados de búsqueda
            Expanded(
              child: filteredResults.isEmpty
                  ? const Center(
                      child: Text(
                        'No se encontraron resultados',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredResults.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              'https://via.placeholder.com/50',
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            filteredResults[index],
                            style: const TextStyle(color: Colors.white),
                          ),
                          onTap: () {
                            // Acción al seleccionar un resultado
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
