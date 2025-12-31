import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ServiciosScreen extends StatelessWidget {
  const ServiciosScreen({super.key});

  Future<List<dynamic>> leerAPI() async {
    const url = "https://jritsqmet.github.io/web-api/medico.json";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['servicio_medico'];
    } else {
      throw Exception("Error al cargar los servicios");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Servicios Médicos"),
        backgroundColor: const Color(0xFF00ACC1),
        actions: [
          IconButton(
            // Cambiamos el icono a uno más estándar (calendar_today)
            icon: const Icon(Icons.calendar_today), 
            onPressed: () {
              Navigator.pushNamed(context, '/citas');
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: leerAPI(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          
          List data = snapshot.data!;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final item = data[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(10),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      item['info']['imagen'], 
                      width: 60, 
                      height: 60, 
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(item['nombre'], style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text("Horario: ${item['horario']}"),
                  onTap: () => _mostrarAlertaInfo(context, item),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _mostrarAlertaInfo(context, item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(item['nombre']),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("🏥 Proveedor: ${item['proveedor']['nombre']}"),
            const SizedBox(height: 5),
            Text("📍 Ubicación: ${item['proveedor']['ubicacion']['direccion']}"),
            const SizedBox(height: 5),
            Text("💰 Precio: ${item['info']['precio']}"),
            const SizedBox(height: 10),
            Text(item['descripcion'], style: const TextStyle(fontStyle: FontStyle.italic)),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("CERRAR"))
        ],
      ),
    );
  }
}