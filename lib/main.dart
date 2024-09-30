import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:seguro/views/menu/home.dart'; // Asegúrate de importar tu archivo de Home
import 'package:seguro/views/Login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Login(),
      routes: {
        Login.routename: (context) => const Login(),
        '/home': (context) =>
            const Home(), // Define la ruta para la página de inicio
      },
    );
  }
}
