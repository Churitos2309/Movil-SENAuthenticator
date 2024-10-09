// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';

// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:reconocimiento_app/ui/router.dart';


// class FacialLoginModal extends StatefulWidget {
//   const FacialLoginModal({super.key});

//   @override
//   _FacialLoginModalState createState() => _FacialLoginModalState();
// }

// class _FacialLoginModalState extends State<FacialLoginModal> {
//   File? _image;
//   late CameraController _controller;
//   late Future<void> _initializeControllerFuture;
//   List<CameraDescription>? cameras;
//   CameraDescription? selectedCamera;
//   Timer? _timer;
//   bool _isRecognizing = false;

//   @override
//   void initState() {
//     super.initState();
//     _initializeControllerFuture = _initializeCamera();
//   }

//   Future<void> _initializeCamera() async {
//     try {
//       cameras = await availableCameras();
//       selectedCamera = cameras!.firstWhere(
//         (camera) => camera.lensDirection == CameraLensDirection.front,
//         orElse: () => cameras!.first,
//       );

//       _controller = CameraController(
//         selectedCamera!,
//         ResolutionPreset.medium,
//       );

//       await _controller.initialize();

//       // Iniciar el temporizador para capturar imágenes regularmente
//       _startImageCaptureTimer();
//     } catch (e) {
//       print('Error al inicializar la cámara: $e');
//       throw 'Error al inicializar la cámara';
//     }
//   }

//   void _startImageCaptureTimer() {
//     _timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
//       if (!_isRecognizing) {
//         _isRecognizing = true;
//         await _captureAndRecognizeImage();
//         _isRecognizing = false;
//       }
//     });
//   }

//   Future<void> _captureAndRecognizeImage() async {
//     try {
//       await _initializeControllerFuture;
//       final image = await _controller.takePicture();
//       final directory = await getApplicationDocumentsDirectory();
//       final imagePath = join(directory.path, '${DateTime.now()}.png');
//       final imageFile = File(imagePath);
//       await imageFile.writeAsBytes(await image.readAsBytes());

//       setState(() {
//         _image = imageFile;
//       });

//       // Enviar la imagen a la API para el reconocimiento facial
//       await _recognizeFace(imageFile);
//     } catch (e) {
//       print(e);
//     }
//   }

//   Future<void> _recognizeFace(File imageFile) async {
//     final request = http.MultipartRequest(
//       'POST',
//       Uri.parse('https://backendsenauthenticator.up.railway.app/api/inicio-sesion-facial/'),
//     );
//     request.files.add(await http.MultipartFile.fromPath('face_login', imageFile.path));

//     final response = await request.send();
//     final responseData = await response.stream.bytesToString();
//     final responseJson = jsonDecode(responseData);

//     if (response.statusCode == 200 && responseJson['matching'] == true) {
//       final userName = responseJson['user_name'];
//       // Detener la cámara
//       _controller.dispose();
//       _timer?.cancel();
//       // Redirigir según el rol del usuario
//       _redirectToRole(userName); // Suponiendo que el nombre de usuario es el rol
//     } else {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(responseJson['message'] ?? 'Usuario no encontrado')),
//         );
//       }
//     }
//   }

//   void _redirectToRole(String role) {
//     // Redirigir según el rol del usuario
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

//   @override
//   void dispose() {
//     _controller.dispose();
//     _timer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       content: FutureBuilder<void>(
//         future: _initializeControllerFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             return Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Expanded(
//                   child: CameraPreview(_controller),
//                 ),
//                 const SizedBox(height: 20),
//                 _image == null
//                     ? const Text('No se ha capturado ninguna imagen.')
//                     : Image.file(_image!),
//               ],
//             );
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error al inicializar la cámara: ${snapshot.error}'));
//           } else {
//             return const Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//     );
//   }
// }
