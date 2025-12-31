import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class CitasScreen extends StatefulWidget {
  const CitasScreen({super.key});

  @override
  State<CitasScreen> createState() => _CitasScreenState();
}

class _CitasScreenState extends State<CitasScreen> {
  final _id = TextEditingController();
  final _especialidad = TextEditingController();
  final _dia = TextEditingController();

  Future<void> _guardar() async {
    if(_id.text.isEmpty) return; // Validación simple

    DatabaseReference ref = FirebaseDatabase.instance.ref("citas/${_id.text}");
    await ref.set({
      "id": _id.text,
      "especialidad": _especialidad.text,
      "dia": _dia.text,
    });
    
    if (mounted) {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(title: Text("Éxito"), content: Text("Cita Guardada Correctamente")),
      );
    }
    _id.clear(); _especialidad.clear(); _dia.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nueva Cita"), 
        backgroundColor: const Color(0xFF00ACC1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            const Text("Registro de Cita Médica", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            TextField(controller: _id, decoration: const InputDecoration(labelText: "ID de la Cita", border: OutlineInputBorder())),
            const SizedBox(height: 15),
            TextField(controller: _especialidad, decoration: const InputDecoration(labelText: "Especialidad", border: OutlineInputBorder())),
            const SizedBox(height: 15),
            TextField(controller: _dia, decoration: const InputDecoration(labelText: "Día / Fecha", border: OutlineInputBorder())),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: FilledButton(
                onPressed: _guardar, 
                style: FilledButton.styleFrom(backgroundColor: const Color(0xFF00ACC1)),
                child: const Text("GUARDAR EN BASE DE DATOS")
              ),
            )
          ],
        ),
      ),
    );
  }
}