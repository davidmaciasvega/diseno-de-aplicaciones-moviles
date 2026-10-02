import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MiAplicacionHome());
}

class MiAplicacionHome extends StatelessWidget {
  const MiAplicacionHome({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MovieHub - LDSW 3.6',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
        primaryColor: Colors.redAccent,
      ),
      home: const PantallaDeInicio(),
    );
  }
}

// Inicio

class PantallaDeInicio extends StatelessWidget {
  const PantallaDeInicio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              'https://images.unsplash.com/photo-1620177088258-c84147ee601f?q=80&w=685&auto=format&fit=crop',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withValues(alpha: 0.65),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'David Macías Vega',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const Column(
                    children: [
                      Text(
                        'MovieHub',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                          shadows: [
                            Shadow(
                              blurRadius: 12.0,
                              color: Colors.black,
                              offset: Offset(2.0, 2.0),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        '¡Bienvenido a nuestra plataforma!\nTu catálogo de cine en un solo lugar. Explora y descubre tus películas favoritas.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PantallaCatalogoHttp(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Ingresar al Catálogo Pokemon',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      /*
                      // Boton de registro, no esta en uso todavia
                      const SizedBox(height: 12),
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Colors.white70, width: 1.5),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Registrarse',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      */
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Peticion usando PokeApi

class Pokemon {
  final int id;
  final String nombre;
  final String imageUrl;

  Pokemon({
    required this.id,
    required this.nombre,
    required this.imageUrl,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json, int index) {
    int pokemonId = index + 1;
    return Pokemon(
      id: pokemonId,
      nombre: json['name'].toString().toUpperCase(),
      imageUrl:
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$pokemonId.png',
    );
  }
}

class PantallaCatalogoHttp extends StatefulWidget {
  const PantallaCatalogoHttp({super.key});

  @override
  State<PantallaCatalogoHttp> createState() => _PantallaCatalogoHttpState();
}

class _PantallaCatalogoHttpState extends State<PantallaCatalogoHttp> {
  // HTTP GET a PokéAPI
  Future<List<Pokemon>> obtenerPokemons() async {
    final url = Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=15');
    final respuesta = await http.get(url);

    if (respuesta.statusCode == 200) {
      Map<String, dynamic> datosJson = json.decode(respuesta.body);
      List<dynamic> resultados = datosJson['results'];

      List<Pokemon> lista = [];
      for (int i = 0; i < resultados.length; i++) {
        lista.add(Pokemon.fromJson(resultados[i], i));
      }
      return lista;
    } else {
      throw Exception('Error al conectar con PokéAPI: ${respuesta.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo PokéAPI (HTTP)'),
        backgroundColor: Colors.black87,
      ),
      body: FutureBuilder<List<Pokemon>>(
        future: obtenerPokemons(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.redAccent),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error HTTP:\n${snapshot.error}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.redAccent),
              ),
            );
          } else if (snapshot.hasData) {
            final pokemons = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: pokemons.length,
              itemBuilder: (context, index) {
                final poke = pokemons[index];
                return Card(
                  color: const Color(0xFF1E1E1E),
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: Image.network(
                      poke.imageUrl,
                      width: 50,
                      height: 50,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.catching_pokemon, color: Colors.redAccent),
                    ),
                    title: Text(
                      poke.nombre,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'Número en Pokédex: #${poke.id}',
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ),
                );
              },
            );
          }
          return const Center(child: Text('No hay datos disponibles.'));
        },
      ),
    );
  }
}