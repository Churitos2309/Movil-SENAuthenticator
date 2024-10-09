import 'package:flutter/material.dart';

import 'graficas/lineal.dart';

class Graficas extends StatelessWidget {
  const Graficas({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        // Gráfica Circular
        // GraficaCircular(),
        SizedBox(height: 16.0), // Espacio entre las gráficas
        // Gráfica Lineal
        GraficaDeBarras(), // Asegúrate de agregar la constante aquí
      ],
    );
  }
}
