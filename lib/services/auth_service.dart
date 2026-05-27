import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // metodo para entrar con email y contraseña
  Future<User?> iniciarSesion(String email, String password) async {
    try {
      UserCredential resultado = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // devolvemos el usuario si todo ha ido bien
      return resultado.user;
    } catch (e) {
      // aquí capturamos el fallo si las credenciales no son correctas
      print("Error al entrar: $e");
      return null;
    }
  }

  // metodo para cerrar la sesión
  Future<void> cerrarSesion() async {
    await _auth.signOut();
  }

  // metodo para registrarse
  Future<User?> registrarse(String email, String password) async {
    try {
      UserCredential resultado = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // devolvemos el usuario recién creado
      return resultado.user;
    } catch (e) {
      // si el email ya existe o la contraseña es muy corta, capturamos el fallo
      print("Error al registrarse: $e");
      return null;
    }
  }
}
