// import 'package:flutter/material.dart';
// import 'package:reconocimiento_app/services/api_services.dart';

// import 'datos_aprendiz/datos_aprendiz.dart';
// import 'graficas/graficas_screen.dart';

// class UsuariosScreen extends StatefulWidget {
//   final int fichaId;
//   final String numeroFicha;

//   const UsuariosScreen({
//     required this.fichaId,
//     required this.numeroFicha,
//     super.key,
//   });

//   @override
//   // ignore: library_private_types_in_public_api
//   _UsuariosScreenState createState() => _UsuariosScreenState();
// }

// class _UsuariosScreenState extends State<UsuariosScreen> {
//   final ApiService apiService = ApiService();
//   List<dynamic> usuarios = [];
//   bool isLoading = false;
//   String errorMessage = '';

//   @override
//   void initState() {
//     super.initState();
//     fetchUsuarios();
//   }

//   void fetchUsuarios() async {
//     try {
//       setState(() {
//         isLoading = true;
//         errorMessage = '';
//       });

//       final data = await apiService.get('usuarios/');
//       print('Datos de usuarios: $data'); // Verifica los datos recibidos

//       final usuariosFiltrados = data
//           .where((usuario) => usuario['ficha_usuario'] == widget.fichaId)
//           .toList();

//       setState(() {
//         usuarios = usuariosFiltrados;
//         isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         errorMessage = 'Error obteniendo usuarios: $e';
//         isLoading = false;
//       });
//     }
//   }

//   void _showUsuarioDetails(Map<String, dynamic> usuario) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       builder: (BuildContext context) {
//         return DatosAprendiz(usuario: usuario);
//       },
//     );
//   }

