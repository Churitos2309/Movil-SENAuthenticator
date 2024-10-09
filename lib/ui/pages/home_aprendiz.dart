import 'package:flutter/material.dart';
import 'package:reconocimiento_app/ui/pages/aprendiz/aprendiz_page.dart';
class HomeAprendiz extends StatelessWidget {
  const HomeAprendiz({super.key});

  @override
  Widget build(BuildContext context) {
    return const AprendizPage(
      body: Center(
        child: Text('Esta es la página de inicio'),
      ),
      currentIndex: 0,
    );
  }
}