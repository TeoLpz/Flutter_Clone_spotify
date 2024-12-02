import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify/components/buttom_navbar.dart';

class HomePage extends StatelessWidget {
  // Lista de imágenes para canciones y playlists
  final List<String> songImages = [
    'assets/huesped.jpg',
    'assets/song1.jpg',
    'assets/song2.jpg',
    'assets/song3.jpg',
    'assets/song4.jpg',
    'assets/song5.jpg',
    'assets/song6.jpg',
    'assets/song7.jpg',
    'assets/song8.jpg',
    'assets/song9.jpg',
  ];

  final List<String> playlistImages = [
    'assets/playlist1.jpg',
    'assets/playlist2.jpg',
    'assets/playlist3.jpg',
    'assets/playlist4.jpg',
    'assets/playlist5.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            body: Center(
              child: Text(
                'No user is logged in.',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            elevation: 0,
            title: const Text(
              'Inicio',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushReplacementNamed('/login');
                },
              ),
            ],
          ),
          backgroundColor: Colors.black,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Recently Played Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: const Text(
                    'Reproducidos recientemente',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: songImages.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                songImages[index],
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Canción ${index + 1}',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 14),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                // Popular Playlists Section
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: const Text(
                    'Playlists populares',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: playlistImages.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          playlistImages[index],
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        'Playlist ${index + 1}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: const Text(
                        'Descripción breve',
                        style: TextStyle(color: Colors.grey),
                      ),
                      onTap: () {
                        // Navigate to playlist details
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
