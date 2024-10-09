import 'package:flutter/material.dart';
import 'package:reconocimiento_app/services/api_services.dart';
import 'usuarios_aprendiz/usuarios.dart';

class FichasScreen extends StatefulWidget {
  final int programaId;

  const FichasScreen({required this.programaId, super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FichasScreenState createState() => _FichasScreenState();
}

const primaryColor = Color(0xFF39a900); // Verde institucional del SENA
const defaultPadding = 16.0;

class _FichasScreenState extends State<FichasScreen> {
  final ApiService apiService = ApiService();
  List<dynamic> fichas = [];
  bool isLoading = false;
  String errorMessage = '';
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    fetchFichas();
  }

  void fetchFichas() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = '';
      });

      final endpoint = 'fichas/?programa_ficha=${widget.programaId}';
      final data = await apiService.get(endpoint);

      setState(() {
        fichas = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error obteniendo fichas: $e';
        isLoading = false;
      });
    }
  }

  void showUserDetails(int fichaId, String numeroFicha) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UsuariosScreen(fichaId: fichaId, numeroFicha: numeroFicha),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : errorMessage.isNotEmpty
                ? Center(
                    child: Text(
                      errorMessage,
                      style: const TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  )
                : fichas.isEmpty
                    ? Center(
                        child: Text(
                          'No hay fichas disponibles.',
                          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                        ),
                      )
                    : Column(
                        children: [
                          // Sección de filtros
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        searchQuery = value;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Buscar por número de ficha',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(color: primaryColor),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Encabezados de la tabla
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.transparent,
                                  width: 1),
                              borderRadius: BorderRadius.circular(16),
                              color: primaryColor,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                                    child: const Center(
                                      child: Text(
                                        'Ficha',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                                    child: const Center(
                                      child: Text(
                                        'Aprendices',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                                    child: const Center(
                                      child: Text(
                                        'Jornada',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Tabla de datos
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(16.0),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minWidth: screenWidth,
                                  ),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: DataTable(
                                      showCheckboxColumn: false,
                                      columnSpacing: defaultPadding,
                                      // ignore: deprecated_member_use
                                      dataRowHeight: 50.0,
                                      headingRowHeight: 0,
                                      dataRowColor: WidgetStateProperty.resolveWith(
                                        (states) => Colors.transparent,
                                      ),
                                      border: TableBorder(
                                        horizontalInside: BorderSide(
                                          color: Colors.grey.withOpacity(0.3),
                                          width: 1,
                                        ),
                                      ),
                                      columns: <DataColumn>[
                                        DataColumn(label: Container()), // Columna vacía para evitar duplicados
                                        DataColumn(label: Container()),
                                        DataColumn(label: Container()),
                                      ],
                                      rows: fichas.where((ficha) {
                                        return ficha['numero_ficha']
                                            .toString()
                                            .toLowerCase()
                                            .contains(searchQuery.toLowerCase());
                                      }).map<DataRow>((ficha) {
                                        return DataRow(
                                          cells: <DataCell>[
                                            DataCell(
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(12),
                                                  color: Colors.white.withOpacity(0.5),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black.withOpacity(0.05),
                                                      spreadRadius: 2,
                                                      blurRadius: 8,
                                                      offset: const Offset(0, 4),
                                                    ),
                                                  ],
                                                ),
                                                child: Text(
                                                  ficha['numero_ficha'] ?? '',
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(12),
                                                  color: Colors.white.withOpacity(0.5),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black.withOpacity(0.05),
                                                      spreadRadius: 2,
                                                      blurRadius: 8,
                                                      offset: const Offset(0, 4),
                                                    ),
                                                  ],
                                                ),
                                                child: Text(
                                                  ficha['aprendices_matriculados_ficha'].toString(),
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(12),
                                                  color: Colors.white.withOpacity(0.5),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black.withOpacity(0.05),
                                                      spreadRadius: 2,
                                                      blurRadius: 8,
                                                      offset: const Offset(0, 4),
                                                    ),
                                                  ],
                                                ),
                                                child: Text(
                                                  ficha['jornada_ficha'] ?? '', // Cambiado para usar jornada_ficha
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                          onSelectChanged: (selected) {
                                            showUserDetails(ficha['id'], ficha['numero_ficha']);
                                          },
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
      ),
    );
  }
}
