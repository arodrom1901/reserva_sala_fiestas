import "package:flutter/material.dart";
import "package:firebase_core/firebase_core.dart";
import "package:provider/provider.dart";
import "package:firebase_auth/firebase_auth.dart";
import "firebase_options.dart";
import "providers/cart_provider.dart";
import "screens/login_screen.dart";
import "screens/catalog_screen.dart";

// lo primero es inicializar firebase
void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(SalaFiestasApp());
}

class SalaFiestasApp extends StatelessWidget {
  const SalaFiestasApp({super.key});

  @override
  Widget build(BuildContext context) {
    // el provider envuelve todo para que el carrito esté disponible
    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MaterialApp(
        title: "Salón de Fiestas Alejota",
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: AuthWrapper(),
      ),
    );
  }
}

// el portero que decide si entras al catálogo o te quedas en el login
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // si hay usuario en la sesión, directo al catálogo
        if (snapshot.hasData) {
          return CatalogScreen();
        }
        // si no, toca iniciar sesión
        return LoginScreen();
      },
    );
  }
}
