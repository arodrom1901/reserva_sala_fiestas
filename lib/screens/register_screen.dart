import "package:flutter/material.dart";
import "../services/auth_service.dart";

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // controladores para gestionar los datos de entrada del usuario
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text("Crear cuenta", style: TextStyle(color: Colors.amber)),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.amber),
      ),
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person_add, size: 80, color: Colors.amber),
            SizedBox(height: 30),
            // campo de texto para registrar el correo
            TextField(
              controller: _emailController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Introduce tu correo",
                labelStyle: TextStyle(color: Colors.amber),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber),
                ),
              ),
            ),
            SizedBox(height: 20),
            // campo de texto para la contraseña (oculto por seguridad)
            TextField(
              controller: _passwordController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Introduce una contraseña",
                labelStyle: TextStyle(color: Colors.amber),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber),
                ),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            // campo de texto para repetir la contraseña
            TextField(
              controller: _confirmPasswordController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Repite tu contraseña",
                labelStyle: TextStyle(color: Colors.amber),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber),
                ),
              ),
              obscureText: true,
            ),
            SizedBox(height: 40),
            // botón para procesar el registro con el servicio de autenticación
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () async {
                  // verificamos que las contraseñas coincidan antes de continuar
                  if (_passwordController.text !=
                      _confirmPasswordController.text) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Las contraseñas no coinciden")),
                    );
                    return;
                  }

                  // usamos trim() para limpiar posibles espacios en blanco accidentales
                  var user = await _auth.registrarse(
                    _emailController.text.trim(),
                    _passwordController.text.trim(),
                  );
                  // si el registro es exitoso, cerramos esta pantalla y volvemos al login
                  if (user != null) {
                    Navigator.pop(context);
                  } else {
                    // si falla el proceso, informamos al usuario con un aviso rápido
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Error al crear cuenta")),
                    );
                  }
                },
                child: Text("Registrarse"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}