import 'package:flutter/material.dart';

class AIWorkSection extends StatelessWidget {
  const AIWorkSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 700,
      width: double.infinity,
      color: Colors.grey.shade100,
      child: const Center(
        child: Text(
          "AI WORK SECTION (Phase 5)",
          style: TextStyle(fontSize: 28),
        ),
      ),
    );
  }
}
