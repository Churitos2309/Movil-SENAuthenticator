import 'package:flutter/material.dart';
import 'package:reconocimiento_app/services/api_services.dart';

class HomeAprendizScreen extends StatefulWidget {
  const HomeAprendizScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeAprendizScreenState createState() => _HomeAprendizScreenState();
}

class _HomeAprendizScreenState extends State<HomeAprendizScreen> {
  late Future<List<dynamic>> _objetos;

  @override
  void initState() {
    super.initState();
    _objetos = fetchObjetos();
  }

  Future<List<dynamic>> fetchObjetos() async {
    try {
      ApiService apiService = ApiService();
      print('Fetching objects...');
      final response = await apiService.get('objetos/');
      if (response.isEmpty) {
        throw Exception("No hay objetos disponibles");
      }
      print('Objects fetched: ${response.length}');
      return response;
    } catch (e) {
      print('Error fetching objects: $e');
      throw Exception('Error al obtener los objetos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<dynamic>>(
          future: _objetos,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator()); // Indicador de carga normal
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No hay objetos registrados.'));
            } else {
              final List<dynamic> objetos = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      "Previa vista",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                        mainAxisSpacing: 16.0,
                        crossAxisSpacing: 16.0,
                      ),
                      itemCount: objetos.length,
                      itemBuilder: (context, index) {
                        final objeto = objetos[index];
                        final imageUrl = objeto['foto_objeto'] ?? '';

                        return _buildLargeImageCard(imageUrl);
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  // Método para construir los campos grandes con imágenes
  Widget _buildLargeImageCard(String imageUrl) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3), // Sombra
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey.shade200,
              child: const Center(
                child: Icon(
                  Icons.error,
                  color: Colors.red,
                  size: 50,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: HomeAprendizScreen(),
  ));
}
