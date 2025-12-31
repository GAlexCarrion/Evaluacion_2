import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegistroScreen extends StatelessWidget {
  const RegistroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController correo = TextEditingController();
    TextEditingController contrasenia = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Crear Cuenta")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            const Icon(Icons.app_registration, size: 80, color: Color(0xFF00ACC1)),
            const SizedBox(height: 20),
            TextField(controller: correo, decoration: InputDecoration(labelText: "Ingrese su Correo", border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)))),
            const SizedBox(height: 20),
            TextField(controller: contrasenia, obscureText: true, decoration: InputDecoration(labelText: "Ingrese su Contraseña", border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)))),
            const SizedBox(height: 30),
            FilledButton(
              style: FilledButton.styleFrom(backgroundColor: const Color(0xFF00ACC1), minimumSize: const Size(double.infinity, 50)),
              onPressed: () => registrar(correo.text, contrasenia.text, context),
              child: const Text("REGISTRARSE"),
            ),
          ],
        ),
      ),
    );
  }

  // Mantenemos la lógica de registrar de tu compañero pero con navegación al login al tener éxito
  Future<void> registrar(String correo, String password, context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: correo, password: password);
      Navigator.pushNamed(context, '/login');
    } on FirebaseAuthException catch (e) {
      String msg = e.code == 'weak-password' ? "Contraseña muy débil" : "Error en el correo";
      showDialog(context: context, builder: (c) => AlertDialog(title: const Text("Error"), content: Text(msg)));
    }
  }
}