import 'dart:io';

import 'package:flutter/material.dart';
import 'package:reconocimiento_app/services/api_services.dart';

class FacialLoginProvider with ChangeNotifier {
  final ApiService _apiService;
  bool _isLoading = false;

  FacialLoginProvider(this._apiService);

  bool get isLoading => _isLoading;

  Future<Map<String, dynamic>> loginFace({
    required File faceImage,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.loginFace(
        faceImage: faceImage,
      );
      return response;
    } catch (e) {
      throw Exception('Error en el inicio de sesión facial: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}