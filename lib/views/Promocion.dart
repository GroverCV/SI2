import 'package:flutter/material.dart';

class Promocion extends StatefulWidget {
  const Promocion({super.key});

  @override
  _PromocionState createState() => _PromocionState();
}

class _PromocionState extends State<Promocion> {
  final List<Map<String, dynamic>> carrito = []; // Carrito de compras

  @override
  Widget build(BuildContext context) {
    // Lista de productos para las promociones
    final List<Map<String, dynamic>> promocion = [
      {
        'imagen': 'poleranegra.jpg',
        'titulo': 'POLERA',
        'precio': 50.0,
        'valor': 'Bs',
        'descuento': '20%', // Agregado: Descuento
      },
      {
        'imagen': 'pantalon.png',
        'titulo': 'PANTALON',
        'precio': 100.0,
        'valor': 'Bs',
        'descuento': '15%', // Agregado: Descuento
      },
      {
        'imagen': 'polo.jpg',
        'titulo': 'POLO',
        'precio': 80.0,
        'valor': 'Bs',
        'descuento': '10%', // Agregado: Descuento
      },
      {
        'imagen': 'zapatos.jpg',
        'titulo': 'ZAPATOS',
        'precio': 150.0,
        'valor': 'Bs',
        'descuento': '25%', // Agregado: Descuento
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PROMOCIÓN',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true, // Centrar el título
      ),
      body: ListView(
        padding: const EdgeInsets.all(25),
        children: [
          const SizedBox(height: 15),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: promocion.map((promocion) {
              return _bloquePromocion(
                promocion['imagen'],
                promocion['titulo'],
                promocion['precio'],
                promocion['valor'],
                promocion['descuento'], // Agregado: Descuento
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _bloquePromocion(String image, String titulo, double precio,
      String valor, String descuento) {
    // Calcular el precio con descuento
    double descuentoPorcentaje =
        double.parse(descuento.replaceAll('%', '')) / 100;
    double precioConDescuento = precio * (1 - descuentoPorcentaje);

    return GestureDetector(
      onTap: () {
        // Añadir producto al carrito y mostrar el carrito
        _agregarAlCarrito(titulo, precioConDescuento, valor);
        _mostrarCarrito(); // Mostrar el carrito inmediatamente después de agregar
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.asset(
                  "assets/$image",
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              // Texto del descuento
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    descuento,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            titulo,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          // Mostrar precio original tachado y precio con descuento
          Text(
            '$precio $valor',
            style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
                decoration: TextDecoration.lineThrough),
          ),
          Text(
            '${precioConDescuento.toStringAsFixed(2)} $valor', // Mostrar nuevo precio
            style: const TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  void _agregarAlCarrito(
      String titulo, double precioConDescuento, String valor) {
    setState(() {
      carrito.add({
        'titulo': titulo,
        'precio': precioConDescuento,
        'valor': valor,
      });
    });
    // Notificación al usuario (puedes usar un SnackBar o un diálogo)
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
          '$titulo agregado al carrito por ${precioConDescuento.toStringAsFixed(2)} $valor'),
      duration: const Duration(seconds: 2),
    ));
  }

  void _mostrarCarrito() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Carrito de Compras'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: carrito.length,
              itemBuilder: (context, index) {
                final item = carrito[index];
                return ListTile(
                  title: Text(item['titulo']),
                  subtitle: Text(
                      '${item['precio'].toStringAsFixed(2)} ${item['valor']}'),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}
