import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:reconocimiento_app/services/api_services.dart';

class GraficaCircular extends StatefulWidget {
  const GraficaCircular({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GraficaCircularState createState() => _GraficaCircularState();
}

class _GraficaCircularState extends State<GraficaCircular> {
  final ApiService apiService = ApiService();
  List<dynamic> fichas = [];
  bool isLoading = true;

  // Valores para la gráfica
  double totalMatriculados = 0;
  double valor1 = 0;
  double valor2 = 0;
  double valor3 = 0;
  double valor4 = 0;
  double valor5 = 0;

  // @override
  // void initState() {
  //   super.initState();
  //   fetchFichas();
  // }

  // void fetchFichas() async {
  //   try {
  //     final data = await apiService.get('ficha/');
  //     setState(() {
  //       fichas = data;
  //       calcularValores();
  //       isLoading = false; // Ocultar el indicador de carga
  //     });
  //   } catch (e) {
  //     print('Error al obtener fichas: $e');
  //   }
  // }

  void calcularValores() {
    totalMatriculados = fichas.fold(0, (sum, ficha) => sum + ficha['aprendices_matriculados_ficha']);

    // Dividimos los datos para cada sección del gráfico
    if (fichas.isNotEmpty) {
      valor1 = fichas[0]['aprendices_matriculados_ficha'] / totalMatriculados * 100;
      valor2 = fichas[1]['aprendices_matriculados_ficha'] / totalMatriculados * 100;
      valor3 = fichas[2]['aprendices_matriculados_ficha'] / totalMatriculados * 100;
      valor4 = fichas[3]['aprendices_matriculados_ficha'] / totalMatriculados * 100;
      valor5 = fichas[4]['aprendices_matriculados_ficha'] / totalMatriculados * 100;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
              "Resumen de Datos",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              "Se puede mostrar el promedio de aprendices por jornada, los días con mayor asistencia o cualquier otro dato relevante en el SENA CTPI.",
              style: TextStyle(
                fontSize: 12,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            isLoading
                ? const CircularProgressIndicator() // Muestra un spinner mientras se cargan los datos
                : SizedBox(
                    height: 200, // Ajusta el tamaño según necesites
                    child: PieChart(
                      PieChartData(
                        sectionsSpace: 0,
                        centerSpaceRadius: 70,
                        startDegreeOffset: -90,
                        sections: [
                          PieChartSectionData(
                            color: const Color(0xFF39A900),
                            value: valor1,
                            showTitle: false,
                            radius: 25,
                          ),
                          PieChartSectionData(
                            color: const Color(0xFF26E5FF),
                            value: valor2,
                            showTitle: false,
                            radius: 22,
                          ),
                          PieChartSectionData(
                            color: const Color(0xFFFFCF26),
                            value: valor3,
                            showTitle: false,
                            radius: 19,
                          ),
                          PieChartSectionData(
                            color: const Color(0xFFEE2727),
                            value: valor4,
                            showTitle: false,
                            radius: 16,
                          ),
                          PieChartSectionData(
                            color: const Color(0xFF800080),
                            value: valor5,
                            showTitle: false,
                            radius: 13,
                          ),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
