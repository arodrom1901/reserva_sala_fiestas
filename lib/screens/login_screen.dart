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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bienvenido al Salón de Fiestas Alejota")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: "Contraseña"),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () async {
                // intentamos entrar
                var user = await _auth.iniciarSesion(
                  _emailController.text,
                  _passwordController.text,
                );
                if (user != null) {
                  // si todo va bien, vamos al catálogo
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => CatalogScreen()),
                  );
                } else {
                  // si falla, avisamos al usuario
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Error: usuario o contraseña mal"),
                    ),
                  );
                }
              },
              child: Text("Entrar"),
            ),
            // boton para ir a la pantalla de registro
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => RegisterScreen()),
                );
              },
              child: Text("No tienes cuenta? Regístrate aquí"),
            ),
          ],
        ),
      ),
    );
  }
}
