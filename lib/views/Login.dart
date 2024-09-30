import 'package:flutter/material.dart';
import 'package:seguro/utils/auth.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  static const String routename = '/login';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthService _authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/fondo1.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.4),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'TIENDA NOBLEVE',
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.black45,
                            offset: Offset(3, 3),
                          ),
                        ],
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 80),
                const Text(
                  "INICIAR SESION",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.amber,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30),
                SizedBox(
                  width: 350,
                  child: TextField(
                    controller: _emailController,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      prefixIconColor: Colors.white,
                      hintText: "example@gmail.com",
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      labelText: 'Ingrese email o usuario',
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                SizedBox(
                  width: 350,
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock_outline),
                      prefixIconColor: Colors.white,
                      labelText: 'Ingrese Contraseña',
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                SizedBox(
                  width: 350,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            // Fondo más oscuro cuando el botón es presionado
                            return Colors.amber.withOpacity(0.7);
                          }
                          // Fondo del botón con más opacidad por defecto
                          return Colors.amber.withOpacity(0.9);
                        },
                      ),
                      overlayColor: MaterialStateProperty.all<Color>(
                        Colors.black
                            .withOpacity(0.2), // Color al mantener presionado
                      ),
                    ),
                    onPressed: () async {
                      String email = _emailController.text;
                      String password = _passwordController.text;
                      var result = await _authService.singInEmailAndPassword(
                          email, password);
                      if (result == 1) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Error de usuario o contraseña')));
                      } else if (result == 0) {
                        Navigator.pushReplacementNamed(context, '/home');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                                Text('Error en la conexión o el servidor')));
                      }
                    },
                    child: Text(
                      'Iniciar',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 10, 57, 223),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
