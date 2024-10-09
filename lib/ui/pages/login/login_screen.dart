// import 'dart:io';
// import 'dart:math';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:particles_flutter/component/particle/particle.dart';
// import 'package:particles_flutter/particles_engine.dart';
// import 'package:reconocimiento_app/services/api_services.dart';
// import 'package:reconocimiento_app/ui/pages/custom_app_bar_lobby.dart';
// import 'package:reconocimiento_app/ui/router.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class LoginScreen extends StatefulWidget {
//   final ApiService apiService;

//   const LoginScreen({super.key, required this.apiService});

//   @override
//   // ignore: library_private_types_in_public_api
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _formKey = GlobalKey<FormState>();
//   File? _image;

//   final FocusNode _numeroIdentificacionFocusNode = FocusNode();
//   final FocusNode _passwordFocusNode = FocusNode();

//   final TextEditingController _numeroIdentificacionController =
//       TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   Color _numeroIdentificacionTextColor = Colors.grey;
//   Color _passwordTextColor = Colors.grey;

//   bool _isLoading = false;
//   List token = [];

//   @override
//   void initState() {
//     super.initState();
//     _numeroIdentificacionFocusNode
//         .addListener(_onNumeroIdentificacionFocusChange);
//     _passwordFocusNode.addListener(_onPasswordFocusChange);
//   }

//   @override
//   void dispose() {
//     _numeroIdentificacionFocusNode
//         .removeListener(_onNumeroIdentificacionFocusChange);
//     _passwordFocusNode.removeListener(_onPasswordFocusChange);
//     _numeroIdentificacionFocusNode.dispose();
//     _passwordFocusNode.dispose();
//     _numeroIdentificacionController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
// //   void uploadImage() async {
// //   File imageFile = File('/ruta/a/tu/imagen.jpg'); // Ruta a tu archivo de imagen
// //   try {
// //     var response = await apiService.postWithImage('tu_endpoint', imageFile);
// //     print('Respuesta: $response');
// //   } catch (e) {
// //     print('Error: $e');
// //   }
// // }

//   void _onNumeroIdentificacionFocusChange() {
//     setState(() {
//       _numeroIdentificacionTextColor =
//           _numeroIdentificacionFocusNode.hasFocus ? Colors.green : Colors.grey;
//     });
//   }

//   void _onPasswordFocusChange() {
//     setState(() {
//       _passwordTextColor =
//           _passwordFocusNode.hasFocus ? Colors.green : Colors.grey;
//     });
//   }

//   void _validarToken(String token, String? rol) async {
//     // Guardar el token en el almacenamiento local
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('token', token);

//     if (rol != null && rol.isNotEmpty) {
//       // Verifica que el rol no esté vacío
//       await prefs.setString('rol', rol);

//       if (!mounted) return;

//       // Redireccionar basado en el rol
//       switch (rol) {
//         case 'Administrador':
//           Navigator.pushReplacementNamed(context, Routes.baseAdmin);
//           break;
//         case 'Instructor':
//           Navigator.pushReplacementNamed(context, Routes.baseInstructor);
//           break;
//         case 'Aprendiz':
//           Navigator.pushReplacementNamed(context, Routes.baseAprendiz);
//           break;
//         case 'Guardia de seguridad':
//           Navigator.pushReplacementNamed(context, '/usuarios');
//           break;
//         default:
//           Navigator.pushReplacementNamed(context, Routes.home);
//       }
//     } else {
//       if (kDebugMode) {
//         print(
//             'Error: el rol recibido es null o vacío. Redirigiendo a la página de error.');
//       }
//       await prefs.setString('rol', '');
//       if (mounted) {
//         Navigator.pushReplacementNamed(context, '/error');
//       }
//     }
//   }

//   void _login() async {
//     if (!_formKey.currentState!.validate()) {
//       return;
//     }

//     setState(() {
//       _isLoading = true; // Indicar que se está cargando
//     });

