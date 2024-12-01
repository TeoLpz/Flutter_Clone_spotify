import 'package:flutter/material.dart';
import 'package:spotify/components/buttom_navbar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify/register_page.dart';
import 'package:spotify/login_page.dart';
// import 'package:spotify/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Google Login & Register',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute:
          FirebaseAuth.instance.currentUser == null ? '/login' : '/home',
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => MainScreen(),
      },
    );
  }
}
