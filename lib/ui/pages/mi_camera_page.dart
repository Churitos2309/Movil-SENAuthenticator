import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class MyCameraPage extends StatefulWidget {
  const MyCameraPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyCameraPageState createState() => _MyCameraPageState();
}

class _MyCameraPageState extends State<MyCameraPage> {
  CameraController? _controller;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.high,
    );

    await _controller!.initialize();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _redirectToRole(String role, Map<String, dynamic> userData) {
    // Your redirection logic here
  }

  Future<void> someFunction() async {
    try {
      final responseJson = await someApiCall();
      final userData = {
        'Documento': responseJson['numero_documento_usuario'],
        'Correo': responseJson['email'],
        'Rol': responseJson['rol_usuario'],
      };
      // Detener la cámara
      _controller?.dispose();
      _timer?.cancel();
      // Redirigir según el rol del usuario
      _redirectToRole(userData['Rol']!, userData);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error de conexión: ${e.toString()}')),
        );
      }
    }
  }

  Future<Map<String, dynamic>> someApiCall() async {
    // Implement your API call logic here
    // For example:
    return {
      'documento': '123456',
      'correo': 'example@example.com',
      'rol': 'admin',
    };
  }

  // Future<Map<String, dynamic>> post(
  //     String path, Map<String, dynamic> data) async {
  //   try {
  //     final response = await _dio.post(path, data: data);
  //     if (kDebugMode) {
  //       print('Response data: ${response.data}');
  //     }
  //     return response.data;
  //   } catch (e) {
  //     throw Exception('Failed to post data: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }
    return CameraPreview(_controller!);
  }
}