//     try {
//       // Enviar datos al backend
//       final responseData = await widget.apiService.post('inicio-sesion/', {
//         'numero_documento_usuario': _numeroIdentificacionController.text,
//         'password': _passwordController.text,
//       });

//       if (responseData['token'] != null) {
//         final token = responseData['token'];
//         final rol = responseData['user']?['rol_usuario'];
//         if (kDebugMode) {
//           print('Token recibido: $token');
//         }
//         if (kDebugMode) {
//           print('Rol recibido: $rol');
//         }

//         _validarToken(token, rol);
//       } else {
//         throw Exception('Error: Token no proporcionado por el servidor');
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         print('Error de conexión: con Token $e');
//       }
//       if (!mounted) return;
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error al iniciar sesión: $e')),
//       );
//     } finally {
//       setState(() {
//         _isLoading = false; // Restablecer el estado de carga
//       });
//     }
//   }

//   Future<void> _loginFacial() async {
//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       if (_image == null) {
//         throw Exception('No se ha seleccionado ninguna imagen');
//       }

//       final responseData =
//           await widget.apiService.loginFace(faceImage: _image!);
//       print('Response data: $responseData');

//       if (responseData['success']) {
//         if (responseData.containsKey('userName') &&
//             responseData.containsKey('userRole') &&
//             responseData.containsKey('token')) {
//           final userName = responseData['userName'];
//           final userRole = responseData['userRole'];
//           final token = responseData['token'];

//           widget.apiService.setToken(token);

//           // Guardar el token y la información del usuario localmente
//           final prefs = await SharedPreferences.getInstance();
//           await prefs.setString('token', token);
//           await prefs.setString('userName', userName);
//           await prefs.setString('userRole', userRole);

