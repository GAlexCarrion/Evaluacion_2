import 'package:flutter/material.dart';

import 'package:flutter_application_1/firebase_options.dart';
import 'package:flutter_application_1/screens/citas_screen.dart';      // Nombre corregido
import 'package:flutter_application_1/screens/servicios_screen.dart';  // Nombre corregido
import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:flutter_application_1/screens/registro_screen.dart';
import 'package:flutter_application_1/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const AppEv2());
}

class AppEv2 extends StatelessWidget {
  const AppEv2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sistema de Citas Médicas',
      // Definimos las rutas según tu examen
      routes: {
        '/welcome': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/registro': (context) => const RegistroScreen(),
        '/servicios': (context) => const ServiciosScreen(), // Pantalla de la API
        '/citas': (context) => const CitasScreen(),         // Pantalla de Formulario
      },
      home: const WelcomeScreen(),
    );
  }
}
