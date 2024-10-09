import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:reconocimiento_app/services/scroll_provider.dart';
import 'package:reconocimiento_app/ui/pages/buttom_nav_screen.dart';
import 'package:reconocimiento_app/ui/pages/custom_app_bar_lobby.dart';
import 'package:reconocimiento_app/ui/pages/custom_image_home.dart';
import 'package:reconocimiento_app/ui/router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Controlador para hacer scroll en la página
  ScrollController _scrollController = ScrollController();

  // Posiciones para hacer scroll

  // Bandera de carga
  final bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   // Se estima las posiciones de scroll una vez que se renderice la UI
    //   _calculatePositions();
    // }
  }

  @override
  Widget build(BuildContext context) {
    final scrollProvider = Provider.of<ScrollProvider>(context);

    return Scaffold(
        appBar: const CustomAppBarLobby(title: 'SENAuthenticator',),
        body: SingleChildScrollView(
          controller: scrollProvider.scrollController,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                _isLoading
                    ? const CircularProgressIndicator()
                    // const CardLoading(
                    //     height: 100,
                    //     borderRadius: BorderRadius.all(Radius.circular(10)),
                    //     margin: EdgeInsets.all(10),
                    //   )
                    : const Text(
                        'Bienvenido a SENAuthenticator',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                const CustomImageHome(),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    """Nuestra misión es ofrecer una solución de seguridad avanzada con tecnología de reconocimiento facial para proteger las instalaciones y asegurar un control de acceso eficiente.""",
                    style: TextStyle(fontSize: 17, color: Colors.grey[700]),
                    textAlign: TextAlign.justify,
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.perfil);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3C8DBC), // Azul claro
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Contáctanos',
                    textAlign: TextAlign.center,  
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  color: const Color.fromARGB(50, 158, 158, 158),
                  child: Column(
                    children: [
                      const Text(
                        'Sobre Nosotros',
                        style: TextStyle(
                          fontSize: 25,
                          fontStyle: FontStyle.italic,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      Row(
                        children: [
                          Image.network(
                            'https://cdn-icons-png.flaticon.com/512/2223/2223126.png',
                            cacheWidth: 200,
                          ),
                          // Image.asset(
                          //   'images/img/ReconocimientoFacial.webp',
                          //   cacheWidth: 200,
                          // ),
                          const Expanded(
                            child: Text(
                              'SENAuthenticator es una aplicación de Reconocimiento Facial con IA diseñada para ofrecer un control preciso y eficiente en instalaciones del SENA Alto Cauca.',
                              textAlign: TextAlign.justify,
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 310,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Nuestros Servicios',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          fontStyle: FontStyle.italic,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  _showModalCard(
                                    context,
                                    const Card(
                                      elevation: 5,
                                      child: Column(
                                        children: [
                                          Text('Reconocimiento Facial'),
                                          Text(
                                            'Utilizamos tecnología avanzada de reconocimiento facial para garantizar la seguridad en nuestras instalaciones.',
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                child: const Card(
                                  elevation: 5,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Reconocimiento Facial',
                                          style: TextStyle(
                                            decoration: TextDecoration.none,
                                            fontStyle: FontStyle.italic,
                                            fontSize: 16,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Utilizamos tecnología avanzada de reconocimiento facial para garantizar la seguridad en nuestras instalaciones.',
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                          maxLines: 4,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  _showModalCard(
                                    context,
                                    const Card(
                                      elevation: 5,
                                      child: Column(
                                        children: [
                                          Text('Monitoreo en tiempo real'),
                                          Text(
                                            'Monitorea en tiempo real las entradas y salidas, con alertas inmediatas ante cualquier irregularidad.',
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                child: const Card(
                                  elevation: 5,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Monitoreo en tiempo real',
                                          style: TextStyle(
                                            decoration: TextDecoration.none,
                                            fontStyle: FontStyle.italic,
                                            fontSize: 16,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Monitorea en tiempo real las entradas y salidas, con alertas inmediatas ante cualquier irregularidad.',
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                          maxLines: 4,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  _showModalCard(
                                    context,
                                    Card(
                                      borderOnForeground: true,
                                      shadowColor:
                                          Colors.green[200] ?? Colors.green,
                                      elevation: 5,
                                      child: const Column(
                                        children: [
                                          Text(
                                            'Reportes Detallados',
                                            style: TextStyle(
                                              decoration: TextDecoration.none,
                                              fontStyle: FontStyle.italic,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Text(
                                            'Genera reportes detallados de todas las actividades para un seguimiento exhaustivo.',
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                child: Card(
                                  borderOnForeground: true,
                                  shadowColor:
                                      Colors.green[200] ?? Colors.green,
                                  elevation: 5,
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Reportes Detallados',
                                          style: TextStyle(
                                            decoration: TextDecoration.none,
                                            fontStyle: FontStyle.italic,
                                            fontSize: 16,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Genera reportes detallados de todas las actividades para un seguimiento exhaustivo.',
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                          maxLines: 4,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 600,
                  color: const Color.fromARGB(50, 158, 158, 158),
                  child: const Column(
                    children: [
                      Text(
                        'Sobre la App',
                        style: TextStyle(
                            fontSize: 25,
                            fontStyle: FontStyle.italic,
                            decoration: TextDecoration.underline),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Card(
                                    elevation: 4,
                                    margin: EdgeInsets.all(8.0),
                                    child: Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '¿Qué es SENAuthenticator?',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            'SENAuthenticator es una aplicación innovadora diseñada para gestionar y mejorar la seguridad en las instalaciones del SENA Alto Cauca. Utilizando inteligencia artificial y tecnologías avanzadas de reconocimiento facial, la aplicación permite un control de acceso eficiente y seguro.',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Card(
                                    elevation: 4,
                                    margin: EdgeInsets.all(8.0),
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '¿Qué es SENAuthenticator?',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          // Crear cada elemento manualmente
                                          Row(
                                            children: [
                                              Icon(Icons.circle, size: 8),
                                              SizedBox(width: 8),
                                              Expanded(
                                                  child: Text(
                                                      'Autenticación facial rápida y precisa.')),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.circle, size: 8),
                                              SizedBox(width: 8),
                                              Expanded(
                                                  child: Text(
                                                      'Monitoreo en tiempo real de entradas y salidas.')),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.circle, size: 8),
                                              SizedBox(width: 8),
                                              Expanded(
                                                  child: Text(
                                                      'Generación de reportes detallados.')),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.circle, size: 8),
                                              SizedBox(width: 8),
                                              Expanded(
                                                  child: Text(
                                                      'Interfaz intuitiva y fácil de usar.')),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.circle, size: 8),
                                              SizedBox(width: 8),
                                              Expanded(
                                                  child: Text(
                                                      'Seguridad mejorada para todas las personas que ingresan a las instalaciones.')),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          // Container(
                          //   height: 500,
                          //   width: 200,
                          //   color: Colors.green,
                          //   child: Column(
                          //     children: [
                          //       Image.asset(
                          //         'images/login/LogoReconocimientoFacialBlanco.png',
                          //         width: 50,
                          //       ),
                          //       Text('Emmanuel Arriola'),
                          //       Text('Desarrollador'),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: double.infinity,
                  height: 300,
                  child: Column(
                    children: [
                      Text(
                        'Testimonios',
                        style: TextStyle(
                            fontSize: 25,
                            fontStyle: FontStyle.italic,
                            decoration: TextDecoration.underline),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 230,
                              child: Card(
                                elevation: 4,
                                margin: EdgeInsets.all(8.0),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text('¿Qué es SENAuthenticator?'),
                                      Text(
                                        'SENAuthenticator es una aplicación innovadora diseñada para gestionar y mejorar la seguridad en las instalaciones del SENA Alto Cauca. Utilizando inteligencia artificial y tecnologías avanzadas de reconocimiento facial, la ap||||licación permite un control de acceso eficiente y seguro.',
                                        maxLines: 5,
                                        textAlign: TextAlign.justify,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 230,
                              child: Card(
                                elevation: 4,
                                margin: EdgeInsets.all(8.0),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text('¿Qué es SENAuthenticator?'),
                                      Text(
                                        'SENAuthenticator es una aplicación innovadora diseñada para gestionar y mejorar la seguridad en las instalaciones del SENA Alto Cauca. Utilizando inteligencia artificial y tecnologías avanzadas de reconocimiento facial, la ap||||licación permite un control de acceso eficiente y seguro.',
                                        maxLines: 5,
                                        textAlign: TextAlign.justify,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 230,
                              child: Card(
                                elevation: 4,
                                margin: EdgeInsets.all(8.0),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text('¿Qué es SENAuthenticator?'),
                                      Text(
                                        'SENAuthenticator es una aplicación innovadora diseñada para gestionar y mejorar la seguridad en las instalaciones del SENA Alto Cauca. Utilizando inteligencia artificial y tecnologías avanzadas de reconocimiento facial, la ap||||licación permite un control de acceso eficiente y seguro.',
                                        maxLines: 5,
                                        textAlign: TextAlign.justify,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 230,
                              child: Card(
                                elevation: 4,
                                margin: EdgeInsets.all(8.0),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text('¿Qué es SENAuthenticator?'),
                                      Text(
                                        'SENAuthenticator es una aplicación innovadora diseñada para gestionar y mejorar la seguridad en las instalaciones del SENA Alto Cauca. Utilizando inteligencia artificial y tecnologías avanzadas de reconocimiento facial, la aplicación permite un control de acceso eficiente y seguro.',
                                        maxLines: 5,
                                        textAlign: TextAlign.justify,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(
                          16.0), // Puedes ajustar el padding según sea necesario
                      decoration: BoxDecoration(
                        color: Colors
                            .white, // Cambia esto según el fondo que desees
                        borderRadius: BorderRadius.circular(
                            8.0), // Para bordes redondeados, si quieres
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(
                                0.5), // Sombra para dar un efecto de elevación
                            blurRadius: 4.0,
                            spreadRadius: 1.0,
                            offset: const Offset(0, 2), // Sombra en el eje Y
                          ),
                        ],
                      ),
                      child: const Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start, // Alineación del texto
                        children: [
                          Text(
                            'Últimas Noticias',
                            style: TextStyle(
                              fontSize: 25,
                              fontStyle: FontStyle.italic,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          SizedBox(
                              height:
                                  16), // Espacio entre el título y el contenido
                          SizedBox(
                            height: 300,
                            child: Flexible(
                              fit: FlexFit.loose,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Column(
                                    children: [
                                      Card(
                                        elevation: 4,
                                        margin: EdgeInsets.all(8.0),
                                        child: Padding(
                                          padding: EdgeInsets.all(16.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Actualización de Seguridad',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(height: 8),
                                              Text(
                                                'Hemos lanzado una nueva actualización que mejora aún más la precisión del reconocimiento facial y agrega nuevas funcionalidades para una mayor seguridad.',
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Card(
                                        elevation: 4,
                                        margin: EdgeInsets.all(8.0),
                                        child: Padding(
                                          padding: EdgeInsets.all(16.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Segundo Socio Estratégico',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(height: 8),
                                              Text(
                                                'Estamos emocionados de anunciar nuestra colaboración con un nuevo socio estratégico que ampliará nuestras capacidades y ofrecerá más valor a nuestros clientes.',
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Card(
                                        elevation: 4,
                                        margin: EdgeInsets.all(8.0),
                                        child: Padding(
                                          padding: EdgeInsets.all(16.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Nuevo Socio Estratégico',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(height: 8),
                                              Text(
                                                'Estamos emocionados de anunciar nuestra colaboración con un nuevo socio estratégico que ampliará nuestras capacidades y ofrecerá más valor a nuestros clientes.',
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  color: const Color.fromARGB(255, 43, 52, 64),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'images/login/LogoReconocimientoFacialBlanco.png',
                                cacheWidth: 40,
                                color: Colors.green,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text(
                                'SENAuthenticator',
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'Social',
                                style: TextStyle(
                                    color: Colors.grey[350], fontSize: 18),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    // icon: Icon(Icons.abc, color: Colors.white,),
                                    icon: const FaIcon(
                                      FontAwesomeIcons.twitter,
                                      size: 30,
                                      color: Colors.white38,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const FaIcon(
                                      FontAwesomeIcons.youtube,
                                      size: 30,
                                      color: Colors.white38,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const FaIcon(
                                      FontAwesomeIcons.facebookF,
                                      size: 30,
                                      color: Colors.white38,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        '© 2024. Todos los derechos reservados.',
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const BottonNavScreen());
  }

  // void _scrollToPosition(double position) {
  //   _scrollController.animateTo(
  //     position,
  //     duration: const Duration(milliseconds: 500),
  //     curve: Curves.easeInOut,
  //   );
  // }

  void _showModalCard(BuildContext context, Widget card) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: card,
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

