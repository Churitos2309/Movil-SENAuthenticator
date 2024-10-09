// // import 'package:flutter/material.dart';
// // import 'package:fl_chart/fl_chart.dart';

// // class GraficaDeBarras extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       width: double.infinity,
// //       decoration: BoxDecoration(
// //         color: Color(0xFF0A4D92), // Color del fondo
// //         borderRadius: BorderRadius.circular(15),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black26,
// //             blurRadius: 10,
// //             offset: Offset(0, 4),
// //           ),
// //         ],
// //       ),
// //       child: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Text(
// //               "Gráfica de Barras",
// //               style: TextStyle(
// //                 fontSize: 20,
// //                 color: Colors.white,
// //                 fontWeight: FontWeight.w600,
// //               ),
// //             ),
// //             const SizedBox(height: 16.0),
// //             Container(
// //               height: 250,
// //               child: BarChart(
// //                 BarChartData(
// //                   alignment: BarChartAlignment.spaceAround,
// //                   maxY: 20,
// //                   barTouchData: BarTouchData(
// //                     touchTooltipData: BarTouchTooltipData(
// //                       tooltipPadding: EdgeInsets.all(8),
// //                       getTooltipItem: (group, groupIndex, rod, rodIndex) {
// //                         return BarTooltipItem(
// //                           '${rod.toY.round()}',
// //                           TextStyle(
// //                             color: Colors.white,
// //                             fontWeight: FontWeight.bold,
// //                             fontSize: 14,
// //                           ),
// //                         );
// //                       },
// //                     ),
// //                     handleBuiltInTouches: true,
// //                   ),
// //                   titlesData: FlTitlesData(
// //                     show: true,
// //                     bottomTitles: AxisTitles(
// //                       sideTitles: SideTitles(
// //                         showTitles: true,
// //                         reservedSize: 40,
// //                         getTitlesWidget: (value, meta) {
// //                           const style = TextStyle(
// //                             color: Colors.white,
// //                             fontWeight: FontWeight.bold,
// //                             fontSize: 14,
// //                           );
// //                           String text;
// //                           switch (value.toInt()) {
// //                             case 0:
// //                               text = 'Lun';
// //                               break;
// //                             case 1:
// //                               text = 'Mar';
// //                               break;
// //                             case 2:
// //                               text = 'Mie';
// //                               break;
// //                             case 3:
// //                               text = 'Jue';
// //                               break;
// //                             case 4:
// //                               text = 'Vie';
// //                               break;
// //                             case 5:
// //                               text = 'Sab';
// //                               break;
// //                             case 6:
// //                               text = 'Dom';
// //                               break;
// //                             default:
// //                               text = '';
// //                               break;
// //                           }
// //                           return SideTitleWidget(
// //                             axisSide: meta.axisSide,
// //                             child: Text(text, style: style),
// //                           );
// //                         },
// //                       ),
// //                     ),
// //                     leftTitles: AxisTitles(
// //                       sideTitles: SideTitles(
// //                         showTitles: true,
// //                         reservedSize: 40,
// //                         getTitlesWidget: (value, meta) {
// //                           return Text(
// //                             value.toInt().toString(),
// //                             style: const TextStyle(
// //                               color: Colors.white,
// //                               fontWeight: FontWeight.bold,
// //                               fontSize: 14,
// //                             ),
// //                           );
// //                         },
// //                       ),
// //                     ),
// //                     rightTitles: AxisTitles(
// //                       sideTitles: SideTitles(showTitles: false),
// //                     ),
// //                     topTitles: AxisTitles(
// //                       sideTitles: SideTitles(showTitles: false),
// //                     ),
// //                   ),
// //                   borderData: FlBorderData(
// //                     show: true,
// //                     border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
// //                   ),
// //                   barGroups: [
// //                     BarChartGroupData(
// //                       x: 0,
// //                       barRods: [
// //                         BarChartRodData(
// //                           toY: 8,
// //                           color: const Color(0xFF0BBE66), // Cambia a tu color específico
// //                           borderRadius: BorderRadius.circular(5), // Ajusta el radio de los bordes
// //                           width: 25, // Ajusta el ancho de las barras
// //                         ),
// //                       ],
// //                     ),
// //                     BarChartGroupData(
// //                       x: 1,
// //                       barRods: [
// //                         BarChartRodData(
// //                           toY: 10,
// //                           color: const Color(0xFF0BBE66), // Cambia a tu color específico
// //                           borderRadius: BorderRadius.circular(5),
// //                           width: 25,
// //                         ),
// //                       ],
// //                     ),
// //                     BarChartGroupData(
// //                       x: 2,
// //                       barRods: [
// //                         BarChartRodData(
// //                           toY: 14,
// //                           color: const Color(0xFF0BBE66), // Cambia a tu color específico
// //                           borderRadius: BorderRadius.circular(5),
// //                           width: 25,
// //                         ),
// //                       ],
// //                     ),
// //                     BarChartGroupData(
// //                       x: 3,
// //                       barRods: [
// //                         BarChartRodData(
// //                           toY: 15,
// //                           color: const Color(0xFF0BBE66), // Cambia a tu color específico
// //                           borderRadius: BorderRadius.circular(5),
// //                           width: 25,
// //                         ),
// //                       ],
// //                     ),
// //                     BarChartGroupData(
// //                       x: 4,
// //                       barRods: [
// //                         BarChartRodData(
// //                           toY: 13,
// //                           color: const Color(0xFF0BBE66), // Cambia a tu color específico
// //                           borderRadius: BorderRadius.circular(5),
// //                           width: 25,
// //                         ),
// //                       ],
// //                     ),
// //                     BarChartGroupData(
// //                       x: 5,
// //                       barRods: [
// //                         BarChartRodData(
// //                           toY: 10,
// //                           color: const Color(0xFF0BBE66), // Cambia a tu color específico
// //                           borderRadius: BorderRadius.circular(5),
// //                           width: 25,
// //                         ),
// //                       ],
// //                     ),
// //                     BarChartGroupData(
// //                       x: 6,
// //                       barRods: [
// //                         BarChartRodData(
// //                           toY: 8,
// //                           color: const Color(0xFF0BBE66), // Cambia a tu color específico
// //                           borderRadius: BorderRadius.circular(5),
// //                           width: 25,
// //                         ),
// //                       ],
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class GraficaDeBarras extends StatelessWidget {
//   const GraficaDeBarras({super.key});

//   Future<Map<String, int>?> fetchData() async {
//     const String apiUrl =
//         'https://backendsenauthenticator.up.railway.app/api/usuarios/';
//     final response = await http.get(Uri.parse(apiUrl));

//     if (response.statusCode == 200) {
//       final List<dynamic> data = json.decode(response.body);
//       Map<String, int> roleCounts = {};
//       for (var user in data) {
//         String role = user['rol_usuario'] ?? 'Desconocido';
//         roleCounts[role] = (roleCounts[role] ?? 0) + 1;
//       }
//       return roleCounts;
//     } else {
//       return null;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         children: [
//           Container(
//             width: double.infinity,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(15),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.3),
//                   spreadRadius: 2,
//                   blurRadius: 5,
//                   offset: const Offset(0, 3),
//                 ),
//               ],
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 children: [
//                   const Text(
//                     "Resumen de entrada",
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 16.0),
//                   FutureBuilder<Map<String, int>?>( // Mantén este código
//                     future: fetchData(),
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return const CircularProgressIndicator();
//                       } else if (snapshot.hasError) {
//                         return Text('Error: ${snapshot.error}');
//                       } else if (snapshot.data == null || snapshot.data!.isEmpty) {
//                         return const Text('No hay datos disponibles');
//                       } else {
//                         final roleCounts = snapshot.data!;
//                         return Container(
//                           height: 400,
//                           margin: const EdgeInsets.only(bottom: 10),
//                           padding: const EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(15),
//                             border: Border.all(color: Colors.grey, width: 1),
//                           ),
//                           child: BarChart(
//                             BarChartData(
//                               barGroups: roleCounts.entries
//                                   .map(
//                                     (entry) => BarChartGroupData(
//                                       x: roleCounts.keys.toList().indexOf(entry.key),
//                                       barRods: [
//                                         BarChartRodData(
//                                           toY: entry.value.toDouble(),
//                                           color: Colors.blueAccent,
//                                           width: 30,
//                                           borderRadius: const BorderRadius.all(Radius.circular(5)),
//                                           backDrawRodData: BackgroundBarChartRodData(
//                                             show: true,
//                                             toY: roleCounts.values.reduce((a, b) => a > b ? a : b).toDouble(),
//                                             color: Colors.blue.withOpacity(0.1),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   )
//                                   .toList(),
//                               titlesData: FlTitlesData(
//                                 leftTitles: AxisTitles(
//                                   sideTitles: SideTitles(
//                                     showTitles: true,
//                                     reservedSize: 40,
//                                     interval: 2,
//                                     getTitlesWidget: (value, meta) {
//                                       if (value % 1 != 0) return Container();
//                                       return Text(
//                                         value.toInt().toString(),
//                                         style: const TextStyle(
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 ),
//                                 bottomTitles: AxisTitles(
//                                   sideTitles: SideTitles(
//                                     showTitles: true,
//                                     interval: 1,
//                                     getTitlesWidget: (value, meta) {
//                                       final roleNames = roleCounts.keys.toList();
//                                       if (value < 0 || value >= roleNames.length) {
//                                         return const SizedBox();
//                                       }
//                                       return Padding(
//                                         padding: const EdgeInsets.only(top: 8.0),
//                                         child: Text(
//                                           roleNames[value.toInt()],
//                                           style: const TextStyle(
//                                             fontSize: 12,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                           textAlign: TextAlign.center,
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 ),
//                               ),
//                               gridData: const FlGridData(
//                                 show: true,
//                                 horizontalInterval: 1,
//                                 drawVerticalLine: false,
//                               ),
//                               borderData: FlBorderData(
//                                 show: true,
//                                 border: Border.all(color: Colors.black.withOpacity(0.1), width: 1),
//                               ),
//                             ),
//                           ),
//                         );
//                       }
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class GraficaDeBarras extends StatefulWidget {
  const GraficaDeBarras({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GraficaDeBarrasState createState() => _GraficaDeBarrasState();
}

class _GraficaDeBarrasState extends State<GraficaDeBarras> {
  late Future<Map<String, int>?> _fetchDataFuture;

  @override
  void initState() {
    super.initState();
    _fetchDataFuture = fetchData();
  }

  // Función para obtener los datos desde la API
  Future<Map<String, int>?> fetchData() async {
    const String apiUrl =
        'https://backendsenauthenticator.up.railway.app/api/usuarios/';
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (kDebugMode) {
        print('Fetching data from API: $apiUrl');
      } // Depuración

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        if (kDebugMode) {
          print('API response data: $data');
        } // Depuración

        // Mapa para contar usuarios por día de la semana
        Map<String, int> dayCounts = {
          'Lunes': 0,
          'Martes': 0,
          'Miércoles': 0,
          'Jueves': 0,
          'Viernes': 0,
          'Sábado': 0,
          'Domingo': 0,
        };

        for (var user in data) {
          String dateString = user['date_joined'] ?? '';
          if (dateString.isNotEmpty) {
            DateTime date = DateTime.parse(dateString);
            String dayName = DateFormat('EEEE').format(date);
            dayCounts[dayName] = (dayCounts[dayName] ?? 0) + 1;
          }
        }

        if (kDebugMode) {
          print('Day counts: $dayCounts');
        } // Depuración
        return dayCounts;
      } else {
        if (kDebugMode) {
          print('Error en la conexión: ${response.statusCode}');
        }
        return null; // Retorna null si hay un error
      }
    } catch (e) {
      if (kDebugMode) {
        print('Exception en fetchData: $e');
      } // Depuración
      return null;
    }
  }

  // Función para construir el BarChart
  Widget buildBarChart(Map<String, int> dayCounts) {
    // Filtra solo los días con al menos un usuario
    final filteredCounts =
        dayCounts.entries.where((entry) => entry.value > 0).toList();

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: filteredCounts.isNotEmpty
            ? filteredCounts
                    .map((e) => e.value)
                    .reduce((a, b) => a > b ? a : b)
                    .toDouble() +
                1
            : 10, // Ajusta el maxY
        barGroups: filteredCounts
            .map(
              (entry) => BarChartGroupData(
                x: filteredCounts.indexOf(entry),
                barRods: [
                  BarChartRodData(
                    toY: entry.value.toDouble(),
                    color: Colors.blueAccent,
                    width: 30, // Ancho de la barra
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      toY: filteredCounts
                          .map((e) => e.value)
                          .reduce((a, b) => a > b ? a : b)
                          .toDouble(),
                      color: Colors.blue.withOpacity(0.1),
                    ),
                  ),
                ],
              ),
            )
            .toList(),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              interval: 1,
              getTitlesWidget: (value, meta) {
                if (value % 1 != 0) return Container();
                return Text(
                  value.toInt().toString(),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              getTitlesWidget: (value, meta) {
                if (value < 0 || value >= filteredCounts.length) {
                  return const SizedBox();
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    filteredCounts[value.toInt()].key,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              },
            ),
          ),
        ),
        gridData: FlGridData(
          show: true,
          horizontalInterval: 1,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (value) => FlLine(
            color: Colors.grey.withOpacity(0.5),
            strokeWidth: 0.8,
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: const Border(
            bottom: BorderSide(color: Colors.black, width: 1),
            left: BorderSide(color: Colors.black, width: 1),
          ),
        ),
        groupsSpace: 50, // Aumenta el espacio entre grupos de barras
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text(
                        "Distribución de usuarios registrados por día de la semana",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16.0),
                      FutureBuilder<Map<String, int>?>(
                        future: _fetchDataFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (snapshot.data == null ||
                              snapshot.data!.isEmpty) {
                            return const Text('No hay datos disponibles');
                          } else {
                            final dayCounts = snapshot.data!;
                            if (kDebugMode) {
                              print(
                                  'Building BarChart with dayCounts: $dayCounts');
                            } // Depuración

                            return Container(
                              height: 500, // Aumenta la altura de la gráfica
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                              ),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: SizedBox(
                                  width:
                                      600, // Ancho fijo, puedes ajustar según sea necesario
                                  child: buildBarChart(dayCounts),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ],
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
