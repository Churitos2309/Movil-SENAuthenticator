import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:reconocimiento_app/services/api_services.dart';

class Panel extends StatefulWidget {
  const Panel({super.key});

  @override
  _PanelState createState() => _PanelState();
}

class _PanelState extends State<Panel> {
  final ApiService apiService = ApiService();
  List<dynamic> usuarios = [];
  List<dynamic> filteredUsuarios = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    fetchUsuarios();
  }

  void fetchUsuarios() async {
    try {
      final data = await apiService.get('usuarios/');
      setState(() {
        usuarios = data;
        filteredUsuarios = data;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error obteniendo usuarios: $e');
      }
    }
  }

  void _filterUsuarios(String query) {
    final filtered = usuarios.where((usuario) {
      final nombre = usuario['first_name'].toLowerCase();
      return nombre.contains(query.toLowerCase());
    }).toList();

    setState(() {
      searchQuery = query;
      filteredUsuarios = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 12.0,
                spreadRadius: 2.0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Barra de búsqueda
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: TextField(
                  onChanged: _filterUsuarios,
                  decoration: InputDecoration(
                    labelText: 'Buscar por nombre',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor:
                        Colors.grey.shade50, // Color de fondo de la barra
                  ),
                ),
              ),
              // Título
              const Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'Resultados de Usuarios',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              // Contenedor para la tabla estilizada
              Container(
                constraints: const BoxConstraints(maxHeight: 700),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columnSpacing: 32.0,
                      headingTextStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color:
                            Colors.blueAccent, // Color del texto de encabezado
                      ),
                      dataTextStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                      columns: const <DataColumn>[
                        DataColumn(label: Text('ID')),
                        DataColumn(label: Text('Nombre')),
                        DataColumn(label: Text('Fecha')),
                        DataColumn(label: Text('Estado')),
                        DataColumn(label: Text('Documentos')),
                      ],
                      rows: _buildDataRows(),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.grey.shade50,
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

  List<DataRow> _buildDataRows() {
    return filteredUsuarios.map<DataRow>((usuario) {
      return DataRow(
        cells: <DataCell>[
          DataCell(Text(usuario['id'].toString())),
          DataCell(Text(usuario['first_name'] ?? '')),
          DataCell(Text(usuario['date_joined'] ?? '')),
          DataCell(Text(
            (usuario['is_staff'] && usuario['is_active'])
                ? 'Activo'
                : 'Inactivo',
          )),
          DataCell(Text(usuario['numero_documento_usuario'] ?? '')),
        ],
        color:
            WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.blue.shade100; // Color de fila seleccionada
          }
          return null; // Color por defecto
        }),
      );
    }).toList();
  }
}
