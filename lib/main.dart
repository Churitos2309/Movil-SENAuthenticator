import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reconocimiento_app/providers/objetos_provider.dart';
import 'package:reconocimiento_app/providers/register_provider.dart';
import 'package:reconocimiento_app/services/api_services.dart';
import 'package:reconocimiento_app/services/auth_provider.dart';
import 'package:reconocimiento_app/services/scroll_provider.dart';
import 'package:reconocimiento_app/ui/router.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        // ChangeNotifierProvider<FacialRecognitionProvider>(
        //     create: (_) => FacialRecognitionProvider(ApiService())),
        // ChangeNotifierProvider<FacialLoginProvider>(
        //     create: (_) => FacialLoginProvider(ApiService())),
        ChangeNotifierProvider<ScrollProvider>(create: (_) => ScrollProvider()),
        ChangeNotifierProvider<ObjetosProvider>(
            create: (_) => ObjetosProvider(ApiService())),
        ChangeNotifierProvider<RegisterProvider>(
            create: (_) => RegisterProvider(ApiService())),
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),

        // Otros proveedores
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SENAuthenticator',
      theme: ThemeData(
        iconTheme: const IconThemeData(color: Color.fromRGBO(40, 40, 40, 1)),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/baseAprendiz',
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
