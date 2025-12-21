import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../data.dart';
import '../project_carousel_card.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 40),
      child: Column(
        children: [
          const Text(
            "Projects",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            "A combined showcase of my Web & Mobile development work — with live links and project visuals.",
            style: TextStyle(fontSize: 16, color: Colors.black87),
          ),
          const SizedBox(height: 35),

          _projectsGrid(),
        ],
      ),
    );
  }

  Widget _projectsGrid() {
    return LayoutBuilder(builder: (context, c) {
      int count = 1;
      if (c.maxWidth > 1200) count = 3;
      else if (c.maxWidth > 800) count = 2;

      return GridView.builder(
        shrinkWrap: true,
        itemCount: mergedProjects.length,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: count,
          mainAxisSpacing: 35,
          crossAxisSpacing: 24,
          childAspectRatio: 1.8,
        ),
        itemBuilder: (_, i) => ProjectCarouselCard(data: mergedProjects[i]),
      );
    });
  }
}
