import "package:flutter/material.dart";
import "../services/auth_service.dart";

class RegisterScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _auth = AuthService();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Crear cuenta")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: "Introduce tu correo"),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: "Introduce una contraseña",
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                var user = await _auth.registrarse(
                  _emailController.text,
                  _passwordController.text,
                );
                if (user != null) {
                  // volvemos al login una vez registrados
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Error al crear cuenta")),
                  );
                }
              },
              child: Text("Registrarse"),
            ),
          ],
        ),
      ),
    );
  }
}
