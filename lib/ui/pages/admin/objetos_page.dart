import 'package:flutter/material.dart';
import 'Panel/panel.dart';

class ObjetosAdminPage extends StatefulWidget {
  const ObjetosAdminPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ObjetosAdminPageState createState() => _ObjetosAdminPageState();
}

class _ObjetosAdminPageState extends State<ObjetosAdminPage> {

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView( // Envuelve todo el contenido en un scroll
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Componente Panel (con texto y tabla)
              Panel(),
              // const SizedBox(height: 16),
              // // Componente Resumen
              // const Resumen(),
            ],
          ),
        ),
      ),
    );
  }
}
