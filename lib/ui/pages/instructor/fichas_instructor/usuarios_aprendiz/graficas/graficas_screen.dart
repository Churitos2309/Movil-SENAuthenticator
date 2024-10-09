import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:reconocimiento_app/services/api_services.dart';

// Datos de la Gráfica Circular
List<PieChartSectionData> pieChartSelectionData = [
  PieChartSectionData(
    color: const Color(0xFF39A900),
    value: 25,
    showTitle: false,
    radius: 25,
  ),
  PieChartSectionData(
    color: const Color(0xFF26E5FF),
    value: 20,
    showTitle: false,
    radius: 22,
  ),
  PieChartSectionData(
    color: const Color(0xFFFFCF26),
    value: 10,
    showTitle: false,
    radius: 19,
  ),
  PieChartSectionData(
    color: const Color(0xFFEE2727),
    value: 15,
    showTitle: false,
    radius: 16,
  ),
  PieChartSectionData(
    color: const Color(0xFF39A900).withOpacity(0.1),
    value: 25,
    showTitle: false,
    radius: 13,
  ),
];

class GraficasInstructorScreen extends StatefulWidget {
  const GraficasInstructorScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GraficasInstructorScreenState createState() =>
      _GraficasInstructorScreenState();
}

class _GraficasInstructorScreenState extends State<GraficasInstructorScreen> {
  late Future<Map<String, dynamic>> _graficaData;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _graficaData = fetchData();
  }

  Future<Map<String, dynamic>> fetchData() async {
    try {
      final data = await apiService.get('usuarios/');
      Map<String, int> generoCounts = {
        'Masculino': 0,
        'Femenino': 0,
      };

      for (var usuario in data) {
        String genero = usuario['genero_usuario'];
        if (generoCounts.containsKey(genero)) {
          generoCounts[genero] = generoCounts[genero]! + 1;
        }
      }

      int total = generoCounts.values.reduce((a, b) => a + b);
      List<PieChartSectionData> pieData = generoCounts.entries.map((entry) {
        return PieChartSectionData(
          color: entry.key == 'Masculino'
              ? const Color(0xFF4CAF50)
              : const Color(0xFFFF5722),
          value: (entry.value / total) * 100,
          title: '${(entry.value / total * 100).toStringAsFixed(1)}%',
          radius: 50.0,
          titleStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        );
      }).toList();

      return {
        'pieData': pieData,
      };
    } catch (e) {
      print('Error fetching data: $e');
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Gráfica Circular en su propio recuadro
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
                        "Gráfica Circular",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      FutureBuilder<Map<String, dynamic>>(
                        future: _graficaData,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (snapshot.hasData) {
                            final data = snapshot.data!;
                            return SizedBox(
                              height: 200,
                              child: Stack(
                                children: [
                                  PieChart(
                                    PieChartData(
                                      sectionsSpace: 0,
                                      centerSpaceRadius: 70,
                                      startDegreeOffset: -90,
                                      sections: data['pieData'],
                                    ),
                                  ),
                                  Positioned.fill(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const SizedBox(height: 16.0),
                                        Text(
                                          "${(data['pieData'][0].value).toStringAsFixed(1)}%",
                                          style: const TextStyle(
                                            fontSize: 24,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            height: 0.5,
                                          ),
                                        ),
                                        const Text(
                                          "porcentaje",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return const Center(
                                child: Text('No data available'));
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0), // Espacio entre las gráficas
              // Gráfica de Línea de Frecuencia en su propio recuadro
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
                        "Gráfica de Línea",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Container(
                        height: 200, // Ajusta el tamaño según necesites
                        margin: const EdgeInsets.only(bottom: 10), // Margen adicional
                        padding: const EdgeInsets.all(10), // Espacio interno para separar la gráfica del borde
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.grey, width: 1), // Borde del contenedor
                        ),
                        child: BarChart(
                          BarChartData(
                            barGroups: [
                              BarChartGroupData(
                                x: 0,
                                barRods: [
                                  BarChartRodData(
                                    toY: 8, // Valor para Lun
                                    color: const Color(0xFF39A900),
                                    width: 40, // Ancho de la barra
                                    borderRadius: BorderRadius.zero, // Sin bordes en la barra
                                  ),
                                ],
                              ),
                              BarChartGroupData(
                                x: 1,
                                barRods: [
                                  BarChartRodData(
                                    toY: 10, // Valor para Mar
                                    color: const Color(0xFF39A900),
                                    width: 40,
                                    borderRadius: BorderRadius.zero,
                                  ),
                                ],
                              ),
                              BarChartGroupData(
                                x: 2,
                                barRods: [
                                  BarChartRodData(
                                    toY: 14, // Valor para Mie
                                    color: const Color(0xFF39A900),
                                    width: 40,
                                    borderRadius: BorderRadius.zero,
                                  ),
                                ],
                              ),
                              BarChartGroupData(
                                x: 3,
                                barRods: [
                                  BarChartRodData(
                                    toY: 15, // Valor para Jue
                                    color: const Color(0xFF39A900),
                                    width: 40,
                                    borderRadius: BorderRadius.zero,
                                  ),
                                ],
                              ),
                              BarChartGroupData(
                                x: 4,
                                barRods: [
                                  BarChartRodData(
                                    toY: 13, // Valor para Vie
                                    color: const Color(0xFF39A900),
                                    width: 40,
                                    borderRadius: BorderRadius.zero,
                                  ),
                                ],
                              ),
                              BarChartGroupData(
                                x: 5,
                                barRods: [
                                  BarChartRodData(
                                    toY: 10, // Valor para Sab
                                    color: const Color(0xFF39A900),
                                    width: 40,
                                    borderRadius: BorderRadius.zero,
                                  ),
                                ],
                              ),
                              BarChartGroupData(
                                x: 6,
                                barRods: [
                                  BarChartRodData(
                                    toY: 8, // Valor para Dom
                                    color: const Color(0xFF39A900),
                                    width: 40,
                                    borderRadius: BorderRadius.zero,
                                  ),
                                ],
                              ),
                            ],
                            titlesData: FlTitlesData(
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 40,
                                  getTitlesWidget: (value, meta) {
                                    return Text(value.toInt().toString());
                                  },
                                ),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) {
                                    switch (value.toInt()) {
                                      case 0:
                                        return const Text('Lun');
                                      case 1:
                                        return const Text('Mar');
                                      case 2:
                                        return const Text('Mie');
                                      case 3:
                                        return const Text('Jue');
                                      case 4:
                                        return const Text('Vie');
                                      case 5:
                                        return const Text('Sab');
                                      case 6:
                                        return const Text('Dom');
                                      default:
                                        return const Text('');
                                    }
                                  },
                                ),
                              ),
                            ),
                            borderData: FlBorderData(show: false), // Sin borde alrededor de la gráfica
                            gridData: const FlGridData(
                              show: true,
                              drawVerticalLine: false, // Eliminamos líneas verticales
                            ),
                          ),
                        ),
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
