import "package:flutter/material.dart";
import "package:firebase_core/firebase_core.dart";
import "package:provider/provider.dart";
import "package:firebase_auth/firebase_auth.dart";
import "firebase_options.dart";
import "providers/cart_provider.dart";
import "screens/login_screen.dart";
import "screens/catalog_screen.dart";

// lo primero es inicializar firebase antes de que la app arranque
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(SalaFiestasApp());
}

class SalaFiestasApp extends StatelessWidget {
  const SalaFiestasApp({super.key});

  @override
  Widget build(BuildContext context) {
    // el provider envuelve toda la aplicación para que el carrito
    // sea accesible desde cualquier pantalla
    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Salón de Fiestas Alejota",
        // definimos un tema visual general
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        // llamamos al componente que decide qué pantalla mostrar primero
        home: AuthWrapper(),
      ),
    );
  }
}

// el portero que vigila el estado de la sesión y decide si entras
// al catálogo o te quedas en el login
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // el streambuilder escucha cambios en la autenticación en tiempo real
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // si hay un usuario logueado, entramos al catálogo
        if (snapshot.hasData) {
          return CatalogScreen();
        }
        // si no hay sesión activa, mostramos la pantalla de login
        return LoginScreen();
      },
    );
  }
}
