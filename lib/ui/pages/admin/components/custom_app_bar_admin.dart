import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reconocimiento_app/services/auth_provider.dart';
import 'package:reconocimiento_app/ui/router.dart';

class CustomAppBarAdmin extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBarAdmin({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppBar(centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF27A900), // Verde institucional
        shadowColor: const Color(0xFF27A900),
        title: Row(
          children: [
            const ImageIcon(
              AssetImage('images/login/LogoReconocimientoFacialBlanco.png'),
              color: Colors.white,
            ),
            const SizedBox(width: 10),
            Flexible(
              fit: FlexFit.loose,
              child: Text(
                title,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        actions: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  // Navegar a la página de perfil al hacer clic en el avatar
                  Navigator.pushNamed(context, Routes.perfil);
                },
                child: const CircleAvatar(
                  backgroundImage: AssetImage('images/login/LogoReconocimientoFacialBlanco.png'),
                ),
              ),
              PopupMenuButton<String>(
                onSelected: (String result) {
                  switch (result) {
                    case 'Perfil':
                      Navigator.pushNamed(context, Routes.perfil);
                      break;
                    case 'Configuraciones':
                      Navigator.pushNamed(context, Routes.configuracion);
                      break;
                    case 'Salir':
                      Provider.of<AuthProvider>(context, listen: false).logout();
                      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                      break;
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'Perfil',
                    child: Text('Perfil'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'Configuraciones',
                    child: Text('Configuraciones'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'Salir',
                    child: Text('Salir'),
                  ),
                ],
                icon: const Icon(Icons.arrow_drop_down), // Flechita para desplegar el menú
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}