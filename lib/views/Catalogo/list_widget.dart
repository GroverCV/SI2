import 'package:flutter/material.dart';
import 'package:seguro/views/Carrito.dart';
import 'package:seguro/views/RealidadAumentada/Camara.dart';

class ListaPersonajes extends StatefulWidget {
  const ListaPersonajes({super.key});

  @override
  State<ListaPersonajes> createState() => _ListaPersonajesState();
}

class _ListaPersonajesState extends State<ListaPersonajes> {
  final TextStyle tituloStyletext = const TextStyle(
      fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white);

  double widthpantalla = 0;
  String selectedSize = 'P'; // Variable para la talla seleccionada
  Color selectedColor = Colors.black;
  int cantidad = 1; // Mueve la cantidad aquí para gestionarla con setState

  List<Map<String, dynamic>> carrito = []; // Lista para almacenar los productos

  @override
  Widget build(BuildContext context) {
    widthpantalla = MediaQuery.of(context).size.width - 50;
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.all(25),
        children: [
          Text(
            "CATALOGO",
            style: tituloStyletext,
          ),
          const SizedBox(height: 15),
          Wrap(
            spacing: widthpantalla * 0.03,
            runSpacing: widthpantalla * 0.03,
            children: [
              bloquesPortada("poleranegra.jpg", "POLERA ", 50, " Bs"),
              bloquesPortada("pantalon.png", "PANTALON ", 100, " Bs"),
              bloquesPortada("polo.jpg", "POLO ", 80, " Bs"),
              bloquesPortada("zapatos.jpg", "ZAPATOS ", 150, " Bs"),
            ],
          ),
        ],
      ),
    );
  }

  Widget bloquesPortada(
      String image, String titulo, double precio, String valor) {
    return GestureDetector(
      onTap: () => mostrarImagenAmpliada(image, titulo, precio, valor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, // Centrar el contenido
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.asset(
              "assets/$image",
              width: widthpantalla * 0.31,
              height: 110,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            titulo,
            style:
                const TextStyle(color: Colors.white70, fontSize: 14), // Título
          ),
          const SizedBox(height: 5), // Espaciado entre título y precio
          RichText(
            text: TextSpan(
              text: precio.toString(), // Mostrar el precio
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w300,
                fontSize: 12,
              ),
              children: [
                TextSpan(
                  text: ' $valor', // Mostrar el valor (ej. Bs)
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w300,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void mostrarImagenAmpliada(
      String image, String titulo, double precio, String valor) {
    setState(() {
      cantidad = 1; // Restablece la cantidad a 1 cada vez que se abre el modal
    });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.asset("assets/$image", fit: BoxFit.cover),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      titulo,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  Text(
                    '$precio $valor', // Mostrar el precio y su valor
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'Cantidades Disponibles: 10',
                style: const TextStyle(color: Colors.white, fontSize: 14),
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _tallaSelector(), // Selector de talla
                  _colorSelector(), // Selector de color
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _cantidadSelector(), // Selector de cantidad
                  _iconoCamara(), // Ícono de cámara
                  _botonCarrito(
                      image, titulo, precio, cantidad), // Botón de carrito
                ],
              ),
              const SizedBox(height: 10),
              _descripcionAdicional(), // Descripción adicional
            ],
          ),
        ),
      ),
    );
  }

  Widget _tallaSelector() {
    return Column(
      children: [
        DropdownButton<String>(
          value: selectedSize,
          icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
          dropdownColor: const Color.fromARGB(255, 40, 40, 40),
          style: const TextStyle(color: Colors.white),
          items: <String>['P', 'S', 'M', 'L', 'XL']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedSize = newValue!;
            });
          },
        ),
        const SizedBox(height: 5),
        const Text('Talla', style: TextStyle(color: Colors.white)),
      ],
    );
  }

  Widget _colorSelector() {
    return Column(
      children: [
        DropdownButton<Color>(
          value: selectedColor,
          icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
          dropdownColor: const Color.fromARGB(255, 40, 40, 40),
          style: const TextStyle(color: Colors.white),
          items: <Color>[
            Colors.red,
            Colors.blue,
            Colors.green,
            Colors.black,
            Colors.yellow,
          ].map<DropdownMenuItem<Color>>((Color color) {
            return DropdownMenuItem<Color>(
              value: color,
              child: Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    color: color,
                  ),
                  const SizedBox(width: 10),
                  Text(colorToString(color)),
                ],
              ),
            );
          }).toList(),
          onChanged: (Color? newValue) {
            setState(() {
              selectedColor = newValue!;
            });
          },
        ),
        const SizedBox(height: 5),
        const Text('Color', style: TextStyle(color: Colors.white)),
      ],
    );
  }

  String colorToString(Color color) {
    if (color == Colors.red) return 'Rojo';
    if (color == Colors.blue) return 'Azul';
    if (color == Colors.green) return 'Verde';
    if (color == Colors.black) return 'Negro';
    if (color == Colors.yellow) return 'Amarillo';
    return 'Color desconocido';
  }

  Widget _cantidadSelector() {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.remove, color: Colors.white),
              onPressed: () {
                setState(() {
                  if (cantidad > 1) {
                    cantidad--; // Disminuye la cantidad, mínimo 1
                  }
                });
              },
            ),
            Text(
              '$cantidad',
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
            IconButton(
              icon: const Icon(Icons.add, color: Colors.white),
              onPressed: () {
                setState(() {
                  if (cantidad < 10) {
                    cantidad++; // Aumenta la cantidad, máximo 10
                  }
                });
              },
            ),
          ],
        ),
        const Text('Cantidad', style: TextStyle(color: Colors.white)),
      ],
    );
  }

  Widget _iconoCamara() {
    return Column(
      children: [
        IconButton(
          icon: const Icon(Icons.camera_alt, color: Colors.white),
          onPressed: () {
            // Navega a la página de la cámara
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CameraExample()), // Cambia aquí
            );
          },
        ),
        const SizedBox(height: 5), // Espaciado entre el ícono y el texto
        const Text(
          'Cámara',
          style: TextStyle(color: Colors.white), // Color del texto
        ),
      ],
    );
  }

  Widget _botonCarrito(
      String image, String titulo, double precio, int cantidad) {
    return Column(
      children: [
        IconButton(
          icon: const Icon(Icons.add_shopping_cart, color: Colors.white),
          onPressed: () {
            // Acción para agregar al carrito
            agregarAlCarrito(image, titulo, precio, cantidad);
          },
        ),
        const Text('Añadir al carrito', style: TextStyle(color: Colors.white)),
      ],
    );
  }

  void agregarAlCarrito(
      String image, String titulo, double precio, int cantidad) {
    setState(() {
      carrito.add({
        'imagen': image,
        'titulo': titulo,
        'precio': precio,
        'talla': selectedSize,
        'color': colorToString(selectedColor),
        'cantidad': cantidad,
      });
    });

    // Navegar a la pantalla del carrito y pasar la lista de productos
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Carrito(carrito: carrito)),
    );
  }

  Widget _descripcionAdicional() {
    return const Text(
      'Descripción adicional del producto...',
      style: TextStyle(color: Colors.grey),
      textAlign: TextAlign.center,
    );
  }

  void eliminarDelCarrito(int index) {
    carrito.removeAt(index);
  }
}