//   void _showGrafica() {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       builder: (BuildContext context) {
//         return const GraficasInstructorScreen();
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Usuarios asociados a la Ficha ${widget.numeroFicha}'),
//         backgroundColor: const Color(0xFF39A900),
//         elevation: 0,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.search, color: Colors.white),
//             onPressed: () {
//               // Implementar búsqueda si es necesario
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: isLoading
//             ? const Center(child: CircularProgressIndicator())
//             : errorMessage.isNotEmpty
//                 ? Center(
//                     child: Text(errorMessage,
//                         style: const TextStyle(color: Colors.red, fontSize: 14)))
//                 : usuarios.isEmpty
//                     ? Center(
//                         child: Text('No hay usuarios asociados a esta ficha.',
//                             style: TextStyle(
//                                 fontSize: 14, color: Colors.grey[600])))
//                     : Container(
//                         padding: const EdgeInsets.all(16.0),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(12.0),
//                           border:
//                               Border.all(color: Colors.grey[300]!, width: 2),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(0.2),
//                               spreadRadius: 2,
//                               blurRadius: 6,
//                               offset: const Offset(0, 4),
//                             ),
//                           ],
//                         ),
//                         child: SingleChildScrollView(
//                           scrollDirection: Axis.horizontal,
//                           child: ConstrainedBox(
//                             constraints: BoxConstraints(
//                               minWidth: MediaQuery.of(context).size.width,
//                             ),
//                             child: SingleChildScrollView(
//                               scrollDirection: Axis.vertical,
//                               child: DataTable(
//                                 columnSpacing: 8.0,
//                                 // ignore: deprecated_member_use
//                                 dataRowHeight: 50.0,
//                                 headingRowHeight: 50.0,
//                                 headingRowColor: WidgetStateColor.resolveWith(
//                                   (states) => Colors.transparent,
//                                 ),
//                                 dataRowColor: WidgetStateProperty.resolveWith(
//                                   (states) => Colors.grey[100]!,
//                                 ),
//                                 columns: <DataColumn>[
//                                   DataColumn(
//                                     label: Container(
//                                       padding: const EdgeInsets.symmetric(
//                                           vertical: 6.0, horizontal: 12.0),
//                                       decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius: BorderRadius.circular(20),
//                                         border: Border.all(
//                                             color: const Color(0xFF2C6B2F), width: 2),
//                                         boxShadow: [
//                                           BoxShadow(
//                                             color: Colors.grey.withOpacity(0.2),
//                                             spreadRadius: 2,
//                                             blurRadius: 8,
//                                             offset: const Offset(0, 4),
//                                           ),
//                                         ],
//                                       ),
//                                       child: const Center(
//                                         child: Text(
//                                           'Nombre',
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             color: Color(0xFF2C6B2F),
//                                             fontSize: 14,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   DataColumn(
//                                     label: Container(
//                                       padding: const EdgeInsets.symmetric(
//                                           vertical: 6.0, horizontal: 12.0),
//                                       decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius: BorderRadius.circular(20),
//                                         border: Border.all(
//                                             color: const Color(0xFF2C6B2F), width: 2),
//                                         boxShadow: [
//                                           BoxShadow(
//                                             color: Colors.grey.withOpacity(0.2),
//                                             spreadRadius: 2,
//                                             blurRadius: 8,
//                                             offset: const Offset(0, 4),
//                                           ),
//                                         ],
//                                       ),
//                                       child: const Center(
//                                         child: Text(
//                                           'Correo',
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             color: Color(0xFF2C6B2F),
//                                             fontSize: 14,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   DataColumn(
//                                     label: Container(
//                                       padding: const EdgeInsets.symmetric(
//                                           vertical: 6.0, horizontal: 12.0),
//                                       decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius: BorderRadius.circular(20),
//                                         border: Border.all(
//                                             color: const Color(0xFF2C6B2F), width: 2),
//                                         boxShadow: [
//                                           BoxShadow(
//                                             color: Colors.grey.withOpacity(0.2),
//                                             spreadRadius: 2,
//                                             blurRadius: 8,
//                                             offset: const Offset(0, 4),
//                                           ),
//                                         ],
//                                       ),
//                                       child: const Center(
//                                         child: Text(
//                                           'Rol',
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             color: Color(0xFF2C6B2F),
//                                             fontSize: 14,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   DataColumn(
//                                     label: Container(
//                                       padding: const EdgeInsets.symmetric(
//                                           vertical: 6.0, horizontal: 12.0),
//                                       decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius: BorderRadius.circular(20),
//                                         border: Border.all(
//                                             color: const Color(0xFF2C6B2F), width: 2),
//                                         boxShadow: [
//                                           BoxShadow(
//                                             color: Colors.grey.withOpacity(0.2),
//                                             spreadRadius: 2,
//                                             blurRadius: 8,
//                                             offset: const Offset(0, 4),
//                                           ),
//                                         ],
//                                       ),
//                                       child: const Center(
//                                         child: Text(
//                                           'Gráfica',
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             color: Color(0xFF2C6B2F),
//                                             fontSize: 14,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                                 rows: usuarios.map<DataRow>((usuario) {
//                                   return DataRow(
//                                     color: WidgetStateProperty.resolveWith<
//                                         Color?>(
//                                       (states) {
//                                         // Alterna el color de fondo de las filas
//                                         return (states.contains(
//                                                 WidgetState.selected))
//                                             ? Colors.grey[200]
//                                             : null;
//                                       },
//                                     ),
//                                     cells: <DataCell>[
//                                       DataCell(
//                                         GestureDetector(
//                                           onTap: () =>
//                                               _showUsuarioDetails(usuario),
//                                           child: Container(
//                                             padding: const EdgeInsets.symmetric(
//                                                 vertical: 4),
//                                             decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(8),
//                                               color: Colors.white,
//                                               boxShadow: [
//                                                 BoxShadow(
//                                                   color: Colors.grey
//                                                       .withOpacity(0.2),
//                                                   spreadRadius: 1,
//                                                   blurRadius: 5,
//                                                   offset: const Offset(0, 3),
//                                                 ),
//                                               ],
//                                             ),
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.all(8.0),
//                                               child: Text(
//                                                 '${usuario['first_name']} ${usuario['last_name']}',
//                                                 style: const TextStyle(
//                                                     color: Colors.black,
//                                                     fontSize: 12),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       DataCell(Container(
//                                         padding:
//                                             const EdgeInsets.symmetric(vertical: 4),
//                                         decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(8),
//                                           color: Colors.white,
//                                           boxShadow: [
//                                             BoxShadow(
//                                               color: Colors.grey
//                                                   .withOpacity(0.2),
//                                               spreadRadius: 1,
//                                               blurRadius: 5,
//                                               offset: const Offset(0, 3),
//                                             ),
//                                           ],
//                                         ),
//                                         child: Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: Text(
//                                             '${usuario['email']}',
//                                             style: const TextStyle(
//                                                 color: Colors.black,
//                                                 fontSize: 12),
//                                           ),
//                                         ),
//                                       )),
//                                       DataCell(Container(
//                                         padding:
//                                             const EdgeInsets.symmetric(vertical: 4),
//                                         decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(8),
//                                           color: Colors.white,
//                                           boxShadow: [
//                                             BoxShadow(
//                                               color: Colors.grey
//                                                   .withOpacity(0.2),
//                                               spreadRadius: 1,
//                                               blurRadius: 5,
//                                               offset: const Offset(0, 3),
//                                             ),
//                                           ],
//                                         ),
//                                         child: Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: Text(
//                                             '${usuario['rol_usuario'] ?? 'Desconocido'}', // Usa 'rol_usuario'
//                                             style: const TextStyle(
//                                                 color: Colors.black,
//                                                 fontSize: 12),
//                                           ),
//                                         ),
//                                       )),
//                                       DataCell(
//                                         GestureDetector(
//                                           onTap: _showGrafica,
//                                           child: Container(
//                                             padding: const EdgeInsets.symmetric(
//                                                 vertical: 4),
//                                             decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(8),
//                                               color: Colors.white,
//                                               boxShadow: [
//                                                 BoxShadow(
//                                                   color: Colors.grey
//                                                       .withOpacity(0.2),
//                                                   spreadRadius: 1,
//                                                   blurRadius: 5,
//                                                   offset: const Offset(0, 3),
//                                                 ),
//                                               ],
//                                             ),
//                                             child: const Padding(
//                                               padding:
//                                                   EdgeInsets.all(8.0),
//                                               child: Icon(Icons.insert_chart,
//                                                   color: Color(0xFF39A900)),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   );
//                                 }).toList(),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:reconocimiento_app/services/api_services.dart';
import 'datos_aprendiz/datos_aprendiz.dart';

