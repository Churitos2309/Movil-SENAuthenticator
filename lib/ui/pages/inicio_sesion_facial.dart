// import 'dart:async';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio de Sesión Facial'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image == null
                ? const Text('No se ha capturado ninguna imagen.')
                : Image.file(_image!),
            const SizedBox(height: 20),
            // Eliminar el botón ya que la captura es automática
            // ElevatedButton(
            //   onPressed: _captureAndRecognizeImage,
            //   child: const Text('Capturar Imagen Facial'),
            // ),
          ],
        ),
      ),
    );
  }

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
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    selectedCamera = cameras!.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => cameras!.first,
    );

    _controller = CameraController(
      selectedCamera!,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
    await _initializeControllerFuture;

    // Iniciar el temporizador para capturar imágenes regularmente
    _startImageCaptureTimer();
  }

  void _startImageCaptureTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      if (!_isRecognizing) {
        _isRecognizing = true;
        await _captureAndRecognizeImage();
        _isRecognizing = false;
      }
    });
  }

  Future<void> _captureAndRecognizeImage() async {
    try {
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
      Uri.parse(
          'https://backendsenauthenticator.up.railway.app/api/inicio-sesion-facial/'),
    );
    request.files
        .add(await http.MultipartFile.fromPath('face_login', imageFile.path));

    final response = await request.send();
    final responseData = await response.stream.bytesToString();
    final responseJson = jsonDecode(responseData);

    if (response.statusCode == 200 && responseJson['matching'] == true) {
      final userName = responseJson['user_name'];
      // ignore: non_constant_identifier_names
      final rol_usuario = responseJson['rol_usuario'];
      // Aquí puedes obtener el rol del usuario y redirigir según el rol
      // Por ejemplo, si tienes una API para obtener el rol del usuario:
      // final userRole = await _getUserRole(userName);
      // _redirectToRole(userRole);
      _redirectToRole(
          userName, rol_usuario); // Suponiendo que el nombre de usuario es el rol
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text(responseJson['message'] ?? 'Usuario no encontrado')),
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

    @override
    // ignore: unused_element
    void dispose() {
      _controller.dispose();
      _timer?.cancel();
      super.dispose();
    }

    @override
    // ignore: unused_element
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Inicio de Sesión Facial'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _image == null
                  ? const Text('No se ha capturado ninguna imagen.')
                  : Image.file(_image!),
              const SizedBox(height: 20),
              // Eliminar el botón ya que la captura es automática
              // ElevatedButton(
              //   onPressed: _captureAndRecognizeImage,
              //   child: const Text('Capturar Imagen Facial'),
              // ),
            ],
          ),
        ),
      );
    }
  }
}
