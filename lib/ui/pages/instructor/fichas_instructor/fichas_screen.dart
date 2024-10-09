import 'package:flutter/material.dart';
import 'package:reconocimiento_app/services/api_services.dart';
import 'usuarios_aprendiz/usuarios.dart';

class FichasScreen extends StatefulWidget {
  final int programaId;

  const FichasScreen({required this.programaId, super.key});

  @override
  _FichasScreenState createState() => _FichasScreenState();
}

const primaryColor = Color(0xFF39a900); // Verde institucional del SENA
const secondaryColor = Color(0xFF006400); // Verde oscuro para acentos
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
        builder: (context) =>
            UsuariosScreen(fichaId: fichaId, numeroFicha: numeroFicha),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.grey.shade200, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              // Campo de texto para el filtro
              TextField(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Buscar por número de ficha',
                  prefixIcon: const Icon(Icons.search, color: primaryColor),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 16.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0), // Bordes redondeados
                    borderSide: const BorderSide(
                      color: primaryColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(color: primaryColor),
                  ),
                ),
              ),
              const SizedBox(
                  height:
                      defaultPadding), // Espacio entre el filtro y la tabla
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : errorMessage.isNotEmpty
                      ? Center(
                          child: Text(
                            errorMessage,
                            style: const TextStyle(
                                color: Colors.red, fontSize: 16),
                          ),
                        )
                      : fichas.isEmpty
                          ? Center(
                              child: Text(
                                'No hay fichas disponibles.',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[600]),
                              ),
                            )
                          : Expanded(
                              // Usa Expanded para permitir que la tabla ocupe el espacio restante
                              child: Container(
                                padding: const EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Colors.black.withOpacity(0.1),
                                      blurRadius: 10.0,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
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
                                        dataRowHeight: 60.0,
                                        headingRowHeight: 60.0,
                                        dividerThickness:
                                            1.0, // Grosor de los divisores
                                        headingRowColor:
                                            MaterialStateColor.resolveWith(
                                          (states) =>
                                              Colors.grey.shade200,
                                        ),
                                        dataRowColor:
                                            MaterialStateProperty.resolveWith(
                                          (states) => Colors.white,
                                        ),
                                        columns: <DataColumn>[
                                          DataColumn(
                                            label: Text(
                                              'Ficha',
                                              style: TextStyle(
                                                fontWeight:
                                                    FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Text(
                                              'Aprendices',
                                              style: TextStyle(
                                                fontWeight:
                                                    FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Text(
                                              'Jornada',
                                              style: TextStyle(
                                                fontWeight:
                                                    FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        ],
                                        rows: fichas.where((ficha) {
                                          return ficha['numero_ficha']
                                              .toString()
                                              .toLowerCase()
                                              .contains(
                                                  searchQuery
                                                      .toLowerCase());
                                        }).map<DataRow>((ficha) {
                                          return DataRow(
                                            cells: <DataCell>[
                                              DataCell(
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  padding:
                                                      const EdgeInsets
                                                              .symmetric(
                                                          vertical: 8.0,
                                                          horizontal:
                                                              16.0),
                                                  decoration:
                                                      BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius
                                                            .circular(12),
                                                    gradient:
                                                        LinearGradient(
                                                      colors: [
                                                        Colors
                                                            .grey
                                                            .shade100
                                                            .withOpacity(
                                                                0.8),
                                                        Colors
                                                            .grey
                                                            .shade50
                                                            .withOpacity(
                                                                0.8),
                                                      ],
                                                      begin: Alignment
                                                          .topLeft,
                                                      end: Alignment
                                                          .bottomRight,
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors
                                                            .black
                                                            .withOpacity(
                                                                0.05),
                                                        spreadRadius: 2,
                                                        blurRadius: 8,
                                                        offset:
                                                            const Offset(
                                                                0, 4),
                                                      ),
                                                    ],
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      // Icono representativo
                                                      Icon(
                                                        Icons.face,
                                                        color:
                                                            primaryColor,
                                                      ),
                                                      const SizedBox(
                                                          width: 10),
                                                      Expanded(
                                                        child: Text(
                                                          ficha['numero_ficha'] ??
                                                              '',
                                                          style:
                                                              const TextStyle(
                                                            color:
                                                                Colors.black87,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              DataCell(
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  padding:
                                                      const EdgeInsets
                                                              .symmetric(
                                                          vertical: 8.0,
                                                          horizontal:
                                                              16.0),
                                                  decoration:
                                                      BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius
                                                            .circular(12),
                                                    gradient:
                                                        LinearGradient(
                                                      colors: [
                                                        Colors
                                                            .grey
                                                            .shade100
                                                            .withOpacity(
                                                                0.8),
                                                        Colors
                                                            .grey
                                                            .shade50
                                                            .withOpacity(
                                                                0.8),
                                                      ],
                                                      begin: Alignment
                                                          .topLeft,
                                                      end: Alignment
                                                          .bottomRight,
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors
                                                            .black
                                                            .withOpacity(
                                                                0.05),
                                                        spreadRadius: 2,
                                                        blurRadius: 8,
                                                        offset:
                                                            const Offset(
                                                                0, 4),
                                                      ),
                                                    ],
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      // Icono representativo
                                                      Icon(
                                                        Icons.people,
                                                        color:
                                                            primaryColor,
                                                      ),
                                                      const SizedBox(
                                                          width: 10),
                                                      Expanded(
                                                        child: Text(
                                                          ficha['aprendices_matriculados_ficha']
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                            color:
                                                                Colors.black87,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              DataCell(
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  padding:
                                                      const EdgeInsets
                                                              .symmetric(
                                                          vertical: 8.0,
                                                          horizontal:
                                                              16.0),
                                                  decoration:
                                                      BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius
                                                            .circular(12),
                                                    gradient:
                                                        LinearGradient(
                                                      colors: [
                                                        Colors
                                                            .grey
                                                            .shade100
                                                            .withOpacity(
                                                                0.8),
                                                        Colors
                                                            .grey
                                                            .shade50
                                                            .withOpacity(
                                                                0.8),
                                                      ],
                                                      begin: Alignment
                                                          .topLeft,
                                                      end: Alignment
                                                          .bottomRight,
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors
                                                            .black
                                                            .withOpacity(
                                                                0.05),
                                                        spreadRadius: 2,
                                                        blurRadius: 8,
                                                        offset:
                                                            const Offset(
                                                                0, 4),
                                                      ),
                                                    ],
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      // Icono representativo
                                                      Icon(
                                                        Icons.schedule,
                                                        color:
                                                            primaryColor,
                                                      ),
                                                      const SizedBox(
                                                          width: 10),
                                                      Expanded(
                                                        child: Text(
                                                          ficha['jornada_ficha'] ??
                                                              '',
                                                          style:
                                                              const TextStyle(
                                                            color:
                                                                Colors.black87,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                            onSelectChanged: (selected) {
                                              if (selected != null &&
                                                  selected) {
                                                showUserDetails(
                                                    ficha['id'],
                                                    ficha['numero_ficha']);
                                              }
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
      ),
    );
  }
}
