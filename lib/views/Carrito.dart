import 'package:flutter/material.dart';

class Carrito extends StatefulWidget {
  final List<Map<String, dynamic>> carrito;

  const Carrito({super.key, required this.carrito});

  @override
  _CarritoState createState() => _CarritoState();
}

class _CarritoState extends State<Carrito> {
  late List<Map<String, dynamic>> carrito;
  List<bool> checkedItems = [];

  @override
  void initState() {
    super.initState();
    carrito = List<Map<String, dynamic>>.from(
        widget.carrito); // Crea una copia de la lista
    checkedItems = List<bool>.filled(carrito.length, false);
  }

  void eliminarProducto(int index) {
    setState(() {
      carrito.removeAt(index);
      checkedItems.removeAt(index); // También eliminamos el estado del Checkbox
    });
  }

  void mostrarCompra() {
    List<Map<String, dynamic>> productosSeleccionados = [];
    double total = 0;

    // Recoger productos seleccionados y calcular total
    for (int i = 0; i < carrito.length; i++) {
      if (checkedItems[i]) {
        productosSeleccionados.add(carrito[i]);
        total += carrito[i]['precio'] *
            carrito[i][
                'cantidad']; // Asegúrate de que 'precio' y 'cantidad' sean números
      }
    }

    // Mostrar diálogo con los productos seleccionados y el total
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Productos Seleccionados'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...productosSeleccionados.map((producto) {
                return Text(
                    '${producto['titulo']} - \$${producto['precio']} x ${producto['cantidad']}');
              }).toList(),
              Divider(),
              Text('Total: \$${total.toStringAsFixed(2)}'),
            ],
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrito de Compras'),
      ),
      body: carrito.isEmpty
          ? Center(child: Text('El carrito está vacío'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: carrito.length,
                    itemBuilder: (context, index) {
                      final producto = carrito[index];
                      return ListTile(
                        leading: Image.asset(
                          'assets/${producto['imagen']}',
                          width: 50,
                          height: 50,
                        ),
                        title: Text(producto['titulo']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Cantidad: ${producto['cantidad']}'),
                            Text('Talla: ${producto['talla']}',
                                style: TextStyle(color: Colors.grey)),
                            Text('Color: ${producto['color']}',
                                style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                              value: checkedItems[index],
                              onChanged: (bool? value) {
                                setState(() {
                                  checkedItems[index] = value ?? false;
                                });
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                eliminarProducto(index);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text('${producto['titulo']} eliminado'),
                                  ),
                                );
                              },
                            ),
                            Text('\$${producto['precio']}'),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: mostrarCompra,
                  child: const Text('Comprar'),
                ),
              ],
            ),
    );
  }
}
