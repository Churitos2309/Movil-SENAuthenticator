import 'package:flutter/material.dart';
import 'package:reconocimiento_app/ui/pages/instructor/instructor_page.dart';
class HomeInstructor extends StatelessWidget {
  const HomeInstructor({super.key});

  @override
  Widget build(BuildContext context) {
    return const InstructorPage(
      body: Center(
        child: Text('Esta es la página de inicio'),
      ),
      currentIndex: 0,
    );
  }
}