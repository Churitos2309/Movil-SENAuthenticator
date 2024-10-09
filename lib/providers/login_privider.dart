// import 'package:flutter/material.dart';
// import 'package:reconocimiento_app/lib/services/api_services.dart';

// class LoginProvider with ChangeNotifier {
//   String _numeroIdentificacion = '';
//   String _password = '';
//   final ApiService _apiService;

//   LoginProvider(this._apiService);

//   void setNumeroIdentificacion(String numeroIdentificacion) {
//     _numeroIdentificacion = numeroIdentificacion;
//     notifyListeners();
//   }

//   void setPassword(String password) {
//     _password = password;
//     notifyListeners();
//   }

//   Future<void> login() async {
//     try {
//       await _apiService.login(_numeroIdentificacion, _password);
//     } catch (e) {
//       print('Error en el login: $e');
//     }
//   }
// }