//           _navigateBasedOnRole(userRole);
//         } else {
//           throw Exception(
//               'La respuesta del servidor no contiene los campos esperados: ${responseData.keys}');
//         }
//       } else {
//         throw Exception(
//             responseData['message'] ?? 'Error en el inicio de sesión facial');
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         print('Error de conexión: $e');
//       }
//       if (!mounted) return;
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error al iniciar sesión: $e')),
//       );
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   void _navigateBasedOnRole(String role) {
//     switch (role) {
//       case 'Administrador':
//         Navigator.pushReplacementNamed(context, Routes.baseAdmin);
//         break;
//       case 'Instructor':
//         Navigator.pushReplacementNamed(context, Routes.baseInstructor);
//         break;
//       case 'Aprendiz':
//         Navigator.pushReplacementNamed(context, Routes.baseAprendiz);
//         break;
//       case 'Guardia de seguridad':
//         Navigator.pushReplacementNamed(context, '/usuarios');
//         break;
//       default:
//         Navigator.pushReplacementNamed(context, Routes.home);
//     }
//   }

//   Future<void> _getImage() async {
//     final pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.camera);

//     setState(() {
//       if (pickedFile != null) {
//         _image = File(pickedFile.path);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;
//     double screenWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: const CustomAppBarLobby(title: 'Inicio de sesión'),
//       body: Stack(
//         children: [
//           Container(
//             color: const Color.fromARGB(255, 10, 10, 10),
//             child: Particles(
//               awayRadius: 100,
//               particles: createParticles(),
//               height: screenHeight,
//               width: screenWidth,
//               onTapAnimation: true,
//               awayAnimationDuration: const Duration(milliseconds: 500),
//               awayAnimationCurve: Curves.easeInOutCirc,
//               enableHover: true,
//               hoverRadius: 90,
//               connectDots: false,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Center(
//               child: _isLoading
//                   ? const CircularProgressIndicator()
//                   // const CardLoading(
//                   //     height: 100,
//                   //     borderRadius: BorderRadius.all(Radius.circular(10)),
//                   //     margin: EdgeInsets.only(bottom: 10),
//                   //   )
//                   : Card(
//                       shadowColor: Colors.green[700],
//                       color: const Color.fromARGB(150, 10, 10, 10),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20.0),
//                       ),
//                       child: SizedBox(
//                         width: 300,
//                         child: SingleChildScrollView(
//                           child: Form(
//                             key: _formKey,
//                             child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Flexible(
//                                   flex: 1,
//                                   fit: FlexFit.loose,
//                                   child: Image.asset(
//                                     'images/login/LogoReconocimientoFacialBlanco.png',
//                                     width: 100,
//                                     height: 100,
//                                     color: Colors.green,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 16.0),
//                                 const Text(
//                                   "Bienvenido a SENAuthenticator",
//                                   style: TextStyle(
//                                       fontSize: 18.0,
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.white),
//                                 ),
//                                 const SizedBox(height: 16.0),
//                                 const Text(
//                                   "Iniciar sesión para continuar..",
//                                   style: TextStyle(
//                                       fontSize: 16.0, color: Colors.grey),
//                                 ),
//                                 const SizedBox(height: 30),
//                                 TextFormField(
//                                   key: const Key('identificacionInput'),
//                                   focusNode: _numeroIdentificacionFocusNode,
//                                   controller: _numeroIdentificacionController,
//                                   decoration: InputDecoration(
//                                     labelText: 'Cédula',
//                                     labelStyle: TextStyle(
//                                         color: _numeroIdentificacionTextColor),
//                                     prefixIcon: Icon(Icons.email,
//                                         color: _numeroIdentificacionTextColor),
//                                     focusedBorder: OutlineInputBorder(
//                                       borderSide:
//                                           const BorderSide(color: Colors.green),
//                                       borderRadius: BorderRadius.circular(10.0),
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderSide:
//                                           const BorderSide(color: Colors.grey),
//                                       borderRadius: BorderRadius.circular(10.0),
//                                     ),
//                                   ),
//                                   style: const TextStyle(color: Colors.white),
//                                   validator: (value) {
//                                     if (value == null || value.isEmpty) {
//                                       return 'Por favor, ingrese su numero de cédula';
//                                     }
//                                     return null;
//                                   },
//                                 ),
//                                 const SizedBox(height: 15),
//                                 TextFormField(
//                                   key: const Key('passwordInput'),
//                                   focusNode: _passwordFocusNode,
//                                   controller: _passwordController,
//                                   obscureText: true,
//                                   decoration: InputDecoration(
//                                     labelText: 'Contraseña',
//                                     labelStyle:
//                                         TextStyle(color: _passwordTextColor),
//                                     prefixIcon: Icon(Icons.lock,
//                                         color: _passwordTextColor),
//                                     focusedBorder: OutlineInputBorder(
//                                       borderSide:
//                                           const BorderSide(color: Colors.green),
//                                       borderRadius: BorderRadius.circular(10.0),
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderSide:
//                                           const BorderSide(color: Colors.grey),
//                                       borderRadius: BorderRadius.circular(10.0),
//                                     ),
//                                   ),
//                                   style: const TextStyle(color: Colors.white),
//                                   validator: (value) {
//                                     if (value == null || value.isEmpty) {
//                                       return 'Por favor, ingrese su contraseña';
//                                     }
//                                     return null;
//                                   },
//                                 ),
//                                 const SizedBox(height: 30.0),
//                                 SizedBox(
//                                   width: double.infinity,
//                                   child: ElevatedButton(
//                                     onPressed: _isLoading ? null : _login,
//                                     style: ElevatedButton.styleFrom(
//                                       padding: const EdgeInsets.symmetric(
//                                           vertical: 15.0),
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(10.0),
//                                       ),
//                                       backgroundColor: Colors.green,
//                                       foregroundColor: Colors.white,
//                                     ),
//                                     child: _isLoading
//                                         ? const CircularProgressIndicator(
//                                             color: Colors.white,
//                                           )
//                                         : const Text("Iniciar sesión"),
//                                   ),
//                                 ),
//                                 const SizedBox(height: 20.0),
//                                 const Text(
//                                   "O inicie con ",
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                                 IconButton(
//                                   onPressed: () {
//                                     showDialog(
//                                       context: context,
//                                       builder: (BuildContext context) {
//                                         return AlertDialog(
//                                           title:
//                                               Text('Inicio de sesión facial'),
//                                           content: Column(
//                                             mainAxisSize: MainAxisSize.min,
//                                             children: [
//                                               if (_image != null)
//                                                 Image.file(_image!)
//                                               else
//                                                 Text(
//                                                     'No se ha seleccionado ninguna imagen'),
//                                               ElevatedButton(
//                                                 onPressed: _getImage,
//                                                 child: Text('Tomar foto'),
//                                               ),
//                                               ElevatedButton(
//                                                 onPressed: _loginFacial,
//                                                 child: Text(
//                                                     'Iniciar sesión con reconocimiento facial'),
//                                               ),
//                                             ],
//                                           ),
//                                         );
//                                       },
//                                     );
//                                   },
//                                   icon: Image.asset(
//                                     'images/img/ReconocimientoFacial.webp',
//                                     cacheWidth: 100,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 20.0),
//                                 Expanded(
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       const Text(
//                                         "¿No tienes una cuenta?",
//                                         style: TextStyle(color: Colors.white),
//                                       ),
//                                       TextButton(
//                                         onPressed: () {
//                                           Navigator.pushNamed(
//                                               context, Routes.register);
//                                         },
//                                         child: const Text(
//                                           "Regístrate",
//                                           style: TextStyle(color: Colors.green),
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                                 const SizedBox(height: 20.0),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   List<Particle> createParticles() {
//     var rng = Random();
//     List<Particle> particles = [];
//     for (int i = 0; i < 50; i++) {
//       particles.add(Particle(
//         color: Colors.green.withOpacity(0.6),
//         size: rng.nextDouble() * 10,
//         velocity: Offset(rng.nextDouble() * 50 * randomSign(),
//             rng.nextDouble() * 50 * randomSign()),
//       ));
//     }
//     return particles;
//   }

//   double randomSign() {
//     var rng = Random();
//     return rng.nextBool() ? 1.0 : -1.0;
//   }
// }

import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:particles_flutter/component/particle/particle.dart';
import 'package:particles_flutter/particles_engine.dart';
import 'package:reconocimiento_app/services/api_services.dart';
import 'package:reconocimiento_app/ui/pages/custom_app_bar_lobby.dart';
import 'package:reconocimiento_app/ui/router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  final ApiService apiService;

  const LoginScreen({super.key, required this.apiService});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File? _image;
  bool _isLoading = false;
  // ignore: unused_field
  String? _errorMessage;

  final FocusNode _numeroIdentificacionFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  final TextEditingController _numeroIdentificacionController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Color _numeroIdentificacionTextColor = Colors.grey;
  Color _passwordTextColor = Colors.grey;

  List token = [];

  @override
  void initState() {
    super.initState();
    _numeroIdentificacionFocusNode
        .addListener(_onNumeroIdentificacionFocusChange);
    _passwordFocusNode.addListener(_onPasswordFocusChange);
  }

  void _onNumeroIdentificacionFocusChange() {
    setState(() {
      _numeroIdentificacionTextColor =
          _numeroIdentificacionFocusNode.hasFocus ? Colors.green : Colors.grey;
    });
  }

  void _onPasswordFocusChange() {
    setState(() {
      _passwordTextColor =
          _passwordFocusNode.hasFocus ? Colors.green : Colors.grey;
    });
  }

  @override
  void dispose() {
    _numeroIdentificacionFocusNode
        .removeListener(_onNumeroIdentificacionFocusChange);
    _passwordFocusNode.removeListener(_onPasswordFocusChange);
    _numeroIdentificacionFocusNode.dispose();
    _passwordFocusNode.dispose();
    _numeroIdentificacionController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true; // Indicar que se está cargando
    });

    try {
      // Enviar datos al backend
      final responseData = await widget.apiService.post('inicio-sesion/', {
        'numero_documento_usuario': _numeroIdentificacionController.text,
        'password': _passwordController.text,
      });

      if (responseData['token'] != null) {
        final token = responseData['token'];
        final rol = responseData['user']?['rol_usuario'];
        if (kDebugMode) {
          print('Token recibido: $token');
        }
        if (kDebugMode) {
          print('Rol recibido: $rol');
        }

        _validarToken(token, rol);
      } else {
        throw Exception('Error: Token no proporcionado por el servidor');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error de conexión: con Token $e');
      }
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al iniciar sesión: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false; // Restablecer el estado de carga
      });
    }
  }

  Future<void> _loginFacial() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      if (_image == null) {
        throw Exception('No se ha seleccionado ninguna imagen');
      }

      final responseData =
          await widget.apiService.loginFace(faceImage: _image!);
      print('Response data: $responseData');

      if (responseData['success']) {
        if (responseData.containsKey('userName') &&
            responseData.containsKey('userRole') &&
            responseData.containsKey('token')) {
          final userName = responseData['userName'];
          final userRole = responseData['userRole'];
          final token = responseData['token'];

          widget.apiService.setToken(token);

          // Guardar el token y la información del usuario localmente
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);
          await prefs.setString('userName', userName);
          await prefs.setString('userRole', userRole);

          _navigateBasedOnRole(userRole);
        } else {
          throw Exception(
              'La respuesta del servidor no contiene los campos esperados: ${responseData.keys}');
        }
      } else {
        throw Exception(
            responseData['message'] ?? 'Error en el inicio de sesión facial');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error de conexión: $e');
      }
      if (!mounted) return;
      setState(() {
        _errorMessage = 'Error al iniciar sesión: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _validarToken(String token, String? rol) async {
    // Guardar el token en el almacenamiento local
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);

    if (rol != null && rol.isNotEmpty) {
      // Verifica que el rol no esté vacío
      await prefs.setString('rol', rol);

      if (!mounted) return;

      // Redireccionar basado en el rol
      switch (rol) {
        case 'Administrador':
          Navigator.pushReplacementNamed(context, Routes.baseAdmin);
          break;
        case 'Instructor':
          Navigator.pushReplacementNamed(context, Routes.baseInstructor);
          break;
        case 'Aprendiz':
          Navigator.pushReplacementNamed(context, Routes.baseAprendiz);
          break;
        case 'Guardia de seguridad':
          Navigator.pushReplacementNamed(context, '/usuarios');
          break;
        default:
          Navigator.pushReplacementNamed(context, Routes.home);
      }
    } else {
      if (kDebugMode) {
        print(
            'Error: el rol recibido es null o vacío. Redirigiendo a la página de error.');
      }
      await prefs.setString('rol', '');
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/error');
      }
    }
  }

  void _navigateBasedOnRole(String userRole) {
    // Implementa la navegación basada en el rol del usuario
  }

