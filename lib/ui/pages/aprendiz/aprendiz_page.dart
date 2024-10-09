import 'package:flutter/material.dart';
import 'package:reconocimiento_app/ui/pages/aprendiz/components/bottom_navbar_aprendiz.dart';
import 'package:reconocimiento_app/ui/pages/aprendiz/components/custom_app_bar_aprendiz.dart';

class AprendizPage extends StatefulWidget {
  final Widget body;
  final int currentIndex;

  const AprendizPage({super.key, required this.body, required this.currentIndex});

  @override
  // ignore: library_private_types_in_public_api
  _AprendizPageState createState() => _AprendizPageState();
}

class _AprendizPageState extends State<AprendizPage> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarAprendiz(title: 'Aprendiz'),
      body: widget.body,
      bottomNavigationBar: const BottomNavbarAprendiz(
        // currentIndex: widget.currentIndex,
        // onItemTapped: _onItemTapped,
      ),
    );
  }
}