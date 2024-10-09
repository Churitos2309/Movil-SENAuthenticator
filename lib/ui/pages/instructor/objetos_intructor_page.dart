import 'package:flutter/material.dart';
import 'package:reconocimiento_app/services/api_services.dart';
import 'fichas_instructor/fichas_screen.dart';

class ReportesInstructorPage extends StatefulWidget {
  const ReportesInstructorPage({super.key});

  @override
  _ReportesInstructorPageState createState() => _ReportesInstructorPageState();
}

const primaryColor = Color(0xFF39a900); // Verde institucional del SENA
const secondaryColor = Color(0xFF006400); // Verde oscuro para acentos
const defaultPadding = 16.0;

class _ReportesInstructorPageState extends State<ReportesInstructorPage> {
  final ApiService apiService = ApiService();
  List<dynamic> programas = [];
  List<dynamic> filteredProgramas = []; // Lista para los programas filtrados
  bool isLoading = false;
  String errorMessage = '';
  TextEditingController filterController =
      TextEditingController(); // Controlador para el filtro

  @override
  void initState() {
    super.initState();
    fetchProgramas();
    filterController.addListener(() {
      filterProgramas();
    });
  }

  @override
  void dispose() {
    filterController.dispose();
    super.dispose();
  }

  void fetchProgramas() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = '';
      });

      final List<dynamic> data = await apiService.get('programas/');
      setState(() {
        programas = data;
        filteredProgramas =
            data; // Inicializa la lista filtrada con todos los programas
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error obteniendo programas: $e';
        isLoading = false;
      });
    }
  }

  void filterProgramas() {
    String query = filterController.text.toLowerCase();
    setState(() {
      filteredProgramas = programas.where((programa) {
        String nombrePrograma = programa['nombre_programa'] ?? '';
        List<String> palabras = nombrePrograma.split(' ');
        return palabras
            .any((palabra) => palabra.toLowerCase().startsWith(query));
      }).toList();
    });
  }

  void onProgramSelected(int programaId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FichasScreen(programaId: programaId),
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
                controller: filterController,
                decoration: InputDecoration(
                  hintText: 'Buscar Programa',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 16.0),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(30.0), // Bordes redondeados
                    borderSide: BorderSide.none,
                  ),
                  // Sombra sutil
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(color: primaryColor),
                  ),
                ),
              ),
              const SizedBox(
                  height: defaultPadding), // Espacio entre el filtro y la tabla
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
                      : filteredProgramas.isEmpty
                          ? Center(
                              child: Text(
                                'No hay datos disponibles.',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.grey[600]),
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
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 10.0,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      minWidth:
                                          screenWidth, // Para hacerlo responsivo
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
                                          (states) => Colors.grey.shade200,
                                        ),
                                        dataRowColor:
                                            MaterialStateProperty.resolveWith(
                                          (states) => Colors.white,
                                        ),
                                        columns: <DataColumn>[
                                          DataColumn(
                                            label: Text(
                                              'Nombre Programa',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: primaryColor,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        ],
                                        rows: filteredProgramas
                                            .map<DataRow>((programa) {
                                          return DataRow(
                                            cells: <DataCell>[
                                              DataCell(
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 8.0,
                                                      horizontal: 16.0),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Colors.grey.shade100,
                                                        Colors.grey.shade50,
                                                      ],
                                                      begin: Alignment.topLeft,
                                                      end:
                                                          Alignment.bottomRight,
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.05),
                                                        spreadRadius: 2,
                                                        blurRadius: 8,
                                                        offset:
                                                            const Offset(0, 4),
                                                      ),
                                                    ],
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      // Icono representativo
                                                      Icon(
                                                        Icons.face,
                                                        color: primaryColor,
                                                      ),
                                                      const SizedBox(width: 10),
                                                      Expanded(
                                                        child: Text(
                                                          programa[
                                                                  'nombre_programa'] ??
                                                              '',
                                                          style:
                                                              const TextStyle(
                                                            color:
                                                                Colors.black87,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w600,
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
                                                onProgramSelected(
                                                    programa['id']);
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
