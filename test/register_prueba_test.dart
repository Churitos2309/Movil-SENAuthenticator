// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';

// // Asume que tienes una clase MyApp que envuelve el widget MaterialApp proporcionado.
// void main() {
//   group('Pruebas de Widget para la pantalla de registro', () {
//     testWidgets('Debe de mostrar los campos del formulario de registro', (WidgetTester tester) async {
//       // Cargar el widget en el entorno de pruebas
//       await tester.pumpWidget(MaterialApp(
//         home: SafeArea(
//           child: Scaffold(
//             backgroundColor: const Color.fromARGB(255, 10, 10, 10),
//             body: Form(
//               child: Column(
//                 children: [
//                   TextFormField(
//                     key: const Key('nombreTextFormField'),
//                     decoration: const InputDecoration(labelText: 'Nombre'),
//                   ),
//                   TextFormField(
//                     key: const Key('emailTextFormField'),
//                     decoration: const InputDecoration(labelText: 'Correo Electrónico'),
//                   ),
//                   TextFormField(
//                     key: const Key('passwordTextFormField'),
//                     decoration: const InputDecoration(labelText: 'Contraseña'),
//                     obscureText: true,
//                   ),
//                   ElevatedButton(
//                     key: const Key('registerButton'),
//                     onPressed: () {},
//                     child: const Text('Registrarse'),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ));

//       // Verificar si los campos de texto existen
//       expect(find.byKey(const Key('nombreTextFormField')), findsOneWidget);
//       expect(find.byKey(const Key('emailTextFormField')), findsOneWidget);
//       expect(find.byKey(const Key('passwordTextFormField')), findsOneWidget);
//       expect(find.byKey(const Key('registerButton')), findsOneWidget);
//     });

//     testWidgets('Deberia mostrar un error si el nombre esta vacio', (WidgetTester tester) async {
//       final _formKey = GlobalKey<FormState>();

//       // Cargar el widget con un formulario
//       await tester.pumpWidget(MaterialApp(
//         home: SafeArea(
//           child: Scaffold(
//             body: Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   TextFormField(
//                     key: const Key('nombreTextFormField'),
//                     decoration: const InputDecoration(labelText: 'Nombre'),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Por favor, ingrese su nombre';
//                       }
//                       return null;
//                     },
//                   ),
//                   ElevatedButton(
//                     key: const Key('registerButton'),
//                     onPressed: () {
//                       _formKey.currentState?.validate();
//                     },
//                     child: const Text('Registrarse'),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ));

//       // Intentar presionar el botón de registro
//       await tester.tap(find.byKey(const Key('registerButton')));
//       await tester.pump();

//       // Verificar si aparece el mensaje de error
//       expect(find.text('Por favor, ingrese su nombre'), findsOneWidget);
//     });

//     testWidgets('Debe mostrarse el indicador de carga al registrarse', (WidgetTester tester) async {
//       bool _isLoading = true;

//       // Cargar el widget
//       await tester.pumpWidget(MaterialApp(
//         home: SafeArea(
//           child: Scaffold(
//             body: Column(
//               children: [
//                 _isLoading
//                     ? const CircularProgressIndicator()
//                     : ElevatedButton(
//                         key: const Key('registerButton'),
//                         onPressed: () {},
//                         child: const Text('Registrarse'),
//                       ),
//               ],
//             ),
//           ),
//         ),
//       ));

//       // Verificar si el indicador de progreso está visible
//       expect(find.byType(CircularProgressIndicator), findsOneWidget);
//     });
//   });
// }