class UsuariosScreen extends StatefulWidget {
  final int fichaId;
  final String numeroFicha;

  const UsuariosScreen({
    required this.fichaId,
    required this.numeroFicha,
    super.key,
  });

  @override
  _UsuariosScreenState createState() => _UsuariosScreenState();
}

const primaryColor = Color(0xFF39a900); // Verde institucional del SENA
const secondaryColor = Color(0xFF006400); // Verde oscuro para acentos
const defaultPadding = 16.0;

class _UsuariosScreenState extends State<UsuariosScreen> {
  final ApiService apiService = ApiService();
  List<dynamic> usuarios = [];
  bool isLoading = false;
  String errorMessage = '';
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    fetchUsuarios();
  }

  void fetchUsuarios() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = '';
      });

      final data = await apiService.get('usuarios/');
      print('Datos de usuarios: $data'); // Verifica los datos recibidos

      final usuariosFiltrados = data
          .where((usuario) => usuario['ficha_usuario'] == widget.fichaId)
          .toList();

      setState(() {
        usuarios = usuariosFiltrados;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error obteniendo usuarios: $e';
        isLoading = false;
      });
    }
  }

  void _showUsuarioDetails(Map<String, dynamic> usuario) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DatosAprendiz(usuario: usuario);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.grey.shade200, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
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
                : usuarios.isEmpty
                    ? Center(
                        child: Text(
                          'No hay usuarios asociados a esta ficha.',
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[600]),
                        ),
                      )
                    : Column(
                        children: [
                          // Filtro de búsqueda
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  searchQuery = value;
                                });
                              },
                              decoration: InputDecoration(
                                labelText: 'Buscar por nombre',
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: primaryColor,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 16.0),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide:
                                      const BorderSide(color: primaryColor),
                                ),
                              ),
                            ),
                          ),
                          // Encabezados de la tabla con íconos
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: primaryColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  spreadRadius: 2,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(
                                          Icons.person,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          'Nombre',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(
                                          Icons.email,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          'Correo',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(
                                          Icons.badge,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          'Rol',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          // Tabla de datos
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minWidth: MediaQuery.of(context).size.width,
                                  ),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: DataTable(
                                      showCheckboxColumn: false,
                                      columnSpacing: 8.0,
                                      dataRowHeight: 60.0,
                                      headingRowHeight:
                                          0, // Ocultar encabezados internos
                                      columns: <DataColumn>[
                                        // Columnas vacías para evitar duplicados
                                        DataColumn(label: Container()),
                                        DataColumn(label: Container()),
                                        DataColumn(label: Container()),
                                      ],
                                      rows: usuarios.where((usuario) {
                                        return usuario['first_name']
                                                .toString()
                                                .toLowerCase()
                                                .contains(searchQuery
                                                    .toLowerCase()) ||
                                            usuario['last_name']
                                                .toString()
                                                .toLowerCase()
                                                .contains(
                                                    searchQuery.toLowerCase());
                                      }).map<DataRow>((usuario) {
                                        String firstName =
                                            usuario['first_name'] ??
                                                'Sin Nombre';
                                        String lastName =
                                            usuario['last_name'] ??
                                                'Sin Apellido';
                                        String email =
                                            usuario['email'] ?? 'Sin Correo';
                                        String rol = usuario['rol_usuario'] ??
                                            'Desconocido';

                                        return DataRow(
                                          color: MaterialStateProperty
                                              .resolveWith<Color?>(
                                            (states) => states.contains(
                                                    MaterialState.selected)
                                                ? Colors.grey[200]
                                                : null,
                                          ),
                                          cells: <DataCell>[
                                            _buildDataCell(
                                              '$firstName $lastName',
                                              usuario,
                                              Icons.person,
                                            ),
                                            _buildDataCell(
                                              email,
                                              usuario,
                                              Icons.email,
                                            ),
                                            _buildDataCell(
                                              rol,
                                              usuario,
                                              Icons.badge,
                                            ),
                                          ],
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

  DataCell _buildDataCell(
      String label, Map<String, dynamic> usuario, IconData icon) {
    return DataCell(
      GestureDetector(
        onTap: () => _showUsuarioDetails(usuario),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey.shade100,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: primaryColor,
                size: 20,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
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
