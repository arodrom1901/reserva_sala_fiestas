import "package:flutter/material.dart";
import "package:reserva_sala_fiestas/screens/register_screen.dart";
import "../services/auth_service.dart";
import "catalog_screen.dart";

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // controladores para capturar lo que el usuario escribe en los campos
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _auth = AuthService();

  // estado para alternar la visibilidad de la contraseña
  bool _esVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text(
          "Sala de Fiestas Alejota",
          style: TextStyle(color: Colors.amber),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.music_note, size: 80, color: Colors.amber),
            SizedBox(height: 30),
            // campo para introducir el email del usuario
            TextField(
              controller: _emailController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Introduzca su correo electrónico",
                labelStyle: TextStyle(color: Colors.amber),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber),
                ),
              ),
            ),
            SizedBox(height: 20),
            // campo para introducir la contraseña con icono de ojo para alternar visibilidad
            TextField(
              controller: _passwordController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Introduzca su contraseña",
                labelStyle: TextStyle(color: Colors.amber),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber),
                ),
                // icono al final del campo que permite mostrar u ocultar la clave
                suffixIcon: IconButton(
                  icon: Icon(
                    _esVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.amber,
                  ),
                  onPressed: () {
                    // cambiamos el estado al pulsar el ojo para redibujar el campo
                    setState(() {
                      _esVisible = !_esVisible;
                    });
                  },
                ),
              ),
              // usamos la variable de estado para controlar si se ocultan los caracteres
              obscureText: !_esVisible,
            ),
            SizedBox(height: 40),
            // botón para procesar el inicio de sesión
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () async {
                  // intentamos validar las credenciales con nuestro servicio de auth
                  var user = await _auth.iniciarSesion(
                    _emailController.text.trim(),
                    _passwordController.text.trim(),
                  );
                  // si el usuario es válido, navegamos al catálogo y eliminamos el login del historial
                  if (user != null) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => CatalogScreen()),
                    );
                  } else {
                    // avisamos al usuario si las credenciales no son correctas
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Error: usuario o contraseña incorrectos",
                        ),
                      ),
                    );
                  }
                },
                child: Text("Entrar"),
              ),
            ),
            // enlace para redirigir a la pantalla de registro
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => RegisterScreen()),
                );
              },
              child: Text(
                "¿No tienes cuenta? Regístrate aquí",
                style: TextStyle(color: Colors.amber),
              ),
            ),
          ],
        ),
      ),
    );
  }
}