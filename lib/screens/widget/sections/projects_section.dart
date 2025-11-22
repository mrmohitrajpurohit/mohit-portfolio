import 'package:flutter/material.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 700,
      width: double.infinity,
      color: Colors.white,
      child: const Center(
        child: Text(
          "PROJECTS SECTION (Phase 4)",
          style: TextStyle(fontSize: 28),
        ),
      ),
    );
  }
}
