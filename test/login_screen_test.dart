// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:http/http.dart' as http;
// import 'package:mockito/mockito.dart';
// import 'package:reconocimiento_app/services/api_services.dart';
// import 'package:reconocimiento_app/ui/pages/login/login_screen.dart';


// class MockHttpClient extends Mock implements http.Client {
//   @override
//   Future<http.Response> post(
//     Uri url, {
//     Map<String, String>? headers,
//     Object? body,
//     Encoding? encoding,
//   // }) 
//     return Future.value(http.Response('{"token": "fake_token", "user": {"rol_usuario": "Administrador"}}', 200));
//   }
// }

// void main() {
//   group('LoginScreen Tests', () {
//     testWidgets('Verifica si los campos de cédula y contraseña existen', (WidgetTester tester) async {
//       await tester.pumpWidget(MaterialApp(home: LoginScreen(apiService: ApiService())));

//       expect(find.byKey(const Key('identificacionInput')), findsOneWidget);
//       expect(find.byKey(const Key('passwordInput')), findsOneWidget);
//     });

//     testWidgets('Mostrar error si los campos están vacíos', (WidgetTester tester) async {
//       await tester.pumpWidget(MaterialApp(home: LoginScreen(apiService: ApiService())));

//       await tester.tap(find.byType(ElevatedButton));
//       await tester.pump();

//       expect(find.text('Por favor, ingrese su numero de cédula'), findsOneWidget);
//       expect(find.text('Por favor, ingrese su contraseña'), findsOneWidget);
//     });

//     test('Simula un inicio de sesión exitoso', () async {
//       final mockHttpClient = MockHttpClient();
//       final apiService = ApiService(client: mockHttpClient);
      
//       final result = await apiService.post('inicioSesionFacial/', {'username': 'user', 'password': 'password'});
      
//       expect(result['token'], 'fake_token');
//       expect(result['user']['rol_usuario'], 'Administrador');
//     });

//   });
// }
