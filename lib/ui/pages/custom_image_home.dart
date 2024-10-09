import 'package:flutter/material.dart';

class CustomBorderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width * 0.3, 0);
    path.lineTo(size.width * 0.7, 0);
    path.quadraticBezierTo(size.width, size.height * 0.29, size.width, size.height * 0.7);
    path.lineTo(size.width, size.height * 0.71);
    path.quadraticBezierTo(size.width * 0.7, size.height, size.width * 0.3, size.height);
    path.lineTo(size.width * 0.3, size.height);
    path.quadraticBezierTo(0, size.height * 0.71, 0, size.height * 0.3);
    path.lineTo(0, size.height * 0.29);
    path.quadraticBezierTo(size.width * 0.3, 0, size.width * 0.3, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class CustomImageHome extends StatelessWidget {
  const CustomImageHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // ClipPath(
          //   clipper: CustomBorderClipper(),
          //   child: Container(
          //     width: MediaQuery.of(context).size.width * 0.9,
          //     height: MediaQuery.of(context).size.height * 0.55,
          //     color: const Color(0xFF22C55E)
          //   ),
          // ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Image.asset(
              'images/img/ReconocimientoFacial.webp',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}