import 'package:animate_gradient/animate_gradient.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reconocimiento_app/services/scroll_provider.dart';

class BottonNavScreen extends StatefulWidget {
  const BottonNavScreen({super.key});

  @override
  State<BottonNavScreen> createState() => _BottonNavScreenState();
}

class _BottonNavScreenState extends State<BottonNavScreen> {
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    final scrollProvider = Provider.of<ScrollProvider>(context, listen: false);

    // Escucha los cambios en el scroll
    scrollProvider.scrollController.addListener(() {
      final newIndex = scrollProvider.getIndexByScroll();
      if (newIndex != _currentIndex) {
        setState(() {
          _currentIndex = newIndex; // Actualiza el índice cuando cambie el scroll
        });
      }
    });
  }

  @override 
  Widget build(BuildContext context) {
    final scrollProvider = Provider.of<ScrollProvider>(context);

    return AnimateGradient(
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
          Icon(Icons.info_outline, size: 30, color: Color(0xFF27A900)), // Verde
          Icon(Icons.comment_outlined,
              size: 30, color: Color(0xFF27A900)), // Verde
        ],
        color: const Color.fromARGB(164, 224, 224, 224), // Fondo gris claro
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.white70,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        onTap: (index) {
          if (index == 0) {
            scrollProvider.scrollToPosition(scrollProvider
                .homePosition); // Scroll a la posición de "Inicio"
          } else if (index == 1) {
            scrollProvider.scrollToPosition(scrollProvider
                .sobreNosotrosPosition); // Scroll a la posición de "Sobre Nosotros"
          } else if (index == 2) {
            scrollProvider.scrollToPosition(scrollProvider
                .sobreAppPosition); // Scroll a la posición de "Contacto"
          } else if (index == 3) {
            scrollProvider.scrollToPosition(scrollProvider
                .testimoniosPosition); // Scroll a la posición de "Contacto"
          }
        },
      ),
    );
  }
}