import 'package:flutter/material.dart';
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:vector_math/vector_math_64.dart'; // Para las operaciones Vector3

class ARCameraExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Realidad Aumentada'),
      ),
      body: ARView(
        onARViewCreated: (ARViewController arViewController) {
          _addShirt(arViewController);
        },
      ),
    );
  }

  void _addShirt(ARViewController arViewController) {
    // Aquí defines cómo agregar la polera en modo AR
    arViewController.addNode(
      node: ARNode(
        type: NodeType.localGLTF2,
        uri: 'assets/polera.gltf', // Asegúrate de tener el archivo gltf o glb en esta ruta
        scale: Vector3(0.5, 0.5, 0.5), // Ajusta el tamaño según sea necesario
        position: Vector3(0, 0, -1), // Posiciona la polera a 1 metro de distancia
      ),
    );
  }
}
