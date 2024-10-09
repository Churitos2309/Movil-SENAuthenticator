// import 'dart:io';

// import 'package:flutter/foundation.dart';
// import 'package:reconocimiento_app/services/api_services.dart';

// class FacialRecognitionProvider with ChangeNotifier {
//   final ApiService _apiService;
//   bool _isLoading = false;

//   FacialRecognitionProvider(this._apiService);

//   bool get isLoading => _isLoading;

//   Future<void> registerFace({
//     required String nombreCompleto,
//     required String numeroDocumento,
//     required File faceImage,
//   }) async {
//     _isLoading = true;
//     notifyListeners();

//     try {
//       final response = await _apiService.registerFace(
//         nombreCompleto: nombreCompleto,
//         numeroDocumento: numeroDocumento,
//         faceImage: faceImage,
//       );
//       if (kDebugMode) {
//         print('Registro exitoso: $response');
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         print('Error en el registro facial: $e');
//       }
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
// }