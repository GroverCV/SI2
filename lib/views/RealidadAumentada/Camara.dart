import 'dart:io'; // Asegúrate de importar esto para usar File

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraExample extends StatefulWidget {
  @override
  _CameraExampleState createState() => _CameraExampleState();
}

class _CameraExampleState extends State<CameraExample> {
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  double _scale = 0.75; // Escala inicial ajustada a 0.75
  double _previousScale = 0.75; // Escala anterior ajustada a 0.75

  Future<void> openCamera() async {
    try {
      // Abre la cámara directamente
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera, // Asegúrate de usar la cámara
        imageQuality: 100,
      );

      if (image != null) {
        setState(() {
          _imageFile = image; // Guarda la imagen capturada
          _scale = 0.75; // Reinicia la escala al capturar una nueva imagen
          _previousScale = 0.75; // Reinicia la escala anterior
        });
      }
    } catch (e) {
      print("Error al abrir la cámara: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cámara")),
      body: SingleChildScrollView(
        // Permite desplazar el contenido
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize
                .min, // Permite que el Column tome solo el espacio necesario
            children: [
              ElevatedButton(
                onPressed:
                    openCamera, // Llama a la función para abrir la cámara
                child: Text("Abrir Cámara"),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.blue, // Cambia el color de fondo del botón
                  foregroundColor: Colors.white, // Cambia el color del texto
                  padding: EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10), // Espaciado interno
                  textStyle:
                      TextStyle(fontSize: 16), // Cambia el tamaño del texto
                ),
              ),
              SizedBox(height: 20), // Espaciado entre el botón y la imagen
              _imageFile == null
                  ? Text("No hay imagen capturada.")
                  : GestureDetector(
                      onScaleStart: (details) {
                        _previousScale = _scale; // Guarda la escala anterior
                      },
                      onScaleUpdate: (details) {
                        setState(() {
                          _scale = _previousScale *
                              details.scale; // Actualiza la escala
                        });
                      },
                      child: Transform.scale(
                        scale: _scale, // Usa la escala actual
                        child: Image.file(
                          File(_imageFile!.path),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget para el ícono de la cámara
Widget _iconoCamara(BuildContext context) {
  return Column(
    children: [
      IconButton(
        icon: const Icon(Icons.camera_alt, color: Colors.white),
        onPressed: () {
          // Al presionar el ícono, abre la cámara directamente
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CameraExample()),
          );
        },
      ),
      const SizedBox(height: 5),
      const Text(
        'Cámara',
        style: TextStyle(color: Colors.white),
      ),
    ],
  );
}
