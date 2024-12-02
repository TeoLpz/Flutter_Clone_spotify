import 'package:flutter/material.dart';
import 'package:spotify/database/db_helper.dart';
import 'form_page.dart'; // Importa la página de creación de playlists

class PlaylistListPage extends StatefulWidget {
  @override
  _PlaylistListPageState createState() => _PlaylistListPageState();
}

class _PlaylistListPageState extends State<PlaylistListPage> {
  late Future<List<Map<String, dynamic>>> _playlists;

  @override
  void initState() {
    super.initState();
    _playlists = DatabaseHelper().getPlaylists();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mis Playlists',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF121212), // Fondo oscuro de Spotify
        elevation: 0,
      ),
      body: Container(
        color: Color(0xFF121212), // Fondo oscuro típico de Spotify
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _playlists,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(color: Color(0xFF1DB954))); // Verde Spotify
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: TextStyle(color: Colors.white),
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Text(
                  'No hay playlists aún.',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              );
            } else {
              final playlists = snapshot.data!;
              return ListView.builder(
                itemCount: playlists.length,
                itemBuilder: (context, index) {
                  final playlist = playlists[index];
                  return ListTile(
                    leading: Icon(Icons.music_note, color: Color(0xFF1DB954)), // Icono verde
                    title: Text(
                      playlist['name'],
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      playlist['description'],
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    onTap: () {
                      // Acción al seleccionar una playlist (puedes agregar navegación aquí)
                    },
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF1DB954), // Verde Spotify
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          // Navegar a la página de creación de playlists
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FormPage()),
          );
        },
      ),
    );
  }
}
