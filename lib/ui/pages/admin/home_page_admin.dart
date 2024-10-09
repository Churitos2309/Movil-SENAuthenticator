import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreenAdmin extends StatefulWidget {
  const HomeScreenAdmin({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenAdminState createState() => _HomeScreenAdminState();
}

class _HomeScreenAdminState extends State<HomeScreenAdmin> {
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
        Map<String, int> roleCounts = {};
        for (var user in data) {
          String role = user['rol_usuario'] ?? 'Desconocido';
          roleCounts[role] = (roleCounts[role] ?? 0) + 1;
        }
        if (kDebugMode) {
          print('Role counts: $roleCounts');
        } // Depuración
        return roleCounts;
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
  Widget buildBarChart(Map<String, int> roleCounts, double chartWidth) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: roleCounts.values.isNotEmpty
            ? roleCounts.values.reduce((a, b) => a > b ? a : b).toDouble() + 5
            : 10, // Ajusta el maxY
        barGroups: roleCounts.entries
            .map(
              (entry) => BarChartGroupData(
                x: roleCounts.keys.toList().indexOf(entry.key),
                barRods: [
                  BarChartRodData(
                    toY: entry.value.toDouble(),
                    color: Colors.blueAccent,
                    width: 30, // Ancho de la barra
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      toY: roleCounts.values
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
              interval: 2,
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
                final roleNames = roleCounts.keys.toList();
                if (value < 0 || value >= roleNames.length) {
                  return const SizedBox();
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    roleNames[value.toInt()],
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
        groupsSpace: 200, // Aumenta el espacio entre grupos de barras
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
                        "Distribución de personas en el SENA por su rol de usuario",
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
                            final roleCounts = snapshot.data!;
                            if (kDebugMode) {
                              print(
                                  'Building BarChart with roleCounts: $roleCounts');
                            } // Depuración

                            // Calcular el ancho necesario basado en la cantidad de roles
                            double chartWidth = roleCounts.length * 120.0;
                            double screenWidth =
                                MediaQuery.of(context).size.width;
                            if (chartWidth < screenWidth) {
                              chartWidth = screenWidth;
                            }

                            return Container(
                              height: 700, // Aumenta la altura de la gráfica
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
                                  width: chartWidth, // Ancho calculado
                                  child: buildBarChart(roleCounts, chartWidth),
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
