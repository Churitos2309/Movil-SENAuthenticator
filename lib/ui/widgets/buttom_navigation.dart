// Importa el paquete necesario de Flutter.
import 'package:flutter/material.dart';

// Definicion de la clase BottomNavigation, que extiende StatelessWidget.
class BottomNavigation extends StatelessWidget {
  // Define las propiedades de la clase.
  final int currentPage; // Indice de la pagina actual.
  final ValueChanged<int>
      onPageSelected; // Funcion llamada cuando se selecciona una pagina.

  // Constructor de la clase BottomNavigation.
  const BottomNavigation(
      {super.key, required this.currentPage, required this.onPageSelected});

  @override
  Widget build(BuildContext context) {
    // Retorna un BottomAppBar con una fila de iconos de boton.
    return BottomAppBar(
      child: Row(
        children: [
          // Icono de inicio con un IconButton.
          IconButton(
            icon: Icon(
              Icons.home,
              // Cambia el color del icono segun si currentPage es igual a 0.
              color: currentPage == 0
                  ? const Color.fromRGBO(203, 73, 101, 1) // Color activo.
                  : const Color.fromRGBO(40, 40, 40, 1), // Color inactivo.
            ),
            onPressed: () => onPageSelected(
                0), // Llama a la función onPageSelected cuando se presiona el boton.
          ),
          const Spacer(), // Añade un espacio entre los iconos.
          // Icono de búsqueda con un IconButton.
          IconButton(
            icon: Icon(
              Icons.search,
              // Cambia el color del icono segun si currentPage es igual a 1.
              color: currentPage == 1
                  ? const Color.fromRGBO(203, 73, 101, 1) // Color activo.
                  : const Color.fromRGBO(40, 40, 40, 1), // Color inactivo.
            ),
            onPressed: () => onPageSelected(
                1), // Llama a la funcion onPageSelected cuando se presiona el boton.
          ),
          const Spacer(), // Añade un espacio entre los iconos.
          // Icono de video bajo demanda con un IconButton.
          IconButton(
            icon: Icon(
              Icons.inbox,
              // Cambia el color del icono segun si currentPage es igual a 2.
              color: currentPage == 2
                  ? const Color.fromRGBO(203, 73, 101, 1) // Color activo.
                  : const Color.fromRGBO(40, 40, 40, 1), // Color inactivo.
            ),
            onPressed: () => onPageSelected(
                2), // Llama a la funcion onPageSelected cuando se presiona el boton.
          ),
          const Spacer(), // Añade un espacio entre los iconos.
          // Icono de viaje con un IconButton.
          IconButton(
            icon: Icon(
              Icons.camera,
              color: currentPage == 3
                  ? const Color.fromRGBO(203, 73, 101, 1)
                  : const Color.fromRGBO(40, 40, 40, 1),
            ),
            onPressed: () => onPageSelected(3),
          ),
          const Spacer(), // Añade un espacio entre los iconos.
          IconButton(
            icon: Icon(
              Icons.history,
              // Cambia el color del icono segun si currentPage es igual a 3.
              color: currentPage == 4
                  ? const Color.fromRGBO(203, 73, 101, 1) // Color activo.
                  : const Color.fromRGBO(40, 40, 40, 1), // Color inactivo.
            ),
            onPressed: () => onPageSelected(
                4), // Llama a la funcion onPageSelected cuando se presiona el boton.
          ),
          const Spacer(), // Añade un espacio entre los iconos.
          // Icono de perfil con un IconButton.
          IconButton(
            icon: Icon(
              Icons.person,
              // Cambia el color del icono segun si currentPage es igual a 4.
              color: currentPage == 5
                  ? const Color.fromRGBO(203, 73, 101, 1) // Color activo.
                  : const Color.fromRGBO(40, 40, 40, 1), // Color inactivo.
            ),
            onPressed: () => onPageSelected(
                5), // Llama a la funcion onPageSelected cuando se presiona el boton.
          ),
          const Spacer(),
          IconButton(
            icon: Icon(
              Icons.report,
              // Cambia el color del icono segun si currentPage es igual a 4.
              color: currentPage == 6
                  ? const Color.fromRGBO(203, 73, 101, 1) // Color activo.
                  : const Color.fromRGBO(40, 40, 40, 1), // Color inactivo.
            ),
            onPressed: () => onPageSelected(
                6), // Llama a la funcion onPageSelected cuando se presiona el boton.
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
