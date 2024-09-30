import 'package:flutter/material.dart';
import 'package:seguro/views/Catalogo/header_widget.dart';
import 'package:seguro/views/Catalogo/list_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Define your carrito list here
  final List<Map<String, dynamic>> carrito = []; // Initialize carrito as needed

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 16, 16, 16),
      body: Column(
        children: <Widget>[
          HeaderWidget(carrito: carrito), // Pass carrito to HeaderWidget
          const ListaPersonajes(),
        ],
      ),
    );
  }
}
