import 'package:flutter/material.dart';

class Informacion extends StatefulWidget {
  const Informacion({super.key});

  @override
  State<Informacion> createState() => _InformacionState();
}

class _InformacionState extends State<Informacion> {
  final List<Map<String, String>> sucursales = [
    {
      "nombre": "Sucursal Centro",
      "direccion": "Av. Libertador, #123",
      "horario": "Lunes a Viernes: 9:00 - 18:00"
    },
    {
      "nombre": "Sucursal Norte",
      "direccion": "Calle 45, #456",
      "horario": "Lunes a Sábado: 10:00 - 19:00"
    },
    {
      "nombre": "Sucursal Sur",
      "direccion": "Av. del Sur, #789",
      "horario": "Martes a Domingo: 10:00 - 20:00"
    },
    // Agrega más sucursales según sea necesario
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Ubicaciones y Horarios",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Color del texto
          ),
        ),
        backgroundColor: Colors.black, // Fondo negro para la AppBar
      ),
      body: Container(
        color: Colors.black, // Fondo negro para el cuerpo
        child: ListView.builder(
          itemCount: sucursales.length,
          itemBuilder: (context, index) {
            final sucursal = sucursales[index];
            return Card(
              margin: const EdgeInsets.all(10),
              color: const Color.fromARGB(
                  255, 50, 50, 50), // Fondo gris oscuro para la tarjeta
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sucursal["nombre"]!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Texto en blanco
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Dirección: ${sucursal["direccion"]}",
                      style: const TextStyle(
                        color: Colors.white, // Texto en blanco
                      ),
                    ),
                    Text(
                      "Horario: ${sucursal["horario"]}",
                      style: const TextStyle(
                        color: Colors.white, // Texto en blanco
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
