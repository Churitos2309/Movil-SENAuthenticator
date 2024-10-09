import 'package:flutter/material.dart';

class ScrollProvider extends ChangeNotifier {
  double homePosition = 0.0;
  double sobreNosotrosPosition = 770.0;
  double sobreAppPosition = 1100.0;
  double testimoniosPosition = 2010.0;
  // final double _sobre = 600.0;

  final ScrollController scrollController = ScrollController();

  List<Color> primaryColors = [
  const Color(0xFF00695C), // Verde Selva (profundo y elegante)
  const Color(0xFF43A047), // Verde Pasto (fresco y vibrante)
  const Color(0xFFB2DFDB), // Verde Claro (suave y luminoso)
];


List<Color> secondaryColors = [
  const Color(0xFF1B5E20), // Verde Bosque (oscuro y elegante)
  const Color(0xFF4DB6AC), // Verde Aguamarina (tranquilo y moderno)
  const Color(0xFF009688), // Verde Teal (dinámico y equilibrado)
];



  // double get homePosition => _homePosition;
  // double get sobreNosotrosPosition => _sobreNosotrosPosition;
  // double get sobreAppPosition => _sobreAppPosition;
  // double get testimoniosPostion => _testimoniosPosition;
  // ScrollController get scrollController => _scrollController;

  void scrollToPosition(double position) {
    scrollController.animateTo(
      position,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  int getIndexByScroll(){
    double offset = scrollController.offset;
    if (offset >= testimoniosPosition -10) {
      return 3;
    } else if (offset >= sobreAppPosition - 10) {
      return 2;
    } else if (offset >= sobreNosotrosPosition -10) {
      return 1;
    } else {
      return 0;
    }
  }
}


