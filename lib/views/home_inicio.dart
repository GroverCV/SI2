import 'package:flutter/material.dart';
import 'package:seguro/views/home_page.dart';

class Home_Inicio extends StatefulWidget {
  const Home_Inicio({super.key});

  @override
  State<Home_Inicio> createState() => _Home_InicioState();
}

class _Home_InicioState extends State<Home_Inicio> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(child: Home()),
      ),
    );
  }
}
