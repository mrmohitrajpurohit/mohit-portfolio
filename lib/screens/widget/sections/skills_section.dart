import 'package:flutter/material.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 700,
      width: double.infinity,
      color: Colors.white,
      child: const Center(
        child: Text(
          "SKILLS SECTION (Phase 6)",
          style: TextStyle(fontSize: 28),
        ),
      ),
    );
  }
}
