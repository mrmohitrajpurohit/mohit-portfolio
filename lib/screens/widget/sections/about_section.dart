import 'package:flutter/material.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 700,
      width: double.infinity,
      color: Colors.grey.shade100,
      child: const Center(
        child: Text(
          "ABOUT SECTION (Phase 3)",
          style: TextStyle(fontSize: 28),
        ),
      ),
    );
  }
}
