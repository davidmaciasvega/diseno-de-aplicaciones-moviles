import 'package:flutter/material.dart';

void main() {
  runApp(const MiApp());
}

class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Bienvenido a Flutter'),
        ),
        body: const Center(
          child: Text(
            'Hola Mundo',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}