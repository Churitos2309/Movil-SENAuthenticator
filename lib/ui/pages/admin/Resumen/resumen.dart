import 'package:flutter/material.dart';

class Resumen extends StatelessWidget {
  const Resumen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Resumen de Reportes',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.0), // Espacio entre el título y el texto
          Text(
            'Aquí puedes ver el resumen de las estadísticas sobre los datos '
            'presentados en el gráfico. Por ejemplo, puedes mostrar el promedio '
            'de aprendices por jornada, los días con mayor asistencia o cualquier '
            'otro dato relevante.',
            style: TextStyle(
              fontSize: 14, // Tamaño de letra más pequeño
              color: Colors.black54, // Color de letra más suave
            ),
            textAlign: TextAlign.center, // Centrar el texto
          ),
        ],
      ),
    );
  }
}
