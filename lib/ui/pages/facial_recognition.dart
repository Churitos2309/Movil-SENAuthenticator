// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import 'package:reconocimiento_app/providers/facial_recognite_provider.dart';
// import 'package:reconocimiento_app/services/api_services.dart';

// class FacialRecognitionPage extends StatefulWidget {
  

//   final ApiService apiService;

//   const FacialRecognitionPage(this.apiService, {super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _FacialRecognitionPageState createState() => _FacialRecognitionPageState();
// }

// class _FacialRecognitionPageState extends State<FacialRecognitionPage> {
//   File? _image;
//   final ImagePicker _picker = ImagePicker();
//   final TextEditingController _nombreCompletoController = TextEditingController();
//   final TextEditingController _numeroDocumentoController = TextEditingController();

//   Future<void> _pickImage() async {
//     try {
//       final pickedFile = await _picker.pickImage(
//         source: ImageSource.camera,
//         imageQuality: 20,
//       );
//       if (pickedFile != null) {
//         setState(() {
//           _image = File(pickedFile.path);
//         });
//       }
//     } catch (e) {
//       print('Error al seleccionar la imagen: $e');
//     }
//   }

//   Future<void> _registerFace() async {
//     if (_image == null) {
//       _showMessage('Por favor, selecciona una imagen.');
//       return;
//     }

//     final provider = Provider.of<FacialRecognitionProvider>(context, listen: false);
//     await provider.registerFace(
//       nombreCompleto: _nombreCompletoController.text,
//       numeroDocumento: _numeroDocumentoController.text,
//       faceImage: _image!,
//     );
//   }

//   void _showMessage(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<FacialRecognitionProvider>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Registro Facial'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _nombreCompletoController,
//               decoration: const InputDecoration(labelText: 'Nombre Completo'),
//             ),
//             TextField(
//               controller: _numeroDocumentoController,
//               decoration: const InputDecoration(labelText: 'Número de Documento'),
//             ),
//             const SizedBox(height: 16),
//             _image == null
//                 ? const Text('No se ha seleccionado ninguna imagen.')
//                 : Image.file(_image!),
//             const SizedBox(height: 16),
//             Flexible(
//               fit: FlexFit.loose,
//               child: ElevatedButton(
//                 onPressed: _pickImage,
//                 child: const Text('Seleccionar Imagen'),
//               ),
//             ),
//             const SizedBox(height: 16),
//             provider.isLoading
//                 ? const CircularProgressIndicator()
//                 : ElevatedButton(
//                     onPressed: _registerFace,
//                     child: const Text('Registrar Rostro'),
//                   ),
//           ],
//         ),
//       ),
//     );
//   }
// }