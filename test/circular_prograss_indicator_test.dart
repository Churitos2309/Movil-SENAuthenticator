// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';

// // Suponiendo que este es el LoginScreen que quieres probar
// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   bool _isLoading = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: _isLoading
//             ? CircularProgressIndicator()
//             : ElevatedButton(
//                 onPressed: () {
//                   setState(() {
//                     _isLoading = true;
//                   });
//                 },
//                 child: Text('Login'),
//               ),
//       ),
//     );
//   }
// }

// void main() {
//   testWidgets('Deberia mostrar CircularProgressIndicator al cargar', (WidgetTester tester) async {
//     // Construir el widget dentro de una MaterialApp para pruebas
//     await tester.pumpWidget(
//       MaterialApp(
//         home: LoginScreen(),
//       ),
//     );

//     // Verificar que inicialmente no haya CircularProgressIndicator
//     expect(find.byType(CircularProgressIndicator), findsNothing);

//     // Simular presionar el botón para activar el estado de carga
//     await tester.tap(find.byType(ElevatedButton));

//     // Renderizar nuevamente para reflejar los cambios de estado
//     await tester.pump();

//     // Verificar que el CircularProgressIndicator se muestra
//     expect(find.byType(CircularProgressIndicator), findsOneWidget);
//   });
  
// }
