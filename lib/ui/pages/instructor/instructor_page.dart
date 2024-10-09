import 'package:flutter/material.dart';
import 'package:reconocimiento_app/ui/pages/instructor/components/bottom_navbar_instructor.dart';
import 'package:reconocimiento_app/ui/pages/instructor/components/custom_app_bar_instructor.dart';
import 'package:reconocimiento_app/ui/router.dart';

class InstructorPage extends StatefulWidget {
  final Widget body;
  final int currentIndex;

  const InstructorPage({super.key, required this.body, required this.currentIndex});

  @override
  // ignore: library_private_types_in_public_api
  _InstructorPageState createState() => _InstructorPageState();
}

class _InstructorPageState extends State<InstructorPage> {

  @override
  void initState() {
    super.initState();
  }

  // ignore: unused_element
  void _onItemTapped(int index) {
    setState(() {
    });

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, Routes.homeAprendiz);
        break;
      case 1:
        Navigator.pushReplacementNamed(context, Routes.objetos);
        break;
      case 2:
        Navigator.pushReplacementNamed(context, Routes.historial);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarInstructor(title: 'Aprendiz'),
      body: widget.body,
      bottomNavigationBar: const BottomNavbarInstructor(
        // currentIndex: widget.currentIndex,
        // onItemTapped: _onItemTapped,
      ),
    );
  }
}