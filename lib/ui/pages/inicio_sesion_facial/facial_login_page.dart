import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:reconocimiento_app/ui/router.dart';

class FacialLoginPage extends StatefulWidget {
  const FacialLoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FacialLoginPageState createState() => _FacialLoginPageState();
}

class _FacialLoginPageState extends State<FacialLoginPage> {
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
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
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
      if (context.mounted) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(responseJson['message'] ?? 'Usuario no encontrado')),
      );
        
      }
    }
  }

  void _redirectToRole(String userName, String role) {
    // Redirigir según el rol del usuario
    if (role == 'Administrador') {
      Navigator.pushNamed(context, Routes.baseAdmin);
    } else if (role == 'Instructor') {
      Navigator.pushNamed(context, Routes.baseInstructor);
    } else if (role == 'Aprendiz') {
      Navigator.pushNamed(context, Routes.baseAprendiz);
    } else {
      Navigator.pushNamed(context, Routes.login);
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio de Sesión Facial'),
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                Expanded(
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