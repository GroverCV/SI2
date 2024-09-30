import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthService {
  final String _url =
      'https://backend-seguros.campozanodevlab.com/public/api/usuarios';

  Future<int> singInEmailAndPassword(String correo, String pass) async {
    try {
      // Hacer la solicitud a la API para obtener la lista de usuarios
      final response = await http.get(Uri.parse(_url));

      if (response.statusCode == 200) {
        // Parsear la respuesta JSON
        List<dynamic> usuarios = json.decode(response.body);

        if (usuarios.isEmpty) {
          print("No se encontraron usuarios.");
          return 2; // No se encontraron usuarios
        }

        // Mostrar todos los usuarios recibidos para ver si están correctos
        print("Usuarios recibidos de la API: $usuarios");

        // Buscar si existe un usuario con el correo y la contraseña proporcionados
        for (var usuario in usuarios) {
          // Verificar si los campos existen
          if (usuario.containsKey('email') &&
              usuario.containsKey('contrasena')) {
            String? emailBD = usuario['email'];
            String? contrasenaBD = usuario['contrasena'];

            // Mostrar los valores recibidos de la base de datos
            print("Email en base de datos: $emailBD");
            print("Contraseña en base de datos: $contrasenaBD");

            if (emailBD != null && contrasenaBD != null) {
              // Comparar los valores
              if (emailBD.trim() == correo.trim() &&
                  contrasenaBD.trim() == pass.trim()) {
                print("Usuario y contraseña correctos.");
                return 0; // Éxito
              }
            } else {
              print(
                  "Uno de los campos es nulo. Email: $emailBD, Contraseña: $contrasenaBD");
            }
          } else {
            print("Faltan campos 'email' o 'contrasena' en el JSON.");
          }
        }

        print("Usuario o contraseña incorrecta.");
        return 1; // Usuario o contraseña incorrecta
      } else {
        print("Error en la solicitud. Status code: ${response.statusCode}");
        return 3; // Error de conexión o servidor
      }
    } catch (e) {
      print("Error desconocido: $e");
      return 3; // Error desconocido
    }
  }
}
