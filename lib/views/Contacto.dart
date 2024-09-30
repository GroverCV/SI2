import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Asegúrate de que esta línea funcione después de agregar la dependencia

class Contacto extends StatefulWidget {
  const Contacto({super.key});

  @override
  State<Contacto> createState() => _ContactoState();
}

class _ContactoState extends State<Contacto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacto'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Container(
          // Elimina el color de fondo aquí
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                '¡Contáctanos!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Text(
                'Si tienes alguna pregunta, no dudes en contactarnos a través de nuestras redes sociales.',
                style: TextStyle(fontSize: 16, color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Wrap(
                spacing: 20,
                alignment: WrapAlignment.center,
                children: [
                  _buildIconWithLabel(
                    label: 'Facebook',
                    url: 'https://www.facebook.com', // URL de Facebook
                  ),
                  _buildIconWithLabel(
                    label: 'WhatsApp',
                    url: 'https://wa.me/78023575', // URL de WhatsApp (ejemplo)
                  ),
                  _buildIconWithLabel(
                    label: 'Telegram',
                    url: 'https://t.me/muerte60', // URL de Telegram (ejemplo)
                  ),
                  _buildIconWithLabel(
                    label: 'TikTok',
                    url: 'https://www.tiktok.com', // URL de TikTok
                  ),
                  _buildIconWithLabel(
                    label: 'YouTube',
                    url: 'https://www.youtube.com', // URL de YouTube
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                '¡Síguenos en nuestras redes sociales!',
                style: TextStyle(fontSize: 16, color: Colors.white70),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      backgroundColor:
          Colors.black, // Establecer el color de fondo a negro aquí
    );
  }

  // Método auxiliar para crear un texto con enlace
  Widget _buildIconWithLabel({
    required String label,
    required String url,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
          onPressed: () =>
              _launchURL(url), // Llama a la función para abrir el enlace
          child: Column(
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 14, color: Colors.white),
              ),
              const SizedBox(height: 5), // Espacio entre el nombre y el ícono
              Icon(Icons.link, color: Colors.white), // Ícono representativo
            ],
          ),
        ),
      ],
    );
  }

  // Función para lanzar la URL en el navegador
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo abrir la URL: $url';
    }
  }
}
