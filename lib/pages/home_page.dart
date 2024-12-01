import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify/components/buttom_navbar.dart';



class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance
          .authStateChanges(), // Escucha cambios en el estado de autenticación
      builder: (context, snapshot) {
        // Si el estado de la autenticación es null (usuario no autenticado)
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
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                'https://via.placeholder.com/100',
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Canción ${index + 1}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
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
                  itemCount: 5,
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
