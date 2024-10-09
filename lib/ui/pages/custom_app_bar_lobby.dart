import 'package:flutter/material.dart';
import 'package:reconocimiento_app/ui/router.dart';

class CustomAppBarLobby extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppBarLobby({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xFF27A900), // Verde institucional
      shadowColor: const Color(0xFF27A900),
      title: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Routes.registroFacial);
            },
            child: const ImageIcon(
              AssetImage('images/login/LogoReconocimientoFacialBlanco.png'),
              color: Colors.white,
              size: 35,
            ),
          ),
          const SizedBox(width: 10),
          
          Flexible(
              fit: FlexFit.loose,
              child: Text(title, style: const TextStyle(color: Colors.white))),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.login);
          },
          style: ButtonStyle(
            backgroundColor:
                WidgetStateProperty.all(const Color(0xFF3C8DBC)), // Azul claro
          ),
          child: const Text(
            'ACCESO',
            style: TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(width: 7),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.register);
          },
          style: ButtonStyle(
            backgroundColor:
                WidgetStateProperty.all(const Color(0xFF3C8DBC)), // Azul claro
          ),
          child: const Text(
            'REGISTRO',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
