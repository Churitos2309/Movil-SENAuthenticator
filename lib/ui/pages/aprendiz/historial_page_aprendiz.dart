import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:reconocimiento_app/services/api_services.dart';

class HistorialAprendizPage extends StatefulWidget {
  const HistorialAprendizPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HistorialAprendizPageState createState() => _HistorialAprendizPageState();
}

class _HistorialAprendizPageState extends State<HistorialAprendizPage> {
  late Future<List<dynamic>> _objetos;

  @override
  void initState() {
    super.initState();
    _objetos = fetchObjetos();
  }

  Future<List<dynamic>> fetchObjetos() async {
    try {
      ApiService apiService = ApiService();
      if (kDebugMode) {
        print('Fetching objects...');
      }
      final response = await apiService.get('objetos/');
      if (response.isEmpty) {
        throw Exception("No hay objetos disponibles");
      }
      if (kDebugMode) {
        print('Objects fetched: ${response.length}');
      }
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching objects: $e');
      }
      throw Exception('Error al obtener los objetos: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<dynamic>>(
          future: _objetos,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CupertinoActivityIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No hay objetos registrados.'));
            } else {
              final List<dynamic> objetos = snapshot.data!;
              return ListView.builder(
                itemCount: objetos.length,
                itemBuilder: (context, index) {
                  final objeto = objetos[index];
                  final imageUrl = objeto['foto_objeto'] ?? '';

                  return Container(
                    margin: const EdgeInsets.only(bottom: 16.0),
                    decoration: BoxDecoration(
                      color: CupertinoColors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5.0,
                          spreadRadius: 0.5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Mostrar la imagen
                          imageUrl.isNotEmpty
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: Image.network(
                                    imageUrl,
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: Colors.grey.shade200,
                                        height: 100,
                                        width: 100,
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
                                )
                              : Container(
                                  color: Colors.grey.shade200,
                                  height: 100,
                                  width: 100,
                                  child: const Center(
                                    child: Icon(
                                      Icons.image,
                                      color: Colors.grey,
                                      size: 50,
                                    ),
                                  ),
                                ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Marca: ${objeto['marca_objeto'] ?? 'Desconocida'}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  'Modelo: ${objeto['modelo_objeto'] ?? 'Desconocido'}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  'Descripción: ${objeto['descripcion_objeto'] ?? 'No disponible'}',
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    color: CupertinoColors.inactiveGray,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
