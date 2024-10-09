import 'package:flutter/material.dart';
import 'package:reconocimiento_app/ui/pages/admin/admin_page.dart';
class HomeAdmin extends StatelessWidget {
  const HomeAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return const AdminPage(
      body: Center(
        child: Text('Esta es la página de inicio'),
      ),
      currentIndex: 0,
    );
  }
}