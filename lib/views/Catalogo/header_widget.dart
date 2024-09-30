import 'package:flutter/material.dart';
import 'package:seguro/views/Carrito.dart';

class HeaderWidget extends StatelessWidget {
  final List<Map<String, dynamic>> carrito; // Lista para el carrito

  const HeaderWidget({super.key, required this.carrito});

  final tituloTextStyle = const TextStyle(
      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 26);

  final subtituloTextStyle = const TextStyle(color: Colors.white, fontSize: 17);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.all(25.0),
      height: 120.0,
      decoration: BoxDecoration(color: const Color.fromARGB(255, 41, 40, 39)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("NOBLEVE", style: tituloTextStyle),
              Text("TIENDA", style: subtituloTextStyle),
            ],
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Buscar...",
                  hintStyle: const TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                  prefixIcon: const Icon(Icons.search, color: Colors.white),
                ),
                onSubmitted: (value) {
                  print("Buscando: $value");
                },
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: IconButton(
              tooltip: 'Carrito de Compras',
              onPressed: () {
                // Navegar a la pantalla del carrito
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Carrito(carrito: carrito),
                  ),
                );
              },
              icon: const Icon(
                Icons.shopping_cart,
                size: 28,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
