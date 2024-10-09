
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:reconocimiento_app/services/api_services.dart';
import 'package:reconocimiento_app/ui/router.dart';

class CardInicieCon extends StatefulWidget {
  const CardInicieCon({super.key, required ApiService apiService});

  @override
  // ignore: library_private_types_in_public_api
  _CardInicieConState createState() => _CardInicieConState();
}

class _CardInicieConState extends State<CardInicieCon> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: _isLoading
              ? const CircularProgressIndicator()
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
                            // Otros campos de formulario aquí
                            const SizedBox(height: 20),
                            const Text(
                              "O inicie con ",
                              style: TextStyle(color: Colors.white),
                            ),
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const FacialLoginModal();
                                  },
                                );
                              },
                              icon: Image.asset(
                                'images/img/ReconocimientoFacial.webp',
                                cacheWidth: 100,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Flexible(
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
                                      style: TextStyle(color: Colors.blue),
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
                ),
        ),
      ),
    );
  }
}

class FacialLoginModal extends StatefulWidget {
  const FacialLoginModal({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FacialLoginModalState createState() => _FacialLoginModalState();
}

class _FacialLoginModalState extends State<FacialLoginModal> {
  File? _image;
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  List<CameraDescription>? cameras;
  CameraDescription? selectedCamera;
  Timer? _timer;
  bool _isRecognizing = false;

  @override
  void initState() {
    super.initState();
    _initializeControllerFuture = _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      cameras = await availableCameras();
      selectedCamera = cameras!.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => cameras!.first,
      );

      _controller = CameraController(
        selectedCamera!,
        ResolutionPreset.medium,
      );

      await _controller.initialize();

      // Iniciar el temporizador para capturar imágenes regularmente
      _startImageCaptureTimer();
    } catch (e) {
      print('Error al inicializar la cámara: $e');
      throw 'Error al inicializar la cámara';
    }
  }

  void _startImageCaptureTimer() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) async {
      if (!_isRecognizing) {
        _isRecognizing = true;
        await _captureAndRecognizeImage();
        _isRecognizing = false;
      }
    });
  }

  Future<void> _captureAndRecognizeImage() async {
    try {
      await _initializeControllerFuture;
      final image = await _controller.takePicture();
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = join(directory.path, '${DateTime.now()}.png');
      final imageFile = File(imagePath);
      await imageFile.writeAsBytes(await image.readAsBytes());

      setState(() {
        _image = imageFile;
      });

      // Enviar la imagen a la API para el reconocimiento facial
      await _recognizeFace(imageFile);
    } catch (e) {
      print(e);
    }
  }

  Future<void> _recognizeFace(File imageFile) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('https://backendsenauthenticator.up.railway.app/api/inicio-sesion-facial/'),
    );
    request.files.add(await http.MultipartFile.fromPath('face_login', imageFile.path));

    final response = await request.send();
    final responseData = await response.stream.bytesToString();
    final responseJson = jsonDecode(responseData);

    if (response.statusCode == 200 && responseJson['matching'] == true) {
      final userName = responseJson['user_name'];
      final role = responseJson['rol_usuario'];
      // Detener la cámara
      _controller.dispose();
      _timer?.cancel();
      // Redirigir según el rol del usuario
      _redirectToRole(userName, role); // Suponiendo que el nombre de usuario es el rol
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseJson['message'] ?? 'Usuario no encontrado')),
        );
      }
    }
  }

  void _redirectToRole(String userName, String role) {
    // Redirigir según el rol del usuario
    switch (role) {
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
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AspectRatio(
                  aspectRatio: 1 / _controller.value.aspectRatio,
                  child: CameraPreview(_controller),
                ),
                const SizedBox(height: 20),
                _image == null
                    ? const Text('No se ha capturado ninguna imagen.')
                    : Image.file(_image!),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error al inicializar la cámara: ${snapshot.error}'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}