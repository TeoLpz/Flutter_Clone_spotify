import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
  ],
);

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  User? _currentUser;

  // Google Sign-In
  Future<void> _handleGoogleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return; // El usuario canceló el login

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Iniciar sesión con el token de Google
      await FirebaseAuth.instance.signInWithCredential(credential);

      setState(() {
        _currentUser = FirebaseAuth.instance.currentUser;
      });

      // Navegar a la pantalla principal después de iniciar sesión
      Navigator.of(context).pushReplacementNamed('/home');
    } catch (e) {
      print("Error al iniciar sesión con Google: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al iniciar sesión con Google: $e')),
      );
    }
  }

  // Login con correo y contraseña
  Future<void> _loginWithEmail() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      Navigator.of(context).pushReplacementNamed('/home');
    } catch (e) {
      print("Error al iniciar sesión: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al iniciar sesión: $e')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _currentUser = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF000000),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/assets/logo.png', // Ruta de la imagen en tu carpeta de assets
              width: 100, // Ancho opcional
              height: 100, // Alto opcional
            ),
            const Text(
              'Bienvenido de nuevo a Spotify',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[800],
                labelText: 'Correo electrónico',
                labelStyle: const TextStyle(color: Colors.white),
                hintText: 'Ingresa tu correo',
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[800],
                labelText: 'Contraseña',
                labelStyle: const TextStyle(color: Colors.white),
                hintText: 'Ingresa tu contraseña',
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loginWithEmail,
              child: const Text(
                'Iniciar sesión',
                style: TextStyle(color: Color(0xFFfaf6f9)),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1DB954), // Verde de Spotify
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/register');
              },
              child: const Text(
                '¿No tienes cuenta? Regístrate',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: _handleGoogleSignIn,
              icon: Image.asset(
                'lib/assets/google_icon.png', // Ruta de tu imagen
                width: 25, // Ajusta el ancho de la imagen
                height: 25, // Ajusta la altura de la imagen
              ),
              label: const Text('Iniciar sesión con Google',
                  style: TextStyle(color: Color(0xFFfaf6f9))),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: const BorderSide(color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
