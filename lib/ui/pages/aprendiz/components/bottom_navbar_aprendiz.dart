import 'package:animate_gradient/animate_gradient.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reconocimiento_app/services/scroll_provider.dart';
import 'package:reconocimiento_app/ui/pages/aprendiz/components/custom_app_bar_aprendiz.dart';
import 'package:reconocimiento_app/ui/pages/aprendiz/historial_page_aprendiz.dart';
import 'package:reconocimiento_app/ui/pages/aprendiz/home_aprendiz_page.dart';
import 'package:reconocimiento_app/ui/pages/aprendiz/objetos_page.dart';

class BottomNavbarAprendiz extends StatefulWidget {
  const BottomNavbarAprendiz({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BottomNavbarAprendizState createState() => _BottomNavbarAprendizState();
}

class _BottomNavbarAprendizState extends State<BottomNavbarAprendiz>{
  int _currentIndex = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  final List<Widget> _screens = [
    const HomeAprendizScreen(),
    const ObjetosAprendizPage(),
    const HistorialAprendizPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final scrollProvider = Provider.of<ScrollProvider>(context);

    return Scaffold(
      appBar: const CustomAppBarAprendiz(title: 'Aprendiz'),
      // AppBar(
      //   title: Text('App Title'),
      // ),
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: AnimateGradient(
        primaryBeginGeometry: const AlignmentDirectional(0, 1),
        primaryEndGeometry: const AlignmentDirectional(0, 2),
        secondaryBeginGeometry: const AlignmentDirectional(2, 0),
        secondaryEndGeometry: const AlignmentDirectional(0, -0.8),
        primaryColors: scrollProvider.primaryColors,
        secondaryColors: scrollProvider.secondaryColors,
        child: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: _currentIndex,
          items: const <Widget>[
            Icon(Icons.home_outlined,
                size: 30, color: Color(0xFF27A900)), // Verde
            Icon(Icons.build_outlined,
                size: 30, color: Color(0xFF27A900)), // Verde
            Icon(Icons.info_outline,
                size: 30, color: Color(0xFF27A900)), // Verde
          ],
          color: const Color.fromARGB(164, 224, 224, 224), // Fondo gris claro
          buttonBackgroundColor: Colors.white,
          backgroundColor: Colors.white70,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 300),
          onTap: _onItemTapped,
        ),
      ),
      // BottomNavigationBar(
      //   currentIndex: _currentIndex,
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home_outlined, size: 30),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.build_outlined, size: 30),
      //       label: 'Build',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.info_outline, size: 30),
      //       label: 'Info',
      //     ),
      //   ],
      //   onTap: _onItemTapped,
      // ),
    );
  }
}
