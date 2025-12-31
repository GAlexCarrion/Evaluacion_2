import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [Color(0xFF00ACC1), Color(0xFF80DEEA)],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.medical_services, size: 100, color: Colors.white),
                const SizedBox(height: 20),
                const Text(
                  "Recupe'rart",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 50),
                _botonBienvenida(context, "INICIAR SESIÓN", '/login', Colors.white, const Color(0xFF00838F)),
                const SizedBox(height: 20),
                _botonBienvenida(context, "REGISTRARSE", '/registro', Colors.transparent, Colors.white, outlined: true),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _botonBienvenida(context, String texto, String ruta, Color fondo, Color textoColor, {bool outlined = false}) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: fondo,
          side: outlined ? const BorderSide(color: Colors.white, width: 2) : null,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        onPressed: () => Navigator.pushNamed(context, ruta),
        child: Text(texto, style: TextStyle(color: textoColor, fontWeight: FontWeight.bold, fontSize: 16)),
      ),
    );
  }
}