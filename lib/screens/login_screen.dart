import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController correo = TextEditingController();
    TextEditingController contrasenia = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Ingreso"), backgroundColor: Colors.transparent, elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            const Text("Bienvenido de nuevo", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF00838F))),
            const SizedBox(height: 40),
            _inputField("Correo Electrónico", Icons.email, correo),
            const SizedBox(height: 20),
            _inputField("Contraseña", Icons.lock, contrasenia, obscure: true),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                style: FilledButton.styleFrom(backgroundColor: const Color(0xFF00ACC1), padding: const EdgeInsets.all(15)),
                onPressed: () => login(correo.text, contrasenia.text, context),
                child: const Text("ENTRAR"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputField(String label, IconData icono, TextEditingController controller, {bool obscure = false}) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        prefixIcon: Icon(icono, color: const Color(0xFF00ACC1)),
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }

  Future<void> login(String email, String password, context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushNamed(context, '/servicios'); // Cambiado de /leer a /servicios
    } on FirebaseAuthException catch (e) {
      String mensaje = (e.code == 'user-not-found') ? "Usuario no encontrado" : "Credenciales Incorrectas";
      _alertaError(context, mensaje);
    }
  }

  void _alertaError(context, String mensaje) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Error de Acceso"),
        content: Text(mensaje),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK"))],
      ),
    );
  }
}