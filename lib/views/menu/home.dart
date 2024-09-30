import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:seguro/views/Contacto.dart';
import 'package:seguro/views/Informacion.dart';
import 'package:seguro/views/Login.dart';
import 'package:seguro/views/Promocion.dart';
import 'package:seguro/views/home_inicio.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const Home_Inicio(),
    const Promocion(),
    const Contacto(),
    const Informacion(), // Cambiado el orden aquí
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 94, 164, 202),
          title: const Text('CERRAR SESION'),
          actions: [
            IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.popAndPushNamed(context, Login.routename);
              },
              icon: const Icon(Icons.logout),
            )
          ],
          centerTitle: true,
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        body: Container(
          color: const Color.fromARGB(255, 40, 40, 40), // Color negro más claro
          child: _pages[_currentIndex],
        ),
        bottomNavigationBar: Container(
          color: Colors.black, // Fondo negro para el BottomNavigationBar
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavButton(Icons.home, 'Inicio', 0),
              _buildNavButton(Icons.book_outlined, 'Promocion',
                  1), // Cambiado el orden aquí
              _buildNavButton(
                  Icons.person, 'Contacto', 2), // Cambiado el orden aquí
              _buildNavButton(
                  Icons.history, 'Informacion', 3), // Cambiado el orden aquí
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavButton(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: _currentIndex == index
              ? Colors.blue
              : Colors.black, // Color del botón seleccionado
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: _currentIndex == index
                ? Colors.blue
                : Colors.transparent, // Borde azul para el ítem seleccionado
            width: 2,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: _currentIndex == index
                  ? Colors.white
                  : Colors.grey, // Color del ícono
            ),
            const SizedBox(height: 5),
            Text(
              label,
              style: TextStyle(
                color: _currentIndex == index
                    ? Colors.white
                    : Colors.grey, // Color del texto
              ),
            ),
          ],
        ),
      ),
    );
  }
}
