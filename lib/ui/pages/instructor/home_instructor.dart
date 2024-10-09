import 'package:flutter/material.dart';
import 'dart:math'; // Para seleccionar aleatoriamente
import 'package:reconocimiento_app/services/api_services.dart';
import 'fichas_instructor/usuarios_aprendiz/usuarios.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Para iconos modernos

class HomeScreenInstructor extends StatefulWidget {
  const HomeScreenInstructor({super.key});

  @override
  State<HomeScreenInstructor> createState() => _HomeScreenInstructorState();
}

class _HomeScreenInstructorState extends State<HomeScreenInstructor>
    with SingleTickerProviderStateMixin {
  final ApiService apiService = ApiService();
  List<dynamic> fichas = [];
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    fetchFichas();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Función para obtener fichas de la API
  void fetchFichas() async {
    try {
      final data = await apiService.get('fichas/');
      setState(() {
        fichas = data;
      });
    } catch (e) {
      print('Error obteniendo fichas: $e');
    }
  }

  // Función para obtener datos aleatorios de la API
  Map<String, dynamic> obtenerDatosAleatorios() {
    final random = Random();
    if (fichas.isNotEmpty) {
      final fichaAleatoria = fichas[random.nextInt(fichas.length)];
      return {
        'numero_ficha': fichaAleatoria['numero_ficha'] ?? 'No disponible',
        'jornada_ficha': fichaAleatoria['jornada_ficha'] ?? 'No disponible',
        'aprendices_actuales_ficha':
            fichaAleatoria['aprendices_actuales_ficha']?.toString() ??
                'No disponible',
        'ficha_id': fichaAleatoria['id'], // Agregamos ficha_id para navegar
      };
    } else {
      return {
        'numero_ficha': 'Cargando...',
        'jornada_ficha': 'Cargando...',
        'aprendices_actuales_ficha': 'Cargando...',
        'ficha_id': null, // Sin ficha disponible
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    // Llama a obtenerDatosAleatorios para los 5 campos
    final datosCampo1 = obtenerDatosAleatorios();
    final datosCampo2 = obtenerDatosAleatorios();
    final datosCampo3 = obtenerDatosAleatorios();
    final datosCampo4 = obtenerDatosAleatorios();
    final datosCampo5 = obtenerDatosAleatorios();

    return Scaffold(
      body: FadeTransition(
        opacity: _animation,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              children: [
                // Campo 1
                FieldCard(
                  title: datosCampo1['numero_ficha'],
                  description: datosCampo1['jornada_ficha'],
                  buttonText: datosCampo1['aprendices_actuales_ficha'],
                  onPressed: () {
                    // Navegación a UsuariosScreen con transición personalizada
                    if (datosCampo1['ficha_id'] != null) {
                      Navigator.push(
                        context,
                        _createRoute(
                          UsuariosScreen(
                            fichaId: datosCampo1['ficha_id'],
                            numeroFicha: datosCampo1['numero_ficha'],
                          ),
                        ),
                      );
                    }
                  },
                  imagePath: 'images/login/sena-cauca.jpg', // Imagen de fondo
                ),
                const SizedBox(height: defaultPadding), // Espacio entre campos

                // Campo 2
                FieldCard(
                  title: datosCampo2['numero_ficha'],
                  description: datosCampo2['jornada_ficha'],
                  buttonText: datosCampo2['aprendices_actuales_ficha'],
                  onPressed: () {
                    // Navegación a UsuariosScreen con transición personalizada
                    if (datosCampo2['ficha_id'] != null) {
                      Navigator.push(
                        context,
                        _createRoute(
                          UsuariosScreen(
                            fichaId: datosCampo2['ficha_id'],
                            numeroFicha: datosCampo2['numero_ficha'],
                          ),
                        ),
                      );
                    }
                  },
                  imagePath: 'images/login/SENA1.jpg', // Imagen de fondo
                ),
                const SizedBox(height: defaultPadding), // Espacio entre campos

                // Campo 3
                FieldCard(
                  title: datosCampo3['numero_ficha'],
                  description: datosCampo3['jornada_ficha'],
                  buttonText: datosCampo3['aprendices_actuales_ficha'],
                  onPressed: () {
                    // Navegación a UsuariosScreen con transición personalizada
                    if (datosCampo3['ficha_id'] != null) {
                      Navigator.push(
                        context,
                        _createRoute(
                          UsuariosScreen(
                            fichaId: datosCampo3['ficha_id'],
                            numeroFicha: datosCampo3['numero_ficha'],
                          ),
                        ),
                      );
                    }
                  },
                  imagePath: 'images/login/SENACAUCA.jpg', // Imagen de fondo
                ),

                const SizedBox(height: defaultPadding), // Espacio entre campos

                // Campo 4
                FieldCard(
                  title: datosCampo4['numero_ficha'],
                  description: datosCampo4['jornada_ficha'],
                  buttonText: datosCampo4['aprendices_actuales_ficha'],
                  onPressed: () {
                    // Navegación a UsuariosScreen con transición personalizada
                    if (datosCampo4['ficha_id'] != null) {
                      Navigator.push(
                        context,
                        _createRoute(
                          UsuariosScreen(
                            fichaId: datosCampo4['ficha_id'],
                            numeroFicha: datosCampo4['numero_ficha'],
                          ),
                        ),
                      );
                    }
                  },
                  imagePath: 'images/login/SENA1.jpg', // Imagen de fondo
                ),
                const SizedBox(height: defaultPadding), // Espacio entre campos

                // Campo 5
                FieldCard(
                  title: datosCampo5['numero_ficha'],
                  description: datosCampo5['jornada_ficha'],
                  buttonText: datosCampo5['aprendices_actuales_ficha'],
                  onPressed: () {
                    // Navegación a UsuariosScreen con transición personalizada
                    if (datosCampo5['ficha_id'] != null) {
                      Navigator.push(
                        context,
                        _createRoute(
                          UsuariosScreen(
                            fichaId: datosCampo5['ficha_id'],
                            numeroFicha: datosCampo5['numero_ficha'],
                          ),
                        ),
                      );
                    }
                  },
                  imagePath: 'images/login/SENACAUCA.jpg', // Imagen de fondo
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Función para crear una ruta con transición personalizada
  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // Deslizar desde la derecha
        const end = Offset.zero;
        const curve = Curves.ease;

        final tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}

// Nuevo Widget para manejar la animación e interactividad de cada campo
class FieldCard extends StatefulWidget {
  final String title;
  final String description;
  final String buttonText;
  final VoidCallback onPressed;
  final String imagePath;

  const FieldCard({
    Key? key,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.onPressed,
    required this.imagePath,
  }) : super(key: key);

  @override
  State<FieldCard> createState() => _FieldCardState();
}

class _FieldCardState extends State<FieldCard>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  bool _isTapped = false;

  // Controlador para la animación de escala
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });

    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 1.05).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.easeOut,
    ));
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _isTapped = true;
    });
    _scaleController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _isTapped = false;
    });
    _scaleController.reverse();
  }

  void _onTapCancel() {
    setState(() {
      _isTapped = false;
    });
    _scaleController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
      },
      child: GestureDetector(
        onTap: widget.onPressed,
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: AnimatedScale(
          scale: _isHovered || _isTapped ? 1.05 : 1.0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          child: SizedBox(
            width: double.infinity, // Ancho igual al del contenedor padre
            height: 220.0, // Alto ajustado para mejor visualización
            child: Stack(
              children: [
                // Fondo con gradiente moderno
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    gradient: LinearGradient(
                      colors: [
                        Colors.teal.shade700.withOpacity(0.8),
                        Colors.teal.shade300.withOpacity(0.8),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.teal.withOpacity(0.4),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: const Offset(0, 6), // Sombra más pronunciada
                      ),
                    ],
                  ),
                ),
                // Imagen de fondo con opacidad
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(
                      image: AssetImage(
                          widget.imagePath), // Ruta de la imagen de fondo
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.3), // Opacidad ajustada
                        BlendMode.darken,
                      ),
                    ),
                  ),
                ),
                // Icono de cámara
                // Positioned(
                //   top: 16.0,
                //   right: 16.0,
                //   child: Container(
                //     padding: const EdgeInsets.all(8.0),
                //     decoration: BoxDecoration(
                //       color: Colors.white.withOpacity(0.7),
                //       shape: BoxShape.circle,
                //       boxShadow: [
                //         BoxShadow(
                //           color: Colors.black.withOpacity(0.2),
                //           spreadRadius: 2,
                //           blurRadius: 6,
                //           offset: const Offset(0, 3),
                //         ),
                //       ],
                //     ),
                //     // child: const FaIcon(
                //     //   FontAwesomeIcons.camera,
                //     //   color: Colors.teal,
                //     //   size: 20.0,
                //     // ),
                //   ),
                // ),
                // Contenido del campo
                Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Fondo degradado para el título
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6.0,
                            horizontal: 10.0), // Padding ajustado
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withOpacity(0.7),
                              Colors.transparent
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          widget.title,
                          style: const TextStyle(
                            fontSize: 22, // Tamaño de fuente aumentado
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Contraste con el fondo
                          ),
                        ),
                      ),
                      const SizedBox(
                          height:
                              8.0), // Espacio entre el título y la descripción

                      // Fondo degradado para la descripción
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 8.0), // Padding ajustado
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withOpacity(0.6),
                              Colors.transparent
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          widget.description,
                          style: const TextStyle(
                            fontSize: 16, // Tamaño de fuente aumentado
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const Spacer(), // Empuja la etiqueta hacia abajo

                      // Etiqueta estilizada
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6.0, horizontal: 12.0),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const FaIcon(
                              FontAwesomeIcons.users,
                              color: Colors.teal,
                              size: 16.0,
                            ),
                            const SizedBox(width: 6.0),
                            Text(
                              widget.buttonText,
                              style: const TextStyle(
                                fontSize: 16, // Tamaño de fuente ajustado
                                fontWeight: FontWeight.bold,
                                color: Colors.black87, // Contraste con el fondo
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

const defaultPadding = 16.0;
