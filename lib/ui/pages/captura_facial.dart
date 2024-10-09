import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CapturaFacial extends StatefulWidget {
  const CapturaFacial({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CapturaFacialState createState() => _CapturaFacialState();
}

class _CapturaFacialState extends State<CapturaFacial> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  XFile? _imageFile;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  void _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller!.initialize();
  }

  Future<void> _captureImage() async {
    try {
      await _initializeControllerFuture;

      _imageFile = await _controller!.takePicture();

      final path = join(
        (await getTemporaryDirectory()).path,
        '${DateTime.now()}.png',
      );
      File(_imageFile!.path).copy(path);

      _sendData(File(_imageFile!.path));
    } catch (e) {
      print(e);
    }
  }

  void _sendData(File imageFile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final nombreCompleto = prefs.getString('nombreCompleto');
    final tipoDocumento = prefs.getString('tipoDocumento');
    final numeroDocumento = prefs.getString('numeroDocumento');
    final email = prefs.getString('email');
    final password = prefs.getString('password');

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://backendsenauthenticator.up.railway.app/api/usuarios/'),
    );

    request.fields['first_name'] = nombreCompleto!;
    request.fields['tipo_documento_usuario'] = tipoDocumento!;
    request.fields['numero_documento_usuario'] = numeroDocumento!;
    request.fields['email'] = email!;
    request.fields['password'] = password!;

    request.files.add(await http.MultipartFile.fromPath('face_register', imageFile.path));

    var response = await request.send();

    if (response.statusCode == 200) {
      // Imagen enviada con éxito
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(const SnackBar(content: Text('Registro Exitoso!')));
    } else {
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(const SnackBar(content: Text('Error al registrar')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Captura Facial')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                CameraPreview(_controller!),
                ElevatedButton(
                  onPressed: _captureImage,
                  child: const Text('Capturar Imagen'),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
