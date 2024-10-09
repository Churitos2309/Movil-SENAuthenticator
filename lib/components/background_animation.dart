import 'dart:math';

import 'package:flutter/material.dart';
import 'package:particles_flutter/component/particle/particle.dart';
import 'package:particles_flutter/particles_engine.dart';

class BackgroundAnimation extends StatelessWidget {
  const BackgroundAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Positioned.fill(
      child: Particles(
        awayRadius: 150,
        particles: createParticles(),
        height: screenHeight,
        width: screenWidth,
        onTapAnimation: true,
        awayAnimationDuration: const Duration(milliseconds: 100),
        awayAnimationCurve: Curves.linear,
        enableHover: true,
        hoverRadius: 90,
        connectDots: false,
      ),
    );
  }

  List<Particle> createParticles() {
    var rng = Random();
    List<Particle> particles = [];
    for (int i = 0; i < 20; i++) {
      particles.add(Particle(
        color: Colors.green.withOpacity(0.6),
        size: rng.nextDouble() * 10,
        velocity: Offset(rng.nextDouble() * 50 * randomSign(),
            rng.nextDouble() * 50 * randomSign()),
      ));
    }
    return particles;
  }

  double randomSign() {
    var rng = Random();
    return rng.nextBool() ? 1 : -1;
  }
}