//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;
//     double screenWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: const CustomAppBarLobby(title: 'Inicio de sesión'),
//       body: Stack(
//         children: [
//           Container(
//             color: const Color.fromARGB(255, 10, 10, 10),
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   if (_image != null)
//                     Image.file(
//                       _image!,
//                       height: screenHeight * 0.3,
//                     ),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: _pickImage,
//                     child: const Text('Seleccionar Imagen'),
//                   ),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: _loginFacial,
//                     child: const Text('Iniciar Sesión Facial'),
//                   ),
//                   if (_errorMessage != null) ...[
//                     const SizedBox(height: 20),
//                     Text(
//                       _errorMessage!,
//                       style: const TextStyle(color: Colors.red),
//                     ),
//                   ],
//                 ],
//               ),
//             ),
//           ),
//           if (_isLoading)
//             const Center(
//               child: CircularProgressIndicator(),
//             ),
//         ],
//       ),
//     );
//   }
// }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const CustomAppBarLobby(title: 'Inicio de sesión'),
      body: Stack(
        children: [
          Container(
            color: const Color.fromARGB(255, 10, 10, 10),
            child: Particles(
              awayRadius: 100,
              particles: createParticles(),
              height: screenHeight,
              width: screenWidth,
              onTapAnimation: true,
              awayAnimationDuration: const Duration(milliseconds: 500),
              awayAnimationCurve: Curves.easeInOutCirc,
              enableHover: true,
              hoverRadius: 90,
              connectDots: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: _isLoading
                  ? const CircularProgressIndicator()
                  // const CardLoading(
                  //     height: 100,
                  //     borderRadius: BorderRadius.all(Radius.circular(10)),
                  //     margin: EdgeInsets.only(bottom: 10),
                  //   )
                  : Card(
                      shadowColor: Colors.green[700],
                      color: const Color.fromARGB(150, 10, 10, 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: SizedBox(
                        width: 300,
                        child: SingleChildScrollView(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  flex: 1,
                                  fit: FlexFit.loose,
                                  child: Image.asset(
                                    'images/login/LogoReconocimientoFacialBlanco.png',
                                    width: 100,
                                    height: 100,
                                    color: Colors.green,
                                  ),
                                ),
                                const SizedBox(height: 16.0),
                                const Text(
                                  "Bienvenido a SENAuthenticator",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                const SizedBox(height: 16.0),
                                const Text(
                                  "Iniciar sesión para continuar..",
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.grey),
                                ),
                                const SizedBox(height: 30),
                                TextFormField(
                                  key: const Key('identificacionInput'),
                                  focusNode: _numeroIdentificacionFocusNode,
                                  controller: _numeroIdentificacionController,
                                  decoration: InputDecoration(
                                    labelText: 'Cédula',
                                    labelStyle: TextStyle(
                                        color: _numeroIdentificacionTextColor),
                                    prefixIcon: Icon(Icons.email,
                                        color: _numeroIdentificacionTextColor),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.green),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  style: const TextStyle(color: Colors.white),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Por favor, ingrese su numero de cédula';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 15),
                                TextFormField(
                                  key: const Key('passwordInput'),
                                  focusNode: _passwordFocusNode,
                                  controller: _passwordController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    labelText: 'Contraseña',
                                    labelStyle:
                                        TextStyle(color: _passwordTextColor),
                                    prefixIcon: Icon(Icons.lock,
                                        color: _passwordTextColor),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.green),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  style: const TextStyle(color: Colors.white),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Por favor, ingrese su contraseña';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 30.0),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: _isLoading ? null : _login,
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      backgroundColor: Colors.green,
                                      foregroundColor: Colors.white,
                                    ),
                                    child: _isLoading
                                        ? const CircularProgressIndicator(
                                            color: Colors.white,
                                          )
                                        : const Text("Iniciar sesión"),
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                                const Text(
                                  "O inicie con ",
                                  style: TextStyle(color: Colors.white),
                                ),
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title:
                                              const Text('Inicio de sesión facial'),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              if (_image != null)
                                                Image.file(_image!)
                                              else
                                                const Text(
                                                    'No se ha seleccionado ninguna imagen'),
                                              ElevatedButton(
                                                onPressed: _pickImage,
                                                child: const Text('Tomar foto'),
                                              ),
                                              ElevatedButton(
                                                onPressed: _loginFacial,
                                                child: const Text(
                                                    'Iniciar sesión con reconocimiento facial'),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  icon: Image.asset(
                                    'images/img/ReconocimientoFacial.webp',
                                    cacheWidth: 100,
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "¿No tienes una cuenta?",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, Routes.register);
                                        },
                                        child: const Text(
                                          "Regístrate",
                                          style: TextStyle(color: Colors.green),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  List<Particle> createParticles() {
    var rng = Random();
    List<Particle> particles = [];
    for (int i = 0; i < 50; i++) {
      particles.add(Particle(
        color: Colors.green.withOpacity(0.6),
        size: rng.nextDouble() * 10,
        velocity: Offset(rng.nextDouble() * 50 * randomSign(),
            rng.nextDouble() * 50 * randomSign()),
      ));
    }
    return particles;
  }

  double randomSign() {
    var rng = Random();
    return rng.nextBool() ? 1.0 : -1.0;
  }
}
