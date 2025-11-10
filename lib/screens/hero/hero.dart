import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  double _scale = 1.0;

  void _onPointerSignal(PointerSignalEvent event) {
    if (event is PointerScrollEvent) {
      final delta = event.scrollDelta.dy;
      setState(() {
        // Scroll up (zoom in) => delta < 0
        // Scroll down (zoom out) => delta > 0
        _scale = (_scale - delta * 0.001).clamp(1.0, 1.25);
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerSignal: _onPointerSignal,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
        child: Column(
          children: [
            Transform.scale(
              scale: _scale,
              alignment: Alignment.center,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Image.asset(
                    'assets/images/pf_profile.png',
                    height: 600,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: const [0.0, 0.1, 0.2, 0.4, 0.6, 1.0],
                          colors: [
                            Colors.transparent,
                            Color(0xffF7F7F7).withOpacity(0.1),
                            Color(0xffF7F7F7).withOpacity(0.2),
                            Color(0xffF7F7F7).withOpacity(0.6),
                            Color(0xffF7F7F7).withOpacity(0.8),
                            Color(0xffF7F7F7),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "I build beautiful mobile apps with Flutter and focus on clean, scalable UI/UX.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 60),
              child: Text(
                "I work closely with teams to turn ideas into fast, responsive cross-platform apps using modern tools and best practices.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
