import 'package:flutter/material.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 700,
      width: double.infinity,
      color: Colors.white,
      child: const Center(
        child: Text(
          "HERO SECTION (will add UI in Phase 2)",
          style: TextStyle(fontSize: 28),
        ),
      ),
    );
  }
}
