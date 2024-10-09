import 'package:flutter/material.dart';
import 'package:reconocimiento_app/services/api_services.dart';
import 'package:reconocimiento_app/ui/pages/aprendiz/historial_page_aprendiz.dart';
import 'package:reconocimiento_app/ui/pages/aprendiz/objetos_page.dart';
import 'package:reconocimiento_app/ui/pages/captura_facial.dart';
import 'package:reconocimiento_app/ui/pages/home_admin.dart';
import 'package:reconocimiento_app/ui/pages/home_aprendiz.dart';
import 'package:reconocimiento_app/ui/pages/home_instructor.dart';
import 'package:reconocimiento_app/ui/pages/home_page.dart';
import 'package:reconocimiento_app/ui/pages/login/login_screen.dart';
import 'package:reconocimiento_app/ui/pages/mi_camera_page.dart';
import 'package:reconocimiento_app/ui/pages/perfil.dart';
import 'package:reconocimiento_app/ui/pages/register/register_screen.dart';
import 'package:reconocimiento_app/ui/pages/registro_facial.dart/registro_facial_page.dart';

class Routes {
  static const String home = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String registroFacial = '/facial-recognition';
  static const String inicioSesionFacial = '/inicio-sesion-facial';
  static const String objetos = '/objetos';
  static const String aprendiz = '/aprendiz';
  static const String perfil = '/perfil';
  static const String configuracion = '/configuracion';
  static const String homeAprendiz = '/homeAprendiz';
  static const String historial = '/historial';
  static const String baseAprendiz = '/baseAprendiz';
  static const String baseAdmin = '/baseAdmin';
  static const String baseInstructor = '/baseInstructor';
  static const String camera = '/camera';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case login:
        return MaterialPageRoute(
            builder: (_) => LoginScreen(apiService: ApiService()));
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case registroFacial:
        return MaterialPageRoute(builder: (_) => RegisterFacePage(apiService: ApiService()));
      case inicioSesionFacial:
        return MaterialPageRoute(builder: (_) => const CapturaFacial());
      case aprendiz:
        final args = (settings.arguments as Map<String, dynamic>)
            .map((key, value) => MapEntry(key, value.toString()));
        return MaterialPageRoute(
            builder: (_) => ProfilePage(
                  userData: args,
                ));
      case objetos:
        return MaterialPageRoute(builder: (_) => const ObjetosAprendizPage());
      case homeAprendiz:
        return MaterialPageRoute(builder: (_) => const HomeAprendiz());
      case historial:
        return MaterialPageRoute(builder: (_) => const HistorialAprendizPage());
      case perfil:
        final args = (settings.arguments as Map<String, dynamic>?);
        final userData = args?.map((key, value) => MapEntry(key, value.toString()),) ?? {};
            // .map((key, value) => MapEntry(key, value.toString()));
        return MaterialPageRoute(
            builder: (_) => ProfilePage(
                  userData: userData,
                ));
      case baseAprendiz:
        return MaterialPageRoute(builder: (_) => const HomeAprendiz());
      case baseAdmin:
        return MaterialPageRoute(builder: (_) => const HomeAdmin());
      case baseInstructor:
        return MaterialPageRoute(builder: (_) => const HomeInstructor());
      case camera:
        return MaterialPageRoute(builder: (_) => const MyCameraPage());
      default:
        return MaterialPageRoute(builder: (_) => const HomePage());
    }
  }
}
