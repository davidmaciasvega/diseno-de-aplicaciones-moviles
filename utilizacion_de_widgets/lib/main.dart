import 'package:flutter/material.dart';

void main() {
  runApp(const MiAplicacionWidgets());
}

class MiAplicacionWidgets extends StatelessWidget {
  const MiAplicacionWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LDSW 3.4 Widgets',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Actividad 3.4 - Widgets en Español'),
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column( // 1. Widget de columna: Elementos verticales
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 2. Widget de Texto: Encabezado principal
              const Text(
                'Panel de Control',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 20),

              // 3. Widget de contenedor: Tarjeta contenedora con bordes y sombra
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.teal.shade200, width: 1.5),
                ),
                child: const Column(
                  children: [
                    Text(
                      'Implementacion de Contenedor',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Contenedor personalizado con márgenes, bordes redondeados y un fondo tenue.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),

              // 4. Widget de fila: Botones alineados horizontalmente
              const Text(
                'Acciones disponibles (fila):',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.favorite),
                    label: const Text('Me gusta'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.share),
                    label: const Text('Compartir'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // 5. Widget de stack: Superposición de elementos
              const Text(
                'Vista en capas (Stack):',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 15),
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Capa Principal
                    Container(
                      width: 220,
                      height: 130,
                      decoration: BoxDecoration(
                        color: Colors.teal.shade100,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    // Capa intermedia
                    Container(
                      width: 180,
                      height: 90,
                      decoration: BoxDecoration(
                        color: Colors.teal.shade700,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    // Capa superior
                    const Text(
                      'Capas Superpuestas',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}