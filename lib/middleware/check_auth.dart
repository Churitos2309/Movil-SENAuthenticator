import 'package:flutter/material.dart';
import 'package:reconocimiento_app/ui/router.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: unused_element
Future<void> _checkAuth(BuildContext context, String route) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (!prefs.containsKey('token')) {
    if (context.mounted) {
      Navigator.pushReplacementNamed(context, Routes.login);
    }
  } else {
    if (context.mounted) {
      Navigator.pushNamed(context, route);
    }
  }
